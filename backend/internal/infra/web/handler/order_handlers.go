package handler

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/kafka"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	"github.com/gin-gonic/gin"
)

type OrderHandlers struct {
	OrderUseCase  *usecase.OrderUseCase
	KafkaProducer *kafka.KafkaProducer
}

func NewOrderHandlers(orderUsecase *usecase.OrderUseCase, KafkaProducer *kafka.KafkaProducer) *OrderHandlers {
	return &OrderHandlers{
		OrderUseCase:  orderUsecase,
		KafkaProducer: KafkaProducer,
	}
}

// CreateOrderHandler
// @Summary Create a new Order entity
// @Description Create a new Order entity and produce an event to Kafka
// @Tags Orders
// @Accept json
// @Produce json
// @Param input body dto.CreateOrderInputDTO true "Order entity to create"
// @Success 201 {object} string
// @Router /orders [post]
func (h *OrderHandlers) CreateOrderHandler(c *gin.Context) {
	var input dto.CreateOrderInputDTO
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	inputBytes, err := json.Marshal(input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	err = h.KafkaProducer.Produce(inputBytes, []byte("new_order"), os.Getenv("KAFKA_ORDERS_TOPIC_NAME"))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Order created successfully"})
}

// FindAllOrdersHandler
// @Summary Retrieve all Order entities
// @Description Retrieve all Order entities
// @Tags Orders
// @Accept json
// @Produce json
// @Success 200 {array} dto.FindOrderOutputDTO
// @Router /orders [get]
func (h *OrderHandlers) FindAllOrdersHandler(c *gin.Context) {
	output, err := h.OrderUseCase.FindAllOrders()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// FindOrderByIdHandler
// @Summary Retrieve an Order entity by ID
// @Description Retrieve an Order entity by ID
// @Tags Orders
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Success 200 {object} dto.FindOrderOutputDTO
// @Router /orders/{id} [get]
func (h *OrderHandlers) FindOrderByIdHandler(c *gin.Context) {
	var input dto.FindOrderByIDInputDTO
	input.ID = c.Param("id")
	output, err := h.OrderUseCase.FindOrderById(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// UpdateOrderHandler
// @Summary Update an Order entity
// @Description Update an Order entity
// @Tags Orders
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Param input body dto.UpdateOrderInputDTO true "Order entity to update"
// @Success 200 {object} dto.UpdateOrderOutputDTO
// @Router /orders/{id} [put]
func (h *OrderHandlers) UpdateOrderHandler(c *gin.Context) {
	var input dto.UpdateOrderInputDTO
	input.ID = c.Param("id")
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.OrderUseCase.UpdateOrder(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// DeleteOrderHandler
// @Summary Delete an Order entity
// @Description Delete an Order entity
// @Tags Orders
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Success 200 {string} string
// @Router /orders/{id} [delete]
func (h *OrderHandlers) DeleteOrderHandler(c *gin.Context) {
	var input dto.DeleteOrderInputDTO
	input.ID = c.Param("id")
	err := h.OrderUseCase.DeleteOrder(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	message := fmt.Sprintf("Order %s deleted successfully", input.ID)
	c.JSON(http.StatusOK, gin.H{"message": message})
}
