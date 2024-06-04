package entity

import (
	"time"
)

type BlockedUserRepository interface {
	CreateBlockedUser(blockedUser *BlockedUser) (*BlockedUser, error)
	FindBlockedUserById(id string) (*BlockedUser, error)
	FindAllBlockedUsers() ([]*BlockedUser, error)
	UpdateBlockedUser(blockedUser *BlockedUser) (*BlockedUser, error)
	DeleteBlockedUser(id string) error
}

type BlockedUser struct {
	ID        string    `json:"id" db:"id"`
	UserId    string    `json:"user_id" db:"batch"`
	CreatedAt time.Time `json:"created_at" db:"created_at"`
	UpdatedAt time.Time `json:"updated_at" db:"updated_at"`
	BlockedBy string    `json:"blocked_by" db:"stripe"`
	Reason    string    `json:"reason" db:"reason"`
}

func NewBlockedUser(user_id string, blocked_by string, reason string) *BlockedUser {
	return &BlockedUser{
		UserId:    user_id,
		BlockedBy: blocked_by,
		Reason:    reason,
	}
}
