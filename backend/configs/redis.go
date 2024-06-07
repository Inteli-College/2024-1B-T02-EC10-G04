package configs

import (
	"context"
	"log"
	"os"

	"github.com/redis/go-redis/v9"
)

func SetupRedis() *redis.Client {
	rdpass := os.Getenv("REDIS_PASSWORD")

	if rdpass == "" {
		log.Fatal("REDIS_PASSWORD variable not defined")
	}

	rdb := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379", // Endereço do servidor Redis
		Password: rdpass,           // Senha, se não houver senha deixar vazio
		DB:       0,                // Número do banco de dados
	})

	// Testar a conexão
	_, err := rdb.Ping(context.Background()).Result()
	if err != nil {
		log.Fatalf("Não foi possível conectar ao Redis: %v", err)
	}

	return rdb
}
