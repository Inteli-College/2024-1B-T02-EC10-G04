package repository

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"github.com/jmoiron/sqlx"
)

type OrderRepositoryPostgres struct {
	db *sqlx.DB
}

func NewOrderRepositoryPostgres(db *sqlx.DB) *OrderRepositoryPostgres {
	return &OrderRepositoryPostgres{db: db}
}

func (r *OrderRepositoryPostgres) CreateOrder(order *entity.Order) (*entity.Order, error) {
	var createdOrder entity.Order
	err := r.db.QueryRow(
		"INSERT INTO orders (priority, user_id, observation, medicine_id, quantity) VALUES ($1, $2, $3, $4, $5) RETURNING id, priority, user_id, observation, status, medicine_id, quantity, created_at",
		order.Priority,
		order.User_ID,
		order.Observation,
		order.Medicine_ID,
		order.Quantity,
	).Scan(&createdOrder.ID, &createdOrder.Priority, &createdOrder.User_ID, &createdOrder.Observation, &createdOrder.Status, &createdOrder.Medicine_ID, &createdOrder.Quantity, &createdOrder.CreatedAt)
	if err != nil {
		return nil, err
	}
	return &createdOrder, nil
}

func (r *OrderRepositoryPostgres) FindAllOrders() ([]*entity.OrderComplete, error) {
	var ordersComplete []*entity.OrderComplete
	err := r.db.Select(&ordersComplete, `SELECT 
    o.id as "id", o.priority, o.observation, o.status, 
    o.quantity, o.created_at as "created_at", o.updated_at as "updated_at",
    o.user_id, o.medicine_id,
    u.id as "user.id", u.name as "user.name", u.email as "user.email", 
    u.password as "user.password", u.role as "user.role", 
    u.created_at as "user.created_at", u.updated_at as "user.updated_at", u.on_duty as "user.on_duty",
    m.id as "medicine.id", m.batch as "medicine.batch", m.name as "medicine.name", 
    m.stripe as "medicine.stripe", m.created_at as "medicine.created_at", m.updated_at as "medicine.updated_at"
    FROM orders o
    JOIN users u ON o.user_id = u.id
    JOIN medicines m ON o.medicine_id = m.id`)
	if err != nil {
		return nil, err
	}
	return ordersComplete, nil
}

func (r *OrderRepositoryPostgres) FindOrderById(id string) (*entity.OrderComplete, error) {
	var orderComplete entity.OrderComplete
	err := r.db.Get(&orderComplete, `SELECT 
    o.id as "id", o.priority, o.observation, o.status, 
    o.quantity, o.created_at as "created_at", o.updated_at as "updated_at",
    o.user_id, o.medicine_id,
    u.id as "user.id", u.name as "user.name", u.email as "user.email", 
    u.password as "user.password", u.role as "user.role", 
    u.created_at as "user.created_at", u.updated_at as "user.updated_at", u.on_duty as "user.on_duty",
    m.id as "medicine.id", m.batch as "medicine.batch", m.name as "medicine.name", 
    m.stripe as "medicine.stripe", m.created_at as "medicine.created_at", m.updated_at as "medicine.updated_at"
    FROM orders o
    JOIN users u ON o.user_id = u.id
    JOIN medicines m ON o.medicine_id = m.id
    WHERE o.id = $1`, id)
	if err != nil {
		return nil, err
	}
	return &orderComplete, nil
}

func (r *OrderRepositoryPostgres) DeleteOrder(id string) error {
	_, err := r.db.Exec("DELETE FROM orders WHERE id = $1", id)
	if err != nil {
		return err
	}
	return nil
}

func (r *OrderRepositoryPostgres) UpdateOrder(order *entity.OrderComplete) (*entity.Order, error) {
	var updatedOrder entity.Order
	err := r.db.QueryRow(
		"UPDATE orders SET updated_at = CURRENT_TIMESTAMP, priority = $1, observation = $2, status = $3, medicine_id = $4, quantity = $5 WHERE id = $6 RETURNING id, priority, user_id, observation, status, medicine_id, quantity, updated_at",
		order.Priority,
		order.Observation,
		order.Status,
		order.Medicine_ID,
		order.Quantity,
		order.ID,
	).Scan(&updatedOrder.ID, &updatedOrder.Priority, &updatedOrder.User_ID, &updatedOrder.Observation, &updatedOrder.Status, &updatedOrder.Medicine_ID, &updatedOrder.Quantity, &updatedOrder.UpdatedAt)
	if err != nil {
		return nil, err
	}
	return &updatedOrder, nil
}
