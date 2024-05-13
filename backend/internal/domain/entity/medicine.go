package entity

import (
	"time"
)

type StripeType string

const (
	StripeRed    StripeType = "red"
	StripeYellow StripeType = "yellow"
	StripeBlack  StripeType = "black"
)

type MediceRepository interface {
	CreateMedicine(medicine *Medicine) (*Medicine, error)
	FindMedicineById(id string) (*Medicine, error)
	FindAllMedicines() ([]*Medicine, error)
	UpdateMedicine(medicine *Medicine) (*Medicine, error)
	DeleteMedicine(id string) error
}

type Medicine struct {
	ID        string     `json:"id" db:"id"`
	Batch     string     `json:"batch" db:"batch"`
	Name      string     `json:"name" db:"name"`
	Stripe    StripeType `json:"stripe" db:"stripe"`
	CreatedAt time.Time  `json:"created_at" db:"created_at"`
	UpdatedAt time.Time  `json:"updated_at" db:"updated_at"`
}

func NewMedice(batch string, name string, stripe StripeType) *Medicine {
	return &Medicine{
		Batch:  batch,
		Name:   name,
		Stripe: stripe,
	}
}