package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/config/logger"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"golang.org/x/crypto/bcrypt"
)

type UserUsecase struct {
	repo entity.UserRepository
}

func NewUserUsecase(repo entity.UserRepository) *UserUsecase {
	return &UserUsecase{repo: repo}
}

func (s *UserUsecase) GetUsers() ([]*entity.User, error) {
	return s.repo.FindAll()
}

func (s *UserUsecase) GetUser(id string) (*entity.User, error) {
	return s.repo.FindByID(id)
}

func (s *UserUsecase) CreateUser(user *entity.User) error {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(user.Password), bcrypt.DefaultCost)
	if err != nil {
		return err
	}
	user.Password = string(hashedPassword)
	logger.Log.Info(user)
	return s.repo.Create(user)
}

func (s *UserUsecase) UpdateUser(user *entity.User) error {
	return s.repo.Update(user)
}
