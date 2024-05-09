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

func (r *OrderRepositoryPostgres) FindAllOrders() ([]*entity.Order, error) {
	var orders []*entity.Order
	err := r.db.Select(&orders, "SELECT * FROM orders")
	if err != nil {
		return nil, err
	}
	return orders, nil
}

func (r *OrderRepositoryPostgres) FindOrderById(id string) (*entity.Order, error) {
	var order entity.Order
	err := r.db.Get(&order, "SELECT * FROM orders WHERE id = $1", id)
	if err != nil {
		return nil, err
	}
	return &order, nil
}

func (r *OrderRepositoryPostgres) DeleteOrder(id string) error {
	_, err := r.db.Exec("DELETE FROM orders WHERE id = $1", id)
	if err != nil {
		return err
	}
	return nil
}

func (r *OrderRepositoryPostgres) UpdateOrder(order *entity.Order) (*entity.Order, error) {
	var updatedOrder entity.Order
	err := r.db.QueryRow(
		"UPDATE orders SET update_at = CURRENT_TIMESTAMP, priority = $1, observation = $2, status = $3, medicine_id = $4, quantity = $5 WHERE id = $6 RETURNING id, priority, observation, status, medicine_id, quantity, update_at",
		order.Priority,
		order.Observation,
		order.Status,
		order.Medicine_ID,
		order.Quantity,
		order.ID,
	).Scan(&updatedOrder.ID, &updatedOrder.Priority, &updatedOrder.Observation, &updatedOrder.Status, &updatedOrder.Medicine_ID, &updatedOrder.Quantity, &updatedOrder.UpdatedAt)
	if err != nil {
		return nil, err
	}
	return &updatedOrder, nil
}