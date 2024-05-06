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
	err := r.db.QueryRow("SELECT id, name, email, role, created_at, on_duty FROM users WHERE id = ?", id).Scan(&user.ID, &user.Name, &user.Email, &user.Role, &user.CreatedAt, &user.UpdatedAt, &user.OnDuty)
	if err != nil {
		return nil, err
	}
	return &user, nil
}

func (r *UserRepository) Create(user *entity.User) error {
	// Preparar a declaração SQL com espaços reservados (?)
	stmt, err := r.db.Prepare("INSERT INTO users (name, email, password, role, on_duty) VALUES ($1, $2, $3, $4, $5)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Executar a declaração SQL com os valores passados
	_, err = stmt.Exec(user.Name, user.Email, user.Password, user.Role, user.OnDuty)
	return err
}

func (r *UserRepository) Update(user *entity.User) error {
	_, err := r.db.Exec("UPDATE users SET name = ?, email = ?", user.Name, user.Email, user.ID)
	return err
}

func (r *UserRepository) FindAll() ([]*entity.User, error) {
	rows, err := r.db.Query("SELECT id, name, email, role, created_at, updated_at, on_duty FROM users")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	users := make([]*entity.User, 0)
	for rows.Next() {
		var user entity.User
		err := rows.Scan(&user.ID, &user.Name, &user.Email, &user.Role, &user.CreatedAt, &user.UpdatedAt, &user.OnDuty)
		if err != nil {
			return nil, err
		}
		users = append(users, &user)
	}
	return users, nil
}
