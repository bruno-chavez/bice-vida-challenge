package repository

import (
	"net/http"
	"testing"
)

func TestNewHttpClient(t *testing.T) {
	client := NewHttpClient()

	if client != http.DefaultClient {
		t.Error("something broke in NewHttpClient")
	}
}
