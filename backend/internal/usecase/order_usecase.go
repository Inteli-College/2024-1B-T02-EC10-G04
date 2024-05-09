package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
)

type OrderUseCase struct {
	OrderRepository entity.OrderRepository
}

func NewOrderUseCase(orderRepository entity.OrderRepository) *OrderUseCase {
	return &OrderUseCase{OrderRepository: orderRepository}
}

func (p *OrderUseCase) CreateOrder(input *dto.CreateOrderInputDTO) (*dto.CreateOrderOutputDTO, error) {
	order := entity.NewOrder(input.Priority, input.User_ID, input.Observation, input.Status, input.Medicine_ID, input.Quantity)
	res, err := p.OrderRepository.CreateOrder(order)
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
		CreatedAt:   res.CreatedAt,
		UpdatedAt:   res.UpdatedAt,
	}, nil
}

func (p *OrderUseCase) FindAllOrder() ([]*dto.FindOrderOutputDTO, error) {
	res, err := p.OrderRepository.FindAllOrders()
	if err != nil {
		return nil, err
	}
	var output []*dto.FindOrderOutputDTO
	for _, order := range res {
		output = append(output, &dto.FindOrderOutputDTO{
			ID:          order.ID,
			Priority:    order.Priority,
			User_ID:     order.User_ID,
			Status:      order.Status,
			Medicine_ID: order.Medicine_ID,
			Observation: order.Observation,
			Quantity:    order.Quantity,
			CreatedAt:   order.CreatedAt,
			UpdatedAt:   order.UpdatedAt,
		})
	}
	return output, nil
}

func (p *OrderUseCase) FindOrderById(id string) (*dto.FindOrderOutputDTO, error) {
	res, err := p.OrderRepository.FindOrderById(id)
	if err != nil {
		return nil, err
	}
	return &dto.FindOrderOutputDTO{
		ID:          res.ID,
		Priority:    res.Priority,
		User_ID:     res.User_ID,
		Status:      res.Status,
		Medicine_ID: res.Medicine_ID,
		Observation: res.Observation,
		Quantity:    res.Quantity,
		UpdatedAt:   res.UpdatedAt,
		CreatedAt:   res.CreatedAt,
	}, nil
}

func (o *OrderUseCase) UpdateOrder(input *dto.UpdateOrderInputDTO) (*dto.UpdateOrderOutputDTO, error) {
	res, err := o.OrderRepository.FindOrderById(input.ID)
	if err != nil {
		return nil, err
	}

	order := entity.NewOrder(input.Priority, res.User_ID, input.Observation, input.Status, input.Medicine_ID, input.Quantity)

	res, err = o.OrderRepository.UpdateOrder(order)
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

func (p *OrderUseCase) DeleteOrder(id string) error {
	order, err := p.OrderRepository.FindOrderById(id)
	if err != nil {
		return err
	}
	return p.OrderRepository.DeleteOrder(order.ID)
}
