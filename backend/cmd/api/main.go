package main

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/database"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/adapters/http"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/adapters/repository/sql"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/app"
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
	userRepository := sql.NewUserRepository(db)
	userService := app.NewUserService(userRepository)
	router := http.NewGinRouter(userService)

	router.Run() // por padrão, o Gin roda na porta 8080
}
