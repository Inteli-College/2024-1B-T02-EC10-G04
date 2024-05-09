package configs

import (
	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"os"
)

func SetupConfig() *ckafka.ConfigMap {
	producerConfigMap := &ckafka.ConfigMap{
		"bootstrap.servers": os.Getenv("KAFKA_BOOTSTRAP_SERVER"),
		"client.id":         os.Getenv("KAFKA_CLIENT_ID"),
	}
	return producerConfigMap
}
