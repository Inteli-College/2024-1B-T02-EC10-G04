package main

import (
	"log"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/configs"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/repository"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/web/handler"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/web/middleware"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func init() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
}

func main() {
	db := config.SetupPostgres()

	defer db.Close()

	router := gin.Default()
	router.Use(gin.Logger())
	router.Use(gin.Recovery())

	api := router.Group("/api/v1")
	api.Use(middleware.AuthMiddleware())

	///////////////////////// User ///////////////////////////

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

	///////////////////////// Pyxis ///////////////////////////

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
	router.Run()
}
