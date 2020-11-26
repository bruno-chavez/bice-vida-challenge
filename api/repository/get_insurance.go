package repository

import (
	"api/service"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

func (r insuranceGetter) GetInsurance(url string) (service.Insurance, error) {

	log.Println("getting insurance from service")

	var insurance service.Insurance
	response, err := r.httpClient.Get(url)
	if err != nil {
		return insurance, fmt.Errorf("network error requesting insurance: %w", err)
	}

	if response.StatusCode != http.StatusOK {
		return insurance, fmt.Errorf("not ok response from http client: %v", response.Status)
	}

	err = json.NewDecoder(response.Body).Decode(&insurance)
	if err != nil {
		return insurance, fmt.Errorf("error decoding insurance body: %w", err)
	}

	err = response.Body.Close()
	if err != nil {
		return insurance, fmt.Errorf("error closing insurance body: %w", err)
	}

	return insurance, nil
}
