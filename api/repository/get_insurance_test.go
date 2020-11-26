package repository

import (
	"bytes"
	"errors"
	"io/ioutil"
	"net/http"
	"testing"
)

type getterMockHttpClient struct{}

func (getterMockHttpClient) Get(url string) (*http.Response, error) {

	if url == "ok" {

		json := `
{
    "insurance": {
        "name": "Seguro Vida Activa",
        "description": "Con nuestro Seguro Vida Activa podrás disfrutar el día a día con tranquilidad, gracias al respaldo y apoyo frente a las consecuencias de eventuales accidentes que puedas sufrir. Posee excelente cobertura, un precio muy conveniente y, en caso de fallecimiento, apoyo financiero para tus seres queridos con un capital asegurado.",
        "price": "9000",
        "image": "https://ventaenlinea.bicevida.cl/pub/media/catalog/product/cache/69eb2560c3d44c78f7327201dc5a282b/i/m/img-01.jpg"
    }
}
`
		body := ioutil.NopCloser(bytes.NewReader([]byte(json)))

		res := &http.Response{
			Status:     "OK",
			StatusCode: 200,
			Body:       body,
		}

		return res, nil
	}

	if url == "notFound" {
		res := &http.Response{
			Status:     "NotFound",
			StatusCode: 404,
			Body:       nil,
		}

		return res, nil
	}

	return nil, errors.New("something bad happened when fetching insurance")
}

func TestShowGetter_Insurance(t *testing.T) {

	mockHttpClient := &getterMockHttpClient{}

	repo := NewRepository(mockHttpClient)

	_, err := repo.GetInsurance("ok")
	if err != nil {
		t.Errorf("something broke in ok test: %v", err)
	}

	_, err = repo.GetInsurance("notFound")
	if err == nil {
		t.Errorf("something broke in notFound test: %v", err)
	}

	_, err = repo.GetInsurance("bad test")
	if err == nil {
		t.Errorf("something broke in notFound test: %v", err)
	}
}
