package database

import (
	"database/sql"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	_ "github.com/lib/pq"
)

func SetupDatabase() *sql.DB {
	connStr := "postgresql://<username>:<password>@da/todos?sslmode=disable"
	// Connect to database
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		logger.Log.Fatal(err)
	}
	return db
}
