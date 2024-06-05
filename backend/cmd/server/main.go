package main

import (
	"log"
	"os"

	_ "github.com/Inteli-College/2024-1B-T02-EC10-G04/api"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/configs"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/kafka"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/repository"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/web/handler"
	"github.com/joho/godotenv"

	// "github.com/joho/godotenv"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/web/middleware"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
	// "github.com/joho/godotenv"
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

//	@title			Manager API
//	@version		1.0
//	@description	This is a.
//	@termsOfService	http://swagger.io/terms/

//	@contact.name	Manager API Support
//	@contact.url	https://github.com/Inteli-College/2024-1B-T02-EC10-G04
//	@contact.email	gomedicine@inteli.edu.br

//	@license.name	Apache 2.0
//	@license.url	http://www.apache.org/licenses/LICENSE-2.0.html

//	@host	localhost
//	@BasePath	/api/v1

// @SecurityDefinitions.apikey BearerAuth
// @in header
// @name Authorization
// @description "Type: Bearer token"
// @scheme bearer
// @bearerFormat JWT

func main() {
	/////////////////////// Configs /////////////////////////

	db := configs.SetupPostgres()
	defer db.Close()

	///////////////////////// Gin ///////////////////////////

	router := gin.Default()
	router.Use(gin.Logger())
	router.Use(gin.Recovery())
	router.Use(cors.New(cors.Config{
		AllowAllOrigins:  true, // TODO: change to false and make it for production
		AllowMethods:     []string{"PUT", "PATCH, POST, GET, OPTIONS, DELETE"},
		ExposeHeaders:    []string{"Content-Length"},
		AllowCredentials: true,
	}))

	api := router.Group("/api/v1")

	///////////////////// Swagger //////////////////////

	api.GET("/docs/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	///////////////////// Healthcheck //////////////////////

	// TODO: "http://localhost:8080/api/healthz" is the best pattern for healthcheck?

	router.GET("/api/v1/healthz", handler.HealthCheckHandler)

	//////////////////////// User ///////////////////////////

	userRepository := repository.NewUserRepositoryPostgres(db)
	userUseCase := usecase.NewUserUseCase(userRepository)
	userHandlers := handler.NewUserHandlers(userUseCase)

	{
		userGroup := api.Group("/users")
		{
			userGroup.POST("", userHandlers.CreateUser)
			userGroup.POST("/login", userHandlers.LoginUser)
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

		// Middleware apenas para motivos de demonstração (MUDAR DEPOIS)
		pyxisGroup.Use(middleware.AuthMiddleware(userRepository, "user"))
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

	err := router.Run(":8080")
	if err != nil {
		log.Fatal("Error running server:", err)
	}
}
