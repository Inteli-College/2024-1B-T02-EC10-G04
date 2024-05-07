package main

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/database"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/app/repository"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/app/usecase"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/app/web/handlers"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func init() {
	logger.Init()
	err := godotenv.Load()
	if err != nil {
		logger.Log.Fatal("Error loading .env file")
	}
}

func main() {
	logger.Log.Info("Starting the application...")
	db := database.SetupDatabase()

	userRepository := repository.NewUserRepository(db)
	userService := usecase.NewUserUsecase(userRepository)
	userHandler := handlers.NewUserHandler(userService)

	router := gin.Default()
	router.Use(gin.Logger())
	router.Use(gin.Recovery())

	api := router.Group("/api")
	{
		routerGroup := api.Group("/users")
		{
			routerGroup.GET("/:id", userHandler.GetUser)
			routerGroup.POST("/", userHandler.CreateUser)
			routerGroup.GET("/", userHandler.GetUsers)
		}
	}

	router.Run() // por padrão, o Gin roda na porta 8080
}
