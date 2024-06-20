package usecase

import (
	"log"

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
		order := entity.NewOrder(input.Priority, input.User_ID, input.Observation, medicine_id, input.Quantity, input.Responsible_ID, newOrderGroupID, input.Pyxis_ID)
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
	for i := 0; i < len(orders); i++ {
		temp := dto.FindOrderOutputDTO{
			ID:          orders[i].ID,
			Priority:    orders[i].Priority,
			User:        orders[i].User,
			Observation: orders[i].Observation,
			Status:      orders[i].Status,
			Medicine:    []*entity.Medicine{&orders[i].Medicine},
			Quantity:    orders[i].Quantity,
			UpdatedAt:   orders[i].UpdatedAt,
			CreatedAt:   orders[i].CreatedAt,
			Responsible: orders[i].Responsible,
			Pyxis_ID:    orders[i].Pyxis_ID,
		}

		next := 1
		for {
			if next+i < len(orders) {
				if *orders[i+next].OrderGroup_ID == *orders[i].OrderGroup_ID {
					temp.Medicine = append(temp.Medicine, &orders[i+next].Medicine)
					next++
					continue
				}
			} else {
				i = i + next
				break
			}
		}

		ordersOutput = append(ordersOutput, &temp)
	}
	return ordersOutput, nil
}

func (o *OrderUseCase) FindOrderById(id string) (*dto.FindOrderOutputDTO, error) {
	order, err := o.orderRepository.FindOrderById(id)
	if err != nil {
		return nil, err
	}

	log.Printf("Ordergroup_id: %s\n", *order.OrderGroup_ID)
	remainingOrders, new_err := o.orderRepository.FindAllOrdersByOrderGroup(*order.OrderGroup_ID)
	log.Printf("Remaining orders: %#v\n", remainingOrders)
	if new_err != nil || len(remainingOrders) <= 0 {
		return nil, err
	}

	var medicines []*entity.Medicine

	for _, remeiningOrder := range remainingOrders {
		medicines = append(medicines, &remeiningOrder.Medicine)
	}

	return &dto.FindOrderOutputDTO{
		ID:          order.ID,
		Priority:    order.Priority,
		User:        order.User,
		Observation: order.Observation,
		Status:      order.Status,
		Medicine:    medicines,
		Quantity:    order.Quantity,
		UpdatedAt:   order.UpdatedAt,
		CreatedAt:   order.CreatedAt,
		Responsible: order.Responsible,
		Pyxis_ID:    order.Pyxis_ID,
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
	res.Responsible_ID = &input.Responsible_ID

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
