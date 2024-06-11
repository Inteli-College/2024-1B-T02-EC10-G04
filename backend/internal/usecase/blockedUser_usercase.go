package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
)

type BlockedUserUseCase struct {
	BlocekdUserRepository entity.BlockedUserRepository
}

func NewBlockedUserUseCase(blockedUserRepository entity.BlockedUserRepository) *BlockedUserUseCase {
	return &BlockedUserUseCase{BlocekdUserRepository: blockedUserRepository}
}

func (m *BlockedUserUseCase) CreateBlockedUser(input *dto.CreateBlockedUserInputDTO) (*dto.CreateBlockedUserOutputDTO, error) {
	blocked_user := entity.NewBlockedUser(input.UserId, input.BlockedBy, input.Reason)
	res, err := m.BlocekdUserRepository.CreateBlockedUser(blocked_user)
	if err != nil {
		return nil, err
	}
	return &dto.CreateBlockedUserOutputDTO{
		ID:        res.ID,
		UserId:    res.UserId,
		CreatedAt: res.CreatedAt,
		UpdatedAt: res.UpdatedAt,
		BlockedBy: res.BlockedBy,
		Reason:    res.Reason,
	}, nil
}

func (m *BlockedUserUseCase) FindAllMedicines() ([]*dto.FindBlockedUserOutputDTO, error) {
	res, err := m.BlocekdUserRepository.FindAllBlockedUsers()
	if err != nil {
		return nil, err
	}
	var output []*dto.FindBlockedUserOutputDTO
	for _, medicine := range res {
		output = append(output, &dto.FindBlockedUserOutputDTO{
			ID:        medicine.ID,
			Batch:     medicine.Batch,
			Name:      medicine.Name,
			Stripe:    medicine.Stripe,
			CreatedAt: medicine.CreatedAt,
			UpdatedAt: medicine.UpdatedAt,
		})
	}
	return output, nil
}

func (m *MedicineUseCase) FindMedicineById(id string) (*dto.FindMedicineOutputDTO, error) {
	medicine, err := m.MedicineRepository.FindMedicineById(id)
	if err != nil {
		return nil, err
	}
	return &dto.FindMedicineOutputDTO{
		ID:        medicine.ID,
		Batch:     medicine.Batch,
		Name:      medicine.Name,
		Stripe:    medicine.Stripe,
		CreatedAt: medicine.CreatedAt,
		UpdatedAt: medicine.UpdatedAt,
	}, nil
}

func (m *MedicineUseCase) UpdateMedicine(input *dto.UpdateMedicineInputDTO) (*dto.FindMedicineOutputDTO, error) {
	res, err := m.MedicineRepository.FindMedicineById(input.ID)
	if err != nil {
		return nil, err
	}

	//TODO: Implement update that does not require all fields of input DTO (Maybe i can do this only in the repository?)
	res.Batch = input.Batch
	res.Name = input.Name
	res.Stripe = input.Stripe

	updated_medicine, err := m.MedicineRepository.UpdateMedicine(res)
	if err != nil {
		return nil, err
	}
	return &dto.FindMedicineOutputDTO{
		ID:        updated_medicine.ID,
		Batch:     updated_medicine.Batch,
		Name:      updated_medicine.Name,
		Stripe:    updated_medicine.Stripe,
		CreatedAt: updated_medicine.CreatedAt,
		UpdatedAt: updated_medicine.UpdatedAt,
	}, nil
}

func (m *BlockedUserUseCase) DeleteBlockedUser(id string) error {
	blocked_user, err := m.BlocekdUserRepository.FindBlockedUserById(id)
	if err != nil {
		return err
	}
	return m.BlocekdUserRepository.DeleteBlockedUser(blocked_user.ID)
}
