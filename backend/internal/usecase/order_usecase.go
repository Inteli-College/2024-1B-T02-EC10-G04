package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"github.com/google/uuid"
)

type OrderUseCase struct {
	orderRepository entity.OrderRepository
}

func NewOrderUseCase(orderRepository entity.OrderRepository) *OrderUseCase {
	return &OrderUseCase{
		orderRepository: orderRepository,
	}
}

func (o *OrderUseCase) CreateOrders(input *dto.CreateOrdersInputDTO) ([]*dto.CreateOrderOutputDTO, error) {
	newOrderGroupID := uuid.New().String()
	createdOrders := []*dto.CreateOrderOutputDTO{}
	for _, medicine_id := range input.Medicine_IDs {
		order := entity.NewOrder(input.Priority, input.User_ID, input.Observation, medicine_id, input.Quantity, input.Responsible_ID, newOrderGroupID)
		res, err := o.orderRepository.CreateOrder(order)
		if err != nil {
			return nil, err
		}
		createdOrders = append(createdOrders, &dto.CreateOrderOutputDTO{
			ID:             res.ID,
			Priority:       res.Priority,
			User_ID:        res.User_ID,
			Observation:    res.Observation,
			Responsible_ID: res.Responsible_ID,
			Status:         res.Status,
			Medicine_ID:    res.Medicine_ID,
			Quantity:       res.Quantity,
			CreatedAt:      res.CreatedAt,
			OrderGroup_ID:  res.OrderGroup_ID,
		})
	}
	return createdOrders, nil
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
			User:        order.User,
			Observation: order.Observation,
			Status:      order.Status,
			Medicine:    order.Medicine,
			Quantity:    order.Quantity,
			UpdatedAt:   order.UpdatedAt,
			CreatedAt:   order.CreatedAt,
			Responsible: order.Responsible,
		})
	}
	return ordersOutput, nil
}

func (o *OrderUseCase) FindOrderById(id string) (*dto.FindOrderOutputDTO, error) {
	order, err := o.orderRepository.FindOrderById(id)
	if err != nil {
		return nil, err
	}
	return &dto.FindOrderOutputDTO{
		ID:          order.ID,
		Priority:    order.Priority,
		User:        order.User,
		Observation: order.Observation,
		Status:      order.Status,
		Medicine:    order.Medicine,
		Quantity:    order.Quantity,
		UpdatedAt:   order.UpdatedAt,
		CreatedAt:   order.CreatedAt,
		Responsible: order.Responsible,
	}, nil
}

func (o *OrderUseCase) UpdateOrder(input *dto.UpdateOrderInputDTO) (*dto.UpdateOrderOutputDTO, error) {
	res, err := o.orderRepository.FindOrderById(input.ID)
	if err != nil {
		return nil, err
	}

	// TODO: Implement update that does not require all fields of input DTO  (Maybe i can do this only in the repository?)
	res.Medicine_ID = input.Medicine_ID
	res.Status = input.Status
	res.Priority = input.Priority
	res.Observation = input.Observation
	res.Quantity = input.Quantity

	updatedOrder, err := o.orderRepository.UpdateOrder(res)
	if err != nil {
		return nil, err
	}

	return &dto.UpdateOrderOutputDTO{
		ID:             updatedOrder.ID,
		Priority:       updatedOrder.Priority,
		User_ID:        updatedOrder.User_ID,
		Observation:    updatedOrder.Observation,
		Status:         updatedOrder.Status,
		Medicine_ID:    updatedOrder.Medicine_ID,
		Quantity:       updatedOrder.Quantity,
		UpdatedAt:      updatedOrder.UpdatedAt,
		Responsible_ID: updatedOrder.Responsible_ID,
	}, nil
}

func (o *OrderUseCase) DeleteOrder(id string) error {
	order, err := o.orderRepository.FindOrderById(id)
	if err != nil {
		return err
	}
	return o.orderRepository.DeleteOrder(order.ID)
}
