package dto

import (
	"time"
)

type CreateBlockedUserInputDTO struct {
	UserId    string `json:"user_id" db:"batch"`
	BlockedBy string `json:"blocked_by" db:"stripe"`
	Reason    string `json:"reason" db:"reason"`
}

type CreateBlockedUserOutputDTO struct {
	ID        string    `json:"id" db:"id"`
	UserId    string    `json:"user_id" db:"batch"`
	CreatedAt time.Time `json:"created_at" db:"created_at"`
	UpdatedAt time.Time `json:"updated_at" db:"updated_at"`
	BlockedBy string    `json:"blocked_by" db:"stripe"`
	Reason    string    `json:"reason" db:"reason"`
}

type FindBlockedUserOutputDTO struct {
	ID        string    `json:"id" db:"id"`
	UserId    string    `json:"user_id" db:"batch"`
	CreatedAt time.Time `json:"created_at" db:"created_at"`
	UpdatedAt time.Time `json:"updated_at" db:"updated_at"`
	BlockedBy string    `json:"blocked_by" db:"stripe"`
	Reason    string    `json:"reason" db:"reason"`
}

type UpdateBlockedUserInputDTO struct {
	ID        string    `json:"id" db:"id"`
	UserId    string    `json:"user_id" db:"batch"`
	CreatedAt time.Time `json:"created_at" db:"created_at"`
	UpdatedAt time.Time `json:"updated_at" db:"updated_at"`
	BlockedBy string    `json:"blocked_by" db:"stripe"`
	Reason    string    `json:"reason" db:"reason"`
}
