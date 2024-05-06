package http

import (
	"net/http"

	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/app"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"github.com/gin-gonic/gin"
)

func NewGinRouter(service *app.UserService) *gin.Engine {
	router := gin.Default()

	router.GET("/users/:id", func(c *gin.Context) {
		id := c.Param("id")
		user, err := service.GetUser(id)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, user)
	})

	router.POST("/users", func(c *gin.Context) {
		var user entity.User
		logger.Log.Info("Checking if the request is valid")
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		if err := service.CreateUser(&user); err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusCreated, user)
	})

	router.GET("/users", func(c *gin.Context) {
		logger.Log.Info("Getting all users")
		users, err := service.GetUsers()
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, users)
	})

	return router
}
