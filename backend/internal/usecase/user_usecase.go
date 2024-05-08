package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
	"golang.org/x/crypto/bcrypt"
)

type UserUseCase struct {
	UserRepository entity.UserRepository
}

func NewUserUseCase(userRepository entity.UserRepository) *UserUseCase {
	return &UserUseCase{
		UserRepository: userRepository,
	}
}

func (u *UserUseCase) CreateUser(input *dto.CreateUserInputDTO) (*dto.CreateUserOutputDTO, error) {
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}
	user := entity.NewUser(input.Name, input.Email, string(hashedPassword), input.Role)
	res, err := u.UserRepository.CreateUser(user)
	if err != nil {
		return nil, err
	}
	return &dto.CreateUserOutputDTO{
		ID:    res.ID,
		Name:  res.Name,
		Email: res.Email,
		Role:  res.Role,
		OnDuty: res.OnDuty,
		CreatedAt: res.CreatedAt,
	}, nil
}

func (u *UserUseCase) FindUserById(id string) (*dto.FindUserOutputDTO, error) {
	res, err := u.UserRepository.FindUserById(id)
	if err != nil {
		return nil, err
	}
	return &dto.FindUserOutputDTO{
		ID:        res.ID,
		Name:      res.Name,
		Email:     res.Email,
		Role:      res.Role,
		OnDuty:    res.OnDuty,
		CreatedAt: res.CreatedAt,
		UpdatedAt: res.UpdatedAt,
	}, nil
}

func (u *UserUseCase) FindAllUsers() ([]*dto.FindUserOutputDTO, error) {
	res, err := u.UserRepository.FindAllUsers()
	if err != nil {
		return nil, err
	}
	var output []*dto.FindUserOutputDTO
	for _, user := range res {
		output = append(output, &dto.FindUserOutputDTO{
			ID:        user.ID,
			Name:      user.Name,
			Email:     user.Email,
			Role:      user.Role,
			OnDuty:    user.OnDuty,
			CreatedAt: user.CreatedAt,
			UpdatedAt: user.UpdatedAt,
		})
	}
	return output, nil
}

func (u *UserUseCase) UpdateUser(input *dto.UpdateUserInputDTO) (*dto.UpdateUserOutputDTO, error) {
	res, err := u.UserRepository.FindUserById(input.ID)
	if err != nil {
		return nil, err
	}

	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(input.Password), bcrypt.DefaultCost)
	if err != nil {
		return nil, err
	}

	user := entity.NewUser(input.Name, input.Email, string(hashedPassword), input.Role)
	user.ID = res.ID
	user.OnDuty = input.OnDuty

	res, err = u.UserRepository.UpdateUser(user)
	if err != nil {
		return nil, err
	}

	return &dto.UpdateUserOutputDTO{
		ID:        res.ID,
		Name:      res.Name,
		Email:     res.Email,
		Role:      res.Role,
		OnDuty:    res.OnDuty,
		UpdatedAt: res.UpdatedAt,
	}, nil
}

func (u *UserUseCase) DeleteUser(id string) error {
	user, err := u.UserRepository.FindUserById(id)
	if err != nil {
		return err
	}
	return u.UserRepository.DeleteUser(user.ID)
}