package handler

import (
	"fmt"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/usecase"
	"github.com/gin-gonic/gin"
	"net/http"
)

type UserHandlers struct {
	UserUseCase *usecase.UserUseCase
}

func NewUserHandlers(userUseCase *usecase.UserUseCase) *UserHandlers {
	return &UserHandlers{
		UserUseCase: userUseCase,
	}
}

func (h *UserHandlers) CreateUser(c *gin.Context) {
	var input dto.CreateUserInputDTO
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.UserUseCase.CreateUser(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusCreated, output)
}

func (h *UserHandlers) FindAllUsersHandler(c *gin.Context) {
	output, err := h.UserUseCase.FindAllUsers()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

func (h *UserHandlers) FindUserByIdHandler(c *gin.Context) {
	var input dto.FindUserByIdInputDTO
	input.ID = c.Param("id")
	output, err := h.UserUseCase.FindUserById(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

func (h *UserHandlers) UpdateUserHandler(c *gin.Context) {
	var input dto.UpdateUserInputDTO
	input.ID = c.Param("id")
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.UserUseCase.UpdateUser(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}

func (h *UserHandlers) DeleteUserHandler(c *gin.Context) {
	var input dto.DeleteUserInputDTO
	input.ID = c.Param("id")
	err := h.UserUseCase.DeleteUser(input.ID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	message := fmt.Sprintf("User %s deleted successfully", input.ID)
	c.JSON(http.StatusOK, gin.H{"message": message})
}

func (h *UserHandlers) LoginUser(c *gin.Context) {
	var input dto.LoginUserInputDTO
	if err := c.ShouldBindJSON(&input); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	output, err := h.UserUseCase.LoginUser(&input)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, output)
}
