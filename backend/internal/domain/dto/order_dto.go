package dto

import "time"

type CreateOrderInputDTO struct {
	Priority    string `json:"priority"`
	User_ID     string `json:"user_id"`
	Observation string `json:"observation"`
	Medicine_ID string `json:"medicine_id"`
	Quantity    int    `json:"quantity"`
}

type FindOrderByIDInputDTO struct {
	ID string `json:"id"`
}

type UpdateOrderInputDTO struct {
	ID          string `json:"id"`
	Priority    string `json:"priority"`
	Observation string `json:"observation"`
	Status      string `json:"status"`
	Medicine_ID string `json:"medicine_id"`
	Quantity    int    `json:"quantity"`
}

type DeleteOrderInputDTO struct {
	ID string `json:"id"`
}

type CreateOrderOutputDTO struct {
	ID          string    `json:"id"`
	Priority    string    `json:"priority"`
	User_ID     string    `json:"user_id"`
	Observation string    `json:"observation"`
	Status      string    `json:"status"`
	Medicine_ID string    `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
	CreatedAt   time.Time `json:"created_at"`
}

type FindOrderOutputDTO struct {
	ID          string    `json:"id"`
	Priority    string    `json:"priority"`
	User_ID     string    `json:"user_id"`
	Observation string    `json:"observation"`
	Status      string    `json:"status"`
	Medicine_ID string    `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
	UpdatedAt   time.Time `json:"updated_at"`
	CreatedAt   time.Time `json:"created_at"`
}

type UpdateOrderOutputDTO struct {
	ID          string    `json:"id"`
	Priority    string    `json:"priority"`
	User_ID     string    `json:"user_id"`
	Observation string    `json:"observation"`
	Status      string    `json:"status"`
	Medicine_ID string    `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type DeleteOrderOutputDTO struct {
	ID string `json:"id"`
}
