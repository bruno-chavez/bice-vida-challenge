package controller

import (
	"api/service"
	"github.com/julienschmidt/httprouter"
	"net/http/httptest"
	"testing"
)

type mockGetter struct{}

func (mockGetter) Insurance() (service.Insurance, error) {

	body := service.Body{
		Name:        "Seguro Vida Activa",
		Description: "Con nuestro Seguro Vida Activa podrás disfrutar el día a día con tranquilidad, gracias al respaldo y apoyo frente a las consecuencias de eventuales accidentes que puedas sufrir. Posee excelente cobertura, un precio muy conveniente y, en caso de fallecimiento, apoyo financiero para tus seres queridos con un capital asegurado.",
		Price:       "9000",
		Image:       "https://ventaenlinea.bicevida.cl/pub/media/catalog/product/cache/69eb2560c3d44c78f7327201dc5a282b/i/m/img-01.jpg",
	}

	insurance := service.Insurance{Body: body}

	return insurance, nil
}

func TestHandler_GetInsurance(t *testing.T) {
	getter := mockGetter{}

	controller := NewController(getter)

	req := httptest.NewRequest("GET", "/", nil)
	res := httptest.NewRecorder()
	p := httprouter.Params{}

	h := controller.GetInsurance()
	h(res, req, p)

	result := res.Body.String()
	expected := `{"insurance":{"name":"Seguro Vida Activa","description":"Con nuestro Seguro Vida Activa podrás disfrutar el día a día con tranquilidad, gracias al respaldo y apoyo frente a las consecuencias de eventuales accidentes que puedas sufrir. Posee excelente cobertura, un precio muy conveniente y, en caso de fallecimiento, apoyo financiero para tus seres queridos con un capital asegurado.","price":"9000","image":"https://ventaenlinea.bicevida.cl/pub/media/catalog/product/cache/69eb2560c3d44c78f7327201dc5a282b/i/m/img-01.jpg"}}`

	if res.Code != 200 {
		t.Errorf("Expected HTTP response 200 but got %d", res.Code)
	}

	if result != expected {
		t.Errorf("Expected body to contain value %q but got %q", expected, result)
	}
}
