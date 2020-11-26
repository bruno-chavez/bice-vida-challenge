package service

import (
	"errors"
	"testing"
)

type mockGetter struct{}

func (mockGetter) GetInsurance(url string) (Insurance, error) {
	if url == "ok" {
		body := Body{
			Name:        "Seguro Vida Activa",
			Description: "Con nuestro Seguro Vida Activa podrás disfrutar el día a día con tranquilidad, gracias al respaldo y apoyo frente a las consecuencias de eventuales accidentes que puedas sufrir. Posee excelente cobertura, un precio muy conveniente y, en caso de fallecimiento, apoyo financiero para tus seres queridos con un capital asegurado.",
			Price:       "9000",
			Image:       "https://ventaenlinea.bicevida.cl/pub/media/catalog/product/cache/69eb2560c3d44c78f7327201dc5a282b/i/m/img-01.jpg",
		}

		insurance := Insurance{Body: body}

		return insurance, nil
	}

	return Insurance{}, errors.New("something went wrong")
}

func TestService_GetInsurance_OK(t *testing.T) {

	mockGetter := mockGetter{}

	service := NewService(mockGetter, "ok")

	_, err := service.Insurance()
	if err != nil {
		t.Error(err)
	}
}

func TestService_GetInsurance_NotOK(t *testing.T) {

	mockGetter := mockGetter{}

	service := NewService(mockGetter, "not ok")

	_, err := service.Insurance()
	if err == nil {
		t.Error("should have returned an error")
	}
}
