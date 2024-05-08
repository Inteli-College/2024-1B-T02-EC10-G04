package entity

import (
	"time"

	"github.com/docker/distribution/uuid"
)

type OrderRepository interface {
	FindAllOrders() ([]*Order, error)
	FindOrderByID(id string) (*Order, error)
	CreateOrder(order *Order) (*Order, error)
	UpdateOrder(order *Order) error
	DeleteOrder(id string) error
}

type Order struct {
	ID          string    `json:"id"`
	Priority    int       `json:"priority"`
	User_ID     uuid.UUID `json:"user_id"`
	Observation string    `json:"observation"`
	Status      int       `json:"status"`
	Medicine_ID uuid.UUID `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
	CreatedAt   time.Time `json:"created_at"`
	UpdatedAt   time.Time `json:"updated_at"`
}

func NewOrder(priority int, user_id uuid.UUID, observation string, status int, medicine_id uuid.UUID, quantity int) *Order {
	return &Order{
		Priority:    priority,
		User_ID:     user_id,
		Observation: observation,
		Status:      status,
		Medicine_ID: medicine_id,
		Quantity:    quantity,
	}
}
