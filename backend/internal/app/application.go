package app

import "github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"

type UserService struct {
	repo entity.UserRepository
}

func NewUserService(repo entity.UserRepository) *UserService {
	return &UserService{repo: repo}
}

func (s *UserService) GetUser(id string) (*entity.User, error) {
	return s.repo.FindByID(id)
}

func (s *UserService) CreateUser(user *entity.User) error {
	return s.repo.Create(user)
}

func (s *UserService) UpdateUser(user *entity.User) error {
	return s.repo.Update(user)
}
