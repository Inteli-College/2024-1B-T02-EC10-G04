package handler

import (
	"encoding/json"
	"fmt"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/infra/kafka"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	"github.com/gin-gonic/gin"
	"net/http"
	"os"
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

func (h *OrderHandlers) FindAllOrdersHandler(c *gin.Context) {
	output, err := h.OrderUseCase.FindAllOrders()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

func (h *OrderHandlers) FindOrderByIdHandler(c *gin.Context) {
	var input dto.FindOrderByIDInputDTO
	input.ID = c.Param("id")
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.OrderUseCase.FindOrderById(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

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

func (h *OrderHandlers) DeleteOrderHandler(c *gin.Context) {
	var input dto.DeleteOrderInputDTO
	input.ID = c.Param("id")
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	err := h.OrderUseCase.DeleteOrder(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	message := fmt.Sprintf("Order %s deleted successfully", input.ID)
	c.JSON(http.StatusOK, gin.H{"message": message})
}
