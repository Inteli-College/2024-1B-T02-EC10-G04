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
	var orderCreated entity.Order
	err := r.db.QueryRow(`
		INSERT INTO Orders (
			Priority, User_ID, Observation, Status, Medicine_ID, Quantity
		) VALUES ($1, $2, $3, $4, $5, $6)
		RETURNING ID, Priority, User_ID, Observation, Status, Medicine_ID, Quantity, CreatedAt, UpdatedAt`,
		order.Priority, order.User_ID, order.Observation, order.Status, order.Medicine_ID, order.Quantity,
	).Scan(&orderCreated.ID, &orderCreated.Priority, &orderCreated.User_ID, &orderCreated.Observation, &orderCreated.Status, &orderCreated.Medicine_ID, &orderCreated.Quantity, &orderCreated.CreatedAt, &orderCreated.UpdatedAt)
	if err != nil {
		return nil, err
	}
	return &orderCreated, nil
}

func (r *OrderRepositoryPostgres) FindAllOrders() ([]*entity.Order, error) {
	var order []*entity.Order
	err := r.db.Select(&order, "SELECT * FROM order")

	if err != nil {
		return nil, err
	}
	return order, nil
}

func (r *OrderRepositoryPostgres) FindOrderById(id string) (*entity.Order, error) {
	var order entity.Order
	err := r.db.Get(&order, "SELECT * FROM order WHERE id = $1", id)
	if err != nil {
		return nil, err
	}
	return &order, nil
}

func (r *OrderRepositoryPostgres) UpdateOrder(order *entity.Order) (*entity.Order, error) {
	var updatedOrder entity.Order
	err := r.db.QueryRow(`
		UPDATE Orders
		SET 
			Priority = $1, 
			Observation = $3, 
			Status = $3, 
			Medicine_ID = $4, 
			Quantity = $5, 
		WHERE ID = $6
		RETURNING ID, Priority, User_ID, Observation, Status, Medicine_ID, Quantity, CreatedAt`,
		order.Priority, order.Observation, order.Status, order.Medicine_ID, order.Quantity, order.ID,
	).Scan(&updatedOrder.ID, &updatedOrder.Priority, &updatedOrder.User_ID, &updatedOrder.Observation, &updatedOrder.Status, &updatedOrder.Medicine_ID, &updatedOrder.Quantity, &updatedOrder.CreatedAt, &updatedOrder.UpdatedAt)
	if err != nil {
		return nil, err
	}
	return &updatedOrder, nil
}

func (r *OrderRepositoryPostgres) DeleteOrder(id string) error {
	_, err := r.db.Exec("DELETE FROM orders WHERE id = $1", id)
	if err != nil {
		return err
	}
	return nil
}
