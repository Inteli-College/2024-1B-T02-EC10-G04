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

func NewOrderHandlers(pyxisUsecase *usecase.OrderUseCase, KafkaProducer *kafka.KafkaProducer) *OrderHandlers {
	return &OrderHandlers{
		OrderUseCase:  pyxisUsecase,
		KafkaProducer: KafkaProducer,
	}
}

// CreateOrderHandler godoc
// @Summary Create a new Order entity
// @Description Create a new Order entity
// @Tags Order
// @Accept json
// @Produce json
// @Param input body dto.CreateOrderInputDTO true "Order entity to create"
// @Success 200 {object} dto.CreateOrderOutputDTO
// @Failure 400 {object} map[string]interface{}
// @Failure 500 {object} map[string]interface{}
// @Router /pyxis [post]
func (p *OrderHandlers) CreateOrderHandler(c *gin.Context) {
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

	err = p.KafkaProducer.Produce(inputBytes, []byte("new_order"), os.Getenv("KAFKA_ORDERS_TOPIC_NAME"))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, gin.H{"message": "Order created successfully"})
}

// FindAllOrderHandler godoc
// @Summary Retrieve all Order entities
// @Description Retrieve all Order entities
// @Tags Order
// @Accept json
// @Produce json
// @Success 200 {array} dto.OrderDTO
// @Failure 500 {object} map[string]interface{}
// @Router /pyxis [get]
func (p *OrderHandlers) FindAllOrderHandler(c *gin.Context) {
	output, err := p.OrderUseCase.FindAllOrder()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// FindOrderByIdHandler godoc
// @Summary Retrieve a Order entity by ID
// @Description Retrieve a Order entity by ID
// @Tags Order
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Success 200 {object} dto.OrderDTO
// @Failure 400 {object} map[string]interface{}
// @Failure 404 {object} map[string]interface{}
// @Failure 500 {object} map[string]interface{}
// @Router /pyxis/{id} [get]
func (p *OrderHandlers) FindOrderByIdHandler(c *gin.Context) {
	var input dto.FindOrderByIDInputDTO
	input.ID = c.Param("id")
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := p.OrderUseCase.FindOrderById(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// UpdateOrderHandler godoc
// @Summary Update a Order entity
// @Description Update a Order entity
// @Tags Order
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Param input body dto.UpdateOrderInputDTO true "Order entity to update"
// @Success 200 {object} dto.UpdateOrderOutputDTO
// @Failure 400 {object} map[string]interface{}
// @Failure 404 {object} map[string]interface{}
// @Failure 500 {object} map[string]interface{}
// @Router /pyxis/{id} [patch]
func (p *OrderHandlers) UpdateOrderHandler(c *gin.Context) {
	var input dto.UpdateOrderInputDTO
	input.ID = c.Param("id")
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := p.OrderUseCase.UpdateOrder(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// DeleteOrderHandler godoc
// @Summary Delete a Order entity
// @Description Delete a Order entity
// @Tags Order
// @Accept json
// @Produce json
// @Param id path string true "Order ID"
// @Success 200 {string} string
// @Failure 400 {object} map[string]interface{}
// @Failure 404 {object} map[string]interface{}
// @Failure 500 {object} map[string]interface{}
// @Router /pyxis/{id} [delete]
func (p *OrderHandlers) DeleteOrderHandler(c *gin.Context) {
	var input dto.DeleteOrderInputDTO
	input.ID = c.Param("id")
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	err := p.OrderUseCase.DeleteOrder(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	message := fmt.Sprintf("Order %s deleted successfully", input.ID)
	c.JSON(http.StatusOK, gin.H{"message": message})
}
