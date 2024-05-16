package handler

import (
	"fmt"
	"net/http"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	"github.com/gin-gonic/gin"
)

type PyxisHandlers struct {
	PyxisUseCase *usecase.PyxisUseCase
}

func NewPyxisHandlers(pyxisUsecase *usecase.PyxisUseCase) *PyxisHandlers {
	return &PyxisHandlers{
		PyxisUseCase: pyxisUsecase,
	}
}

// CreatePyxisHandler
// @Summary Create a new Pyxis entity
// @Description Create a new Pyxis entity
// @Tags Pyxis
// @Accept json
// @Produce json
// @Param input body dto.CreatePyxisInputDTO true "Pyxis entity to create"
// @Success 200 {object} dto.CreatePyxisOutputDTO
// @Router /pyxis [post]
func (p *PyxisHandlers) CreatePyxisHandler(c *gin.Context) {
	var input dto.CreatePyxisInputDTO
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := p.PyxisUseCase.CreatePyxis(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// FindAllPyxisHandler
// @Summary Retrieve all Pyxis entities
// @Description Retrieve all Pyxis entities
// @Tags Pyxis
// @Accept json
// @Produce json
// @Success 200 {array} dto.FindPyxisOutputDTO
// @Router /pyxis [get]
func (p *PyxisHandlers) FindAllPyxisHandler(c *gin.Context) {
	output, err := p.PyxisUseCase.FindAllPyxis()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// FindPyxisByIdHandler
// @Summary Retrieve a Pyxis entity by ID
// @Description Retrieve a Pyxis entity by ID
// @Tags Pyxis
// @Accept json
// @Produce json
// @Param id path string true "Pyxis ID"
// @Success 200 {object} dto.FindPyxisOutputDTO
// @Router /pyxis/{id} [get]
func (p *PyxisHandlers) FindPyxisByIdHandler(c *gin.Context) {
	var input dto.FindPyxisByIDInputDTO
	input.ID = c.Param("id")
	output, err := p.PyxisUseCase.FindPyxisById(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// UpdatePyxisHandler
// @Summary Update a Pyxis entity
// @Description Update a Pyxis entity
// @Tags Pyxis
// @Accept json
// @Produce json
// @Param id path string true "Pyxis ID"
// @Param input body dto.UpdatePyxisInputDTO true "Pyxis entity to update"
// @Success 200 {object} dto.UpdatePyxisOutputDTO
// @Router /pyxis/{id} [put]
func (p *PyxisHandlers) UpdatePyxisHandler(c *gin.Context) {
	var input dto.UpdatePyxisInputDTO
	input.ID = c.Param("id")
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := p.PyxisUseCase.UpdatePyxis(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// DeletePyxisHandler
// @Summary Delete a Pyxis entity
// @Description Delete a Pyxis entity
// @Tags Pyxis
// @Accept json
// @Produce json
// @Param id path string true "Pyxis ID"
// @Success 200 {string} string
// @Router /pyxis/{id} [delete]
func (p *PyxisHandlers) DeletePyxisHandler(c *gin.Context) {
	var input dto.DeletePyxisInputDTO
	input.ID = c.Param("id")
	err := p.PyxisUseCase.DeletePyxis(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	message := fmt.Sprintf("Pyxis %s deleted successfully", input.ID)
	c.JSON(http.StatusOK, gin.H{"message": message})
}