package app

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"golang.org/x/crypto/bcrypt"
)

type UserService struct {
	repo entity.UserRepository
}

func NewUserService(repo entity.UserRepository) *UserService {
	return &UserService{repo: repo}
}

func (s *UserService) GetUsers() ([]*entity.User, error) {
	return s.repo.FindAll()
}

func (s *UserService) GetUser(id string) (*entity.User, error) {
	return s.repo.FindByID(id)
}

func (s *UserService) CreateUser(user *entity.User) error {
	// Gerar um hash da senha do usuário
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}

	// Substituir a senha do usuário pelo hash gerado
	user.Password = string(hashedPassword)
	logger.Log.Info(user)
	// Salvar o usuário no banco de dados
	return s.repo.Create(user)
}

func (s *UserService) UpdateUser(user *entity.User) error {
	return s.repo.Update(user)
}
