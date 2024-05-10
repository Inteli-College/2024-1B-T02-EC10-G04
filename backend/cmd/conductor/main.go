package main

import (
	"encoding/json"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/configs"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/kafka"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/repository"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"github.com/gin-gonic/gin"
	"log"
	"net/http"
	"os"
	// "github.com/joho/godotenv"
	// "log"
)

// Please use .env file for local development. After that, please comment out the lines below,
// their dependencies as well, and update the go.mod file with command $ go mod tidy.

// func init() {
// 	err := godotenv.Load()
// 	if err != nil {
// 		log.Fatal("Error loading .env file")
// 	}
// }

func main() {

	/////////////////////// Configs /////////////////////////

	db := configs.SetupPostgres()
	defer db.Close()

	///////////////////// Healthcheck //////////////////////

	router := gin.Default()
	router.Use(gin.Logger())
	router.Use(gin.Recovery())

	//TODO: "http://localhost:8081/conductor/healthz" is the best pattern for healthcheck?

	router.GET("/conductor/healthz", func(c *gin.Context) {
		log.Printf("Consumer received a healthcheck request")
		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})
	go router.Run(":8081")

	//////////////////////// Orders Consumer //////////////////////////

	msgChan := make(chan *ckafka.Message)

	consumerConfigMap := &ckafka.ConfigMap{
		"bootstrap.servers":  os.Getenv("KAFKA_BOOTSTRAP_SERVER"),
		"session.timeout.ms": 6000,
		"group.id":           os.Getenv("KAFKA_ORDERS_GROUP_ID"),
		"auto.offset.reset":  "latest",
	}

	kafkaConsumerRepository := kafka.NewKafkaConsumer([]string{os.Getenv("KAFKA_ORDERS_TOPIC_NAME")}, consumerConfigMap)
	orderRepository := repository.NewOrderRepositoryPostgres(db)
	ordersUseCase := usecase.NewOrderUseCase(orderRepository)

	go func() {
		if err := kafkaConsumerRepository.Consume(msgChan); err != nil {
			log.Printf("Error consuming kafka queue: %v", err)
		}
	}()

	for msg := range msgChan {
 		var orderInputDTO dto.CreateOrderInputDTO
		err := json.Unmarshal(msg.Value, &orderInputDTO)
		if err != nil {
			log.Printf("Error decoding message: %v", err)
		}
		res, err := ordersUseCase.CreateOrder(&orderInputDTO)
		if err != nil {
			log.Printf("Error creating order entity: %v", err)
		}
		log.Printf("Order created with id: %s", res.ID)
	}
}
