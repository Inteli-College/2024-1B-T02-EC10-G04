package config

import (
	"github.com/jmoiron/sqlx"
	_ "github.com/lib/pq"
	"log"
	"os"
)

func SetupPostgres() *sqlx.DB {
	connStr := os.Getenv("POSTGRES_URL")
	if connStr == "" {
		log.Fatal("DB_URL is not set")
	}

	db, err := sqlx.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}

	err = db.Ping()
	if err != nil {
		log.Fatalf("Error connecting to the database: %v", err)
	}

	return db
}
