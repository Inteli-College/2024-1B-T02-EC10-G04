package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
)

type PyxisUseCase struct {
	PyxisRepository entity.PyxisRepository
}

func NewPyxisUseCase(pyxisRepository entity.PyxisRepository) *PyxisUseCase {
	return &PyxisUseCase{PyxisRepository: pyxisRepository}
}

func (p *PyxisUseCase) CreatePyxis(input *dto.CreatePyxisInputDTO) (*dto.CreatePyxisOutputDTO, error) {
	pyxis := entity.NewPyxis(input.Label)
	res, err := p.PyxisRepository.CreatePyxis(pyxis)
	if err != nil {
		return nil, err
	}
	return &dto.CreatePyxisOutputDTO{
		ID:    res.ID,
		Label: res.Label,
		CreatedAt: res.CreatedAt,
	}, nil
}

func (p *PyxisUseCase) FindAllPyxis() ([]*dto.FindPyxisOutputDTO, error) {
	res, err := p.PyxisRepository.FindAllPyxis()
	if err != nil {
		return nil, err
	}
	var output []*dto.FindPyxisOutputDTO
	for _, pyxis := range res {
		output = append(output, &dto.FindPyxisOutputDTO{
			ID:    pyxis.ID,
			Label: pyxis.Label,
			UpdatedAt: pyxis.UpdatedAt,
			CreatedAt: pyxis.CreatedAt,
		})
	}
	return output, nil
}

func (p *PyxisUseCase) FindPyxisById(id string) (*dto.FindPyxisOutputDTO, error) {
	pyxis, err := p.PyxisRepository.FindPyxisById(id)
	if err != nil {
		return nil, err
	}
	return &dto.FindPyxisOutputDTO{
		ID:    pyxis.ID,
		Label: pyxis.Label,
		UpdatedAt: pyxis.UpdatedAt,
		CreatedAt: pyxis.CreatedAt,
	}, nil
}

func (p *PyxisUseCase) UpdatePyxis(input *dto.UpdatePyxisInputDTO) (*dto.UpdatePyxisOutputDTO, error) {
	res, err := p.PyxisRepository.FindPyxisById(input.ID)
	if err != nil {
		return nil, err
	}
	
	//TODO: Implement update that does not require all fields of input DTO
	res.Label = input.Label

	res, err = p.PyxisRepository.UpdatePyxis(res)
	if err != nil {
		return nil, err
	}
	return &dto.UpdatePyxisOutputDTO{
		ID:    res.ID,
		Label: res.Label,
		UpdateAt: res.UpdatedAt,
	}, nil
}

func (p *PyxisUseCase) DeletePyxis(id string) error {
	pyxis, err := p.PyxisRepository.FindPyxisById(id)
	if err != nil {
		return err
	}
	return p.PyxisRepository.DeletePyxis(pyxis.ID)
}
