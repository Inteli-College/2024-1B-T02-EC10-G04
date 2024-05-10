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

func (p *PyxisHandlers) FindAllPyxisHandler(c *gin.Context) {
	output, err := p.PyxisUseCase.FindAllPyxis()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

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