package dto

import (
	"github.com/docker/distribution/uuid"
	"time"
)

type CreateOrderInputDTO struct {
	Priority    int       `json:"priority"`
	User_ID     uuid.UUID `json:"user_id"`
	Observation string    `json:"observation"`
	Status      int       `json:"status"`
	Medicine_ID uuid.UUID `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
}

type FindOrderByIDInputDTO struct {
	ID string `json:"id"`
}

type UpdateOrderInputDTO struct {
	ID          string    `json:"id"`
	Priority    int       `json:"priority"`
	Observation string    `json:"observation"`
	Status      int       `json:"status"`
	Medicine_ID uuid.UUID `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
}

type CreateOrderOutputDTO struct {
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

type FindOrderOutputDTO struct {
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

type UpdateOrderOutputDTO struct {
	ID          string    `json:"id"`
	Priority    int       `json:"priority"`
	User_ID     uuid.UUID `json:"user_id"`
	Observation string    `json:"observation"`
	Status      int       `json:"status"`
	Medicine_ID uuid.UUID `json:"medicine_id"`
	Quantity    int       `json:"quantity"`
	UpdatedAt   time.Time `json:"updated_at"`
}

type DeleteOrderInputDTO struct {
	ID string `json:"id"`
}
