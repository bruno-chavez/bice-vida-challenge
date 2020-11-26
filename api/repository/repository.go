package repository

import (
	"net/http"
)

type HttpClient interface {
	Get(string) (*http.Response, error)
}

type insuranceGetter struct {
	httpClient HttpClient
}

func NewRepository(httpClient HttpClient) *insuranceGetter {

	getter := &insuranceGetter{
		httpClient: httpClient,
	}

	return getter
}

func NewHttpClient() *http.Client {
	return http.DefaultClient
}
