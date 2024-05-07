package entity

import "time"

type UserRepository interface {
	Create(user *User) error
	Update(user *User) error
	FindByID(id string) (*User, error)
	FindAll() ([]*User, error)
}

type Role string

const (
	AdminRole     Role = "admin"
	UserRole      Role = "user"
	CollectorRole Role = "collector"
	ManagerRole   Role = "manager"
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

func NewUser(name, email, password string, role Role) *User {
	return &User{
		ID:        "",
		Name:      name,
		Email:     email,
		Password:  password,
		Role:      role,
		CreatedAt: time.Now(),
		UpdatedAt: time.Now(),
		OnDuty:    false,
	}
}
