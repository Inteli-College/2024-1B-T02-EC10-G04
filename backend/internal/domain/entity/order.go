package entity

import (
	"github.com/docker/distribution/uuid"
	"time"
)

type OrderRepository interface {
	FindAllOrders() ([]*Order, error)
	FindOrderByID(id string) (*Order, error)
	CreateOrder(order *Order) error
	UpdateOrder(order *Order) error
	DeleteOrder(id string) error
}

type Order struct {
	ID          string    `json:"id"`
	Priority    int       `json:"priority"`
	User_ID     uuid.UUID `json:"user_id"`
	Observation string    `json:"observation"`
	Status      int       `json:"status"`
	Medicine_ID string    `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}
