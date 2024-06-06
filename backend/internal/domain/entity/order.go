package entity

import (
	"time"
)

type OrderRepository interface {
	CreateOrder(order *Order) (*Order, error)
	FindOrderById(id string) (*OrderComplete, error)
	FindAllOrders() ([]*OrderComplete, error)
	UpdateOrder(order *OrderComplete) (*Order, error)
	DeleteOrder(id string) error
}

type Order struct {
	ID          string    `json:"id" db:"id"`
	Priority    string    `json:"priority" db:"priority"`
	User_ID     string    `json:"user_id" db:"user_id"`
	Observation string    `json:"observation" db:"observation"`
	Status      string    `json:"status" db:"status"`
	Medicine_ID string    `json:"medicine_id" db:"medicine_id"`
	Quantity    int       `json:"quantity" db:"quantity"`
	CreatedAt   time.Time `json:"created_at" db:"created_at"`
	UpdatedAt   time.Time `json:"updated_at" db:"updated_at"`
}

type OrderComplete struct {
	ID          string    `json:"id" db:"id"`
	Priority    string    `json:"priority" db:"priority"`
	Observation string    `json:"observation" db:"observation"`
	Status      string    `json:"status" db:"status"`
	Quantity    int       `json:"quantity" db:"quantity"`
	CreatedAt   time.Time `json:"created_at" db:"created_at"`
	UpdatedAt   time.Time `json:"updated_at" db:"updated_at"`
	User        User      `json:"user"`
	Medicine    Medicine  `json:"medicine"`
	Medicine_ID string    `json:"medicine_id" db:"medicine_id"`
	User_ID     string    `json:"user_id" db:"user_id"`
}

func NewOrder(priority string, user_id string, observation string, medicine_id string, quantity int) *Order {
	return &Order{
		Priority:    priority,
		User_ID:     user_id,
		Observation: observation,
		Medicine_ID: medicine_id,
		Quantity:    quantity,
	}
}
