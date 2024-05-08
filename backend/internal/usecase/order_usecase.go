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
	order := entity.NewOrder()
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
	res, err := p.OrderRepository.FindAllOrder()
	if err != nil {
		return nil, err
	}
	var output []*dto.FindOrderOutputDTO
	for _, order := range res {
		output = append(output, &dto.FindOrderOutputDTO{
			ID:        order.ID,
			Label:     order.Label,
			UpdatedAt: order.UpdatedAt,
			CreatedAt: order.CreatedAt,
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
		ID:        res.ID,
		Label:     res.Label,
		UpdatedAt: res.UpdatedAt,
		CreatedAt: res.CreatedAt,
	}, nil
}

func (p *OrderUseCase) UpdateOrder(input *dto.UpdateOrderInputDTO) (*dto.UpdateOrderOutputDTO, error) {
	res, err := p.OrderRepository.FindOrderById(input.ID)
	if err != nil {
		return nil, err
	}
	res.Label = input.Label
	res, err = p.OrderRepository.UpdateOrder(res)
	if err != nil {
		return nil, err
	}
	return &dto.UpdateOrderOutputDTO{
		ID:       res.ID,
		Label:    res.Label,
		UpdateAt: res.UpdatedAt,
	}, nil
}

func (p *OrderUseCase) DeleteOrder(id string) error {
	order, err := p.OrderRepository.FindOrderById(id)
	if err != nil {
		return err
	}
	return p.OrderRepository.DeleteOrder(order.ID)
}
