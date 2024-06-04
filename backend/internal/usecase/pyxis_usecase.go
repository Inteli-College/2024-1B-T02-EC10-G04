package usecase

import (
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/dto"
	"github.com/Inteli-College/2024-1B-T02-EC10-G04/internal/domain/entity"
)

type PyxisUseCase struct {
	PyxisRepository         entity.PyxisRepository
	MedicinePyxisRepository entity.MedicinePyxisRepository
}

func NewPyxisUseCase(pyxisRepository entity.PyxisRepository, medicinePixysRepository entity.MedicinePyxisRepository) *PyxisUseCase {
	return &PyxisUseCase{PyxisRepository: pyxisRepository, MedicinePyxisRepository: medicinePixysRepository}
}

func (p *PyxisUseCase) CreatePyxis(input *dto.CreatePyxisInputDTO) (*dto.CreatePyxisOutputDTO, error) {
	pyxis := entity.NewPyxis(input.Label)
	res, err := p.PyxisRepository.CreatePyxis(pyxis)
	if err != nil {
		return nil, err
	}
	return &dto.CreatePyxisOutputDTO{
		ID:        res.ID,
		Label:     res.Label,
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
			ID:        pyxis.ID,
			Label:     pyxis.Label,
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
		ID:        pyxis.ID,
		Label:     pyxis.Label,
		UpdatedAt: pyxis.UpdatedAt,
		CreatedAt: pyxis.CreatedAt,
	}, nil
}

func (p *PyxisUseCase) UpdatePyxis(input *dto.UpdatePyxisInputDTO) (*dto.UpdatePyxisOutputDTO, error) {
	res, err := p.PyxisRepository.FindPyxisById(input.ID)
	if err != nil {
		return nil, err
	}

	//TODO: Implement update that does not require all fields of input DTO (Maybe i can do this only in the repository?)
	res.Label = input.Label

	res, err = p.PyxisRepository.UpdatePyxis(res)
	if err != nil {
		return nil, err
	}
	return &dto.UpdatePyxisOutputDTO{
		ID:       res.ID,
		Label:    res.Label,
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

func (p *PyxisUseCase) RegisterMedicine(id string, medicines []string) error {
	if _, err := p.PyxisRepository.FindPyxisById(id); err != nil {
		return err
	}

	_, err := p.MedicinePyxisRepository.CreateMedicinePixys(id, medicines)

	return err
}

func (p *PyxisUseCase) GetMedicinesFromPyxis(pyxis_id string) ([]*dto.FindMedicineOutputDTO, error) {
	medicines, err := p.MedicinePyxisRepository.FindMedicinesPyxis(pyxis_id)

	var output []*dto.FindMedicineOutputDTO
	for _, medicine := range medicines {
		output = append(output, &dto.FindMedicineOutputDTO{
			ID:        medicine.ID,
			Batch:     medicine.Batch,
			Name:      medicine.Name,
			Stripe:    medicine.Stripe,
			CreatedAt: medicine.CreatedAt,
			UpdatedAt: medicine.UpdatedAt,
		})
	}

	return output, err
}
