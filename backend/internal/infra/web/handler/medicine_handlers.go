package handler

import (
	"fmt"
	"net/http"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	"github.com/gin-gonic/gin"
)

type MedicineHandlers struct {
	MedicineUseCase *usecase.MedicineUseCase
}

func NewMedicineHandlers(medicineUsecase *usecase.MedicineUseCase) *MedicineHandlers {
	return &MedicineHandlers{
		MedicineUseCase: medicineUsecase,
	}
}

// CreateMedicineHandler godoc
// @Summary Create a new Medicine entity
// @Description Create a new Medicine entity
// @Tags Medices
// @Accept json
// @Produce json
// @Param input body dto.CreateMedicineInputDTO true "Medicine entity to create"
// @Success 200 {object} dto.CreateMedicineOutputDTO
// @Failure 400 {object} map[string]interface{}
// @Failure 500 {object} map[string]interface{}
// @Router /medicines [post]
func (h *MedicineHandlers) CreateMedicineHandler(c *gin.Context) {
	var input dto.CreateMedicineInputDTO
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.MedicineUseCase.CreateMedicine(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// FindAllMedicineHandler godoc
// @Summary Retrieve all Medicines entities
// @Description Retrieve all Medicines entities
// @Tags Medicines
// @Accept json
// @Produce json
// @Success 200 {array} dto.FindMedicineOutputDTO
// @Failure 500 {object} map[string]interface{}
// @Router /medicines [get]
func (h *MedicineHandlers) FindAllMedicinesHandler(c *gin.Context) {
	output, err := h.MedicineUseCase.FindAllMedicines()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// // FindMedicineByIdHandler godoc
// // @Summary Retrieve a Medicine entity by ID
// // @Description Retrieve a Medicine entity by ID
// // @Tags Medicines
// // @Accept json
// // @Produce json
// // @Param id path string true "Medicine ID"
// // @Success 200 {object} dto.FindMedicineOutputDTO
// // @Failure 400 {object} map[string]interface{}
// // @Failure 404 {object} map[string]interface{}
// // @Failure 500 {object} map[string]interface{}
// // @Router /medicines/{id} [get]
func (m *MedicineHandlers) FindMedicineByIdHandler(c *gin.Context) {
	medicineId := c.Param("id")
	output, err := m.MedicineUseCase.FindMedicineById(medicineId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// // UpdatePyxisHandler godoc
// // @Summary Update a Medicine entity
// // @Description Update a Medicine entity
// // @Tags Medicines
// // @Accept json
// // @Produce json
// // @Param id path string true "Medicine ID"
// // @Param input body dto.UpdateMedicineInputDTO true "Medicine entity to update"
// // @Success 200 {object} dto.FindMedicineOutputDTO
// // @Failure 400 {object} map[string]interface{}
// // @Failure 404 {object} map[string]interface{}
// // @Failure 500 {object} map[string]interface{}
// // @Router /medicines/{id} [patch]
func (h *MedicineHandlers) UpdateMedicineHandler(c *gin.Context) {
	var input dto.UpdateMedicineInputDTO
	input.ID = c.Param("id")
	if err := c.BindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.MedicineUseCase.UpdateMedicine(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

// // DeleteMedicineHandler godoc
// // @Summary Delete a Medicine entity
// // @Description Delete a Medicine entity
// // @Tags Medicines
// // @Accept json
// // @Produce json
// // @Param id path string true "Medicine ID"
// // @Success 200 {string} string
// // @Failure 400 {object} map[string]interface{}
// // @Failure 404 {object} map[string]interface{}
// // @Failure 500 {object} map[string]interface{}
// // @Router /medicines/{id} [delete]
func (h *MedicineHandlers) DeleteMedicineHandler(c *gin.Context) {
	medicine_id := c.Param("id")
	err := h.MedicineUseCase.DeleteMedicine(medicine_id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	message := fmt.Sprintf("Medicine %s deleted successfully", medicine_id)
	c.JSON(http.StatusOK, gin.H{"message": message})
}
