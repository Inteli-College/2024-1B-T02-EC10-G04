package entity

import (
	"time"
)

type OrderRepository interface {
	CreateOrder(order *Order) (*Order, error)
	FindOrderById(id string) (*Order, error)
	FindAllOrders() ([]*Order, error)
	UpdateOrder(order *Order) (*Order, error)
	DeleteOrder(id string) error
}

type Order struct {
	ID          string    `json:"id" db:"id"`
	Priority    int       `json:"priority" db:"priority"`
	User_ID     string    `json:"user_id" db:"user_id"`
	Observation string    `json:"observation" db:"observation"`
	Status      int       `json:"status" db:"status"`
	Medicine_ID string    `json:"medicine_id" db:"medicine_id"`
	Quantity    int       `json:"quantity" db:"quantity"`
	CreatedAt   time.Time `json:"created_at" db:"created_at"`
	UpdatedAt   time.Time `json:"updated_at" db:"updated_at"`
}

func NewOrder(priority int, user_id string, observation string, medicine_id string, quantity int) *Order {
	return &Order{
		Priority:    priority,
		User_ID:     user_id,
		Observation: observation,
		Medicine_ID: medicine_id,
		Quantity:    quantity,
	}
}
