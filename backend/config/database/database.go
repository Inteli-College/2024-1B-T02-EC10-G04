package database

import (
	"database/sql"
	"fmt"

	"os"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	_ "github.com/lib/pq"
)

func SetupDatabase() *sql.DB {
	connStr := os.Getenv("DB_URL")
	if connStr == "" {
		logger.Log.Fatal("DB_URL is not set")
	}

	// Connect to database
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		logger.Log.Fatal(err)
	}

	// Check if the connection is working
	err = db.Ping()
	fmt.Println(err)
	if err != nil {
		logger.Log.Fatal("Error connecting to the database: ", err)
	}

	return db
}
