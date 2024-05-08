package repository

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"github.com/jmoiron/sqlx"
)

type UserRepositoryPostgres struct {
	db *sqlx.DB
}

func NewUserRepositoryPostgres(db *sqlx.DB) *UserRepositoryPostgres {
	return &UserRepositoryPostgres{db: db}
}

func (r *UserRepositoryPostgres) CreateUser(user *entity.User) (*entity.User, error) {
	var userCreated entity.User
	err := r.db.QueryRow("INSERT INTO users (name, email, password, role, on_duty) VALUES ($1, $2, $3, $4, $5) RETURNING id, name, email, role, on_duty, created_at", user.Name, user.Email, user.Password, user.Role, user.OnDuty).Scan(&userCreated.ID, &userCreated.Name, &userCreated.Email, &userCreated.Role, &userCreated.OnDuty, &userCreated.CreatedAt)
	if err != nil {
		return nil, err
	}
	return &userCreated, nil
}

func (r *UserRepositoryPostgres) FindAllUsers() ([]*entity.User, error) {
	var users []*entity.User
	err := r.db.Select(&users, "SELECT * FROM users")
	if err != nil {
		return nil, err
	}
	return users, nil
}

func (r *UserRepositoryPostgres) FindUserById(id string) (*entity.User, error) {
	var user entity.User
	err := r.db.Get(&user, "SELECT * FROM users WHERE id = $1", id)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *UserRepositoryPostgres) DeleteUser(id string) error {
	_, err := r.db.Exec("DELETE FROM users WHERE id = $1", id)
	if err != nil {
		return err
	}
	return nil
}

func (r *UserRepositoryPostgres) UpdateUser(user *entity.User) (*entity.User, error) {
	var userUpdated entity.User
	err := r.db.QueryRow("UPDATE users SET updated_at = CURRENT_TIMESTAMP, name = $1, email = $2, password = $3, role = $4, on_duty = $5 WHERE id = $6 RETURNING id, name, email, role, on_duty, updated_at", user.Name, user.Email, user.Password, user.Role, user.OnDuty, user.ID).Scan(&userUpdated.ID, &userUpdated.Name, &userUpdated.Email, &userUpdated.Role, &userUpdated.OnDuty, &userUpdated.UpdatedAt)
	if err != nil {
		return nil, err
	}
	return &userUpdated, nil
}