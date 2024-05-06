package entity

import (
	"time"
	"github.com/google/uuid"
)

type PyxisRepository interface {
	FindPyxisByID(id string) (*Pyxis, error)
	CreatePyxis(pyxis *Pyxis) error
	UpdatePyxis(pyxis *Pyxis) error
	FindAllPyxis() ([]*Pyxis, error)
	DeletePyxis(id string) error
}

type Pyxis struct {
	ID        string    `json:"id"`
	Label     string    `json:"label"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
}

func NewPyxis(label string) *Pyxis {
	return &Pyxis{
		ID:        uuid.New().String(),
		Label:     label,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
	}
}