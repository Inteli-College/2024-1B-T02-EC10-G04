package main

import (
	"log"
	"net/http"
	"os"

	_ "github.com/Inteli-College/2024-1B-T02-EC10-G04/api"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/configs"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/kafka"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/repository"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/web/handler"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/web/middleware"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	// "log"
)

// Please use .env file for local development. After that, please comment out the lines below,
// their dependencies as well, and update the go.mod file with command $ go mod tidy.

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
}

//	@title	Devices Api Server
//	@version	1.0
//	@description	This is the devolt api server to manage devices.
//	@termsOfService	http://swagger.io/terms/

//	@contact.name	DeVolt Team
//	@contact.url	https://devolt.xyz
//	@contact.email	henrique@mugen.builders

//	@license.name	Apache 2.0
//	@license.url	http://www.apache.org/licenses/LICENSE-2.0.html

// @host	localhost:8080
// @BasePath	/api/v1
// @query.collection.format multi
func main() {

	/////////////////////// Configs /////////////////////////

	db := configs.SetupPostgres()
	defer db.Close()

	///////////////////////// Gin ///////////////////////////

	router := gin.Default()
	router.Use(gin.Logger())
	router.Use(gin.Recovery())

	api := router.Group("/api/v1")
	api.Use(middleware.AuthMiddleware())

	api.GET("/docs/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	///////////////////// Healthcheck //////////////////////

	//TODO: "http://localhost:8080/api/healthz" is the best pattern for healthcheck?

	router.GET("/api/v1/healthz", func(c *gin.Context) {
		log.Printf("Server received a healthcheck request")
		c.JSON(http.StatusOK, gin.H{"status": "success"})
	})

	//////////////////////// User ///////////////////////////

	userRepository := repository.NewUserRepositoryPostgres(db)
	userUseCase := usecase.NewUserUseCase(userRepository)
	userHandlers := handler.NewUserHandlers(userUseCase)

	{
		userGroup := api.Group("/users")
		{
			userGroup.POST("", userHandlers.CreateUser)
			userGroup.GET("", userHandlers.FindAllUsersHandler)
			userGroup.GET("/:id", userHandlers.FindUserByIdHandler)
			userGroup.PUT("/:id", userHandlers.UpdateUserHandler)
			userGroup.DELETE("/:id", userHandlers.DeleteUserHandler)
		}
	}

	/////////////////////// Pyxis /////////////////////////

	pyxisRepository := repository.NewPyxisRepositoryPostgres(db)
	pyxisUseCase := usecase.NewPyxisUseCase(pyxisRepository)
	pyxisHandlers := handler.NewPyxisHandlers(pyxisUseCase)

	{
		pyxisGroup := api.Group("/pyxis")
		{
			pyxisGroup.POST("", pyxisHandlers.CreatePyxisHandler)
			pyxisGroup.GET("", pyxisHandlers.FindAllPyxisHandler)
			pyxisGroup.GET("/:id", pyxisHandlers.FindPyxisByIdHandler)
			pyxisGroup.PUT("/:id", pyxisHandlers.UpdatePyxisHandler)
			pyxisGroup.DELETE("/:id", pyxisHandlers.DeletePyxisHandler)
		}
	}

	/////////////////////// Order /////////////////////////

	orderProducerConfigMap := &ckafka.ConfigMap{
		"bootstrap.servers": os.Getenv("KAFKA_BOOTSTRAP_SERVER"),
		"client.id":         os.Getenv("KAFKA_ORDERS_CLIENT_ID"),
	}
	kafkaProducerRepository := kafka.NewKafkaProducer(orderProducerConfigMap)

	orderRepository := repository.NewOrderRepositoryPostgres(db)
	orderUseCase := usecase.NewOrderUseCase(orderRepository)
	orderHandlers := handler.NewOrderHandlers(orderUseCase, kafkaProducerRepository)

	{
		orderGroup := api.Group("/orders")
		{
			orderGroup.POST("", orderHandlers.CreateOrderHandler)
			orderGroup.GET("", orderHandlers.FindAllOrdersHandler)
			orderGroup.GET("/:id", orderHandlers.FindOrderByIdHandler)
			orderGroup.PUT("/:id", orderHandlers.UpdateOrderHandler)
			orderGroup.DELETE("/:id", orderHandlers.DeleteOrderHandler)
		}
	}

	///////////////////////// Medicine ///////////////////////////

	medicineRepository := repository.NewMediceRepositoryPostgres(db)
	medicineUseCase := usecase.NewMedicineUseCase(medicineRepository)
	medicineHandlers := handler.NewMedicineHandlers(medicineUseCase)

	{
		medicineGroup := api.Group("/medicines")
		{
			medicineGroup.POST("", medicineHandlers.CreateMedicineHandler)
			medicineGroup.GET("", medicineHandlers.FindAllMedicinesHandler)
			medicineGroup.GET("/:id", medicineHandlers.FindMedicineByIdHandler)
			medicineGroup.PUT("/:id", medicineHandlers.UpdateMedicineHandler)
			medicineGroup.DELETE("/:id", medicineHandlers.DeleteMedicineHandler)
		}
	}

	router.Run(":8080")
}
