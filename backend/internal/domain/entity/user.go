package entity

import "time"

type Role string

const (
	AdminRole     Role = "admin"
	UserRole      Role = "user"
	collectorRole Role = "collector"
	managerRole   Role = "manager"
)

type User struct {
	ID        string    `json:"id"`
	Name      string    `json:"name"`
	Email     string    `json:"email"`
	Password  string    `json:"password"`
	Role      Role      `json:"role"`
	CreatedAt time.Time `json:"created_at"`
	UpdatedAt time.Time `json:"updated_at"`
	OnDuty    bool      `json:"on_duty"`
}

type UserRepository interface {
	FindByID(id string) (*User, error)
	Create(user *User) error
	Update(user *User) error
	FindAll() ([]*User, error)
}
