package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
)

type OrderUseCase struct {
	orderRepository entity.OrderRepository
}

func NewOrderUseCase(orderRepository entity.OrderRepository) *OrderUseCase {
	return &OrderUseCase{
		orderRepository: orderRepository,
	}
}

func (o *OrderUseCase) CreateOrder(input *dto.CreateOrderInputDTO) (*dto.CreateOrderOutputDTO, error) {
	order := entity.NewOrder(input.Priority, input.User_ID, input.Observation, input.Status, input.Medicine_ID, input.Quantity)
	res, err := o.orderRepository.CreateOrder(order)
	if err != nil {
		return nil, err
	}
	return &dto.CreateOrderOutputDTO{
		ID:          res.ID,
		Priority:    res.Priority,
		User_ID:     res.User_ID,
		Observation: res.Observation,
		Status:      res.Status,
		Medicine_ID: res.Medicine_ID,
		Quantity:    res.Quantity,
	}, nil
}

func (o *OrderUseCase) FindAllOrders() ([]*dto.FindOrderOutputDTO, error) {
	orders, err := o.orderRepository.FindAllOrders()
	if err != nil {
		return nil, err
	}
	var ordersOutput []*dto.FindOrderOutputDTO
	for _, order := range orders {
		ordersOutput = append(ordersOutput, &dto.FindOrderOutputDTO{
			ID:          order.ID,
			Priority:    order.Priority,
			User_ID:     order.User_ID,
			Observation: order.Observation,
			Status:      order.Status,
			Medicine_ID: order.Medicine_ID,
			Quantity:    order.Quantity,
		})
	}
	return ordersOutput, nil
}

func (o *OrderUseCase) FindOrderById(id string) (*dto.UpdateOrderOutputDTO, error) {
	order, err := o.orderRepository.FindOrderById(id)
	if err != nil {
		return nil, err
	}
	return &dto.UpdateOrderOutputDTO{
		ID:          order.ID,
		Priority:    order.Priority,
		Observation: order.Observation,
		Status:      order.Status,
		Medicine_ID: order.Medicine_ID,
		Quantity:    order.Quantity,
	}, nil
}

func (o *OrderUseCase) UpdateOrder(input *dto.UpdateOrderInputDTO) (*dto.UpdateOrderOutputDTO, error) {
	res, err := o.orderRepository.FindOrderById(input.ID)
	if err != nil {
		return nil, err
	}

	order := entity.NewOrder(input.Priority, res.User_ID, input.Observation, input.Status, input.Medicine_ID, input.Quantity)

	res, err = o.orderRepository.UpdateOrder(order)
	if err != nil {
		return nil, err
	}

	return &dto.UpdateOrderOutputDTO{
		ID:          res.ID,
		Priority:    res.Priority,
		Observation: res.Observation,
		Status:      res.Status,
		Medicine_ID: res.Medicine_ID,
		Quantity:    res.Quantity,
	}, nil
}

func (o *OrderUseCase) DeleteOrder(id string) error {
	order, err := o.orderRepository.FindOrderById(id)
	if err != nil {
		return err
	}
	return o.orderRepository.DeleteOrder(order.ID)
}