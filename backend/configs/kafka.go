package configs

import (
	"os"
	ckafka "github.com/confluentinc/confluent-kafka-go/v2/kafka"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/kafka"
)

func SetupKafkaProducer() *kafka.KafkaProducer {
	producerConfigMap := &ckafka.ConfigMap{
		"bootstrap.servers": os.Getenv("KAFKA_BOOTSTRAP_SERVER"),
		"client.id":         os.Getenv("KAFKA_CLIENT_ID"),
	}
	kafkaProducer := kafka.NewKafkaProducer(producerConfigMap)
	return kafkaProducer
}