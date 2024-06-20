package repository

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"github.com/emicklei/go-restful/v3/log"
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
	err := r.db.QueryRowx(
		"INSERT INTO orders (priority, user_id, observation, medicine_id, quantity, order_group_id) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id, priority, user_id, observation, status, medicine_id, quantity, created_at",
		order.Priority,
		order.User_ID,
		order.Observation,
		order.Medicine_ID,
		order.Quantity,
		order.OrderGroup_ID,
	).StructScan(&createdOrder)
	if err != nil {
		return nil, err
	}
	return &createdOrder, nil
}

func (r *OrderRepositoryPostgres) FindAllOrders() ([]*entity.OrderComplete, error) {
	var ordersComplete []*entity.OrderComplete
	log.Print("cheguei")

	// Primeira consulta para obter todas as informações menos o responsible
	err := r.db.Select(&ordersComplete, `SELECT 
		o.id as "id", o.priority, o.observation, o.status, 
		o.quantity, o.created_at as "created_at", o.updated_at as "updated_at",
		o.user_id, o.medicine_id, o.responsible_id, o.order_group_id,
		u.id as "user.id", u.name as "user.name", u.email as "user.email", 
		u.password as "user.password", u.role as "user.role", 
		u.created_at as "user.created_at", u.updated_at as "user.updated_at", u.on_duty as "user.on_duty", u.profession as "user.profession",
		m.id as "medicine.id", m.batch as "medicine.batch", m.name as "medicine.name", 
		m.stripe as "medicine.stripe", m.created_at as "medicine.created_at", m.updated_at as "medicine.updated_at"
		FROM orders o
		JOIN users u ON o.user_id = u.id
		JOIN medicines m ON o.medicine_id = m.id`)
	if err != nil {
		return nil, err
	}

	// Segunda consulta para preencher o campo responsible onde responsible_id não é nulo
	for _, order := range ordersComplete {
		if order.Responsible_ID != nil {
			var responsible entity.User
			err = r.db.Get(&responsible, `SELECT 
				id, name, email, password, role, created_at, updated_at, on_duty
				FROM users WHERE id = $1`, *order.Responsible_ID)
			if err != nil {
				return nil, err
			}
			order.Responsible = &responsible
		}
	}

	return ordersComplete, nil
}

func (r *OrderRepositoryPostgres) FindAllOrdersByOrderGroup(order_group_id string) ([]*entity.OrderComplete, error) {
	var ordersComplete []*entity.OrderComplete
	log.Print("cheguei")

	err := r.db.Select(&ordersComplete, `SELECT 
		o.id as "id", o.priority, o.observation, o.status, 
		o.quantity, o.created_at as "created_at", o.updated_at as "updated_at",
		o.user_id, o.medicine_id, o.responsible_id, o.order_group_id,
		m.id as "medicine.id", m.batch as "medicine.batch", m.name as "medicine.name", 
		m.stripe as "medicine.stripe", m.created_at as "medicine.created_at", m.updated_at as "medicine.updated_at"
		FROM orders o
		JOIN medicines m ON o.medicine_id = m.id
    WHERE o.order_group_id = $1
    `, order_group_id)
	if err != nil {
		return nil, err
	}

	return ordersComplete, nil
}

func (r *OrderRepositoryPostgres) FindOrderById(id string) (*entity.OrderComplete, error) {
	var orderComplete entity.OrderComplete
	err := r.db.Get(&orderComplete, `SELECT 
    o.id as "id", o.priority, o.observation, o.status, o.order_group_id, 
    o.quantity, o.created_at as "created_at", o.updated_at as "updated_at",
    o.user_id, o.medicine_id, o.responsible_id,
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

	if orderComplete.Responsible_ID != nil {
		err = r.db.Get(&orderComplete, `SELECT
      id as "responsible.id", name as "responsible.name", email as "responsible.email", 
    password as "responsible.password", role as "responsible.role", profession as "responsible.profession",
    created_at as "responsible.created_at", updated_at as "responsible.updated_at", on_duty as "responsible.on_duty"
      FROM users
      WHERE id = $1`, *orderComplete.Responsible_ID)

		if err != nil {
			return nil, err
		}
	}

	log.Printf("My order: %#v\n", orderComplete)
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
	err := r.db.QueryRowx(
		`UPDATE orders 
		 SET updated_at = CURRENT_TIMESTAMP, 
		     priority = $1, 
		     observation = $2, 
		     status = $3, 
		     medicine_id = $4, 
		     quantity = $5, 
		     responsible_id = $6 
		 WHERE id = $7 
		 RETURNING id, priority, user_id, observation, status, medicine_id, quantity, updated_at, responsible_id`,
		order.Priority,
		order.Observation,
		order.Status,
		order.Medicine_ID,
		order.Quantity,
		order.Responsible_ID, // Considerando que order.Responsible pode ser nulo
		order.ID,
	).StructScan(&updatedOrder)
	if err != nil {
		return nil, err
	}
	return &updatedOrder, nil
}
