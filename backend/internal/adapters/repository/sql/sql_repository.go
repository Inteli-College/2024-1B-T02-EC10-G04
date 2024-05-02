package sql

import (
	"database/sql"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
)

type UserRepository struct {
	db *sql.DB
}

func NewUserRepository(db *sql.DB) *UserRepository {
	return &UserRepository{db: db}
}

func (r *UserRepository) FindByID(id string) (*entity.User, error) {
	var user entity.User
	err := r.db.QueryRow("SELECT id, name, email FROM users WHERE id = ?", id).Scan(&user.ID, &user.Name, &user.Email)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *UserRepository) Create(user *entity.User) error {
	_, err := r.db.Exec("INSERT INTO users (id, name, email) VALUES (?, ?, ?)", user.ID, user.Name, user.Email)
	return err
}

func (r *UserRepository) Update(user *entity.User) error {
	_, err := r.db.Exec("UPDATE users SET name = ?, email = ? WHERE id = ?", user.Name, user.Email, user.ID)
	return err
}
