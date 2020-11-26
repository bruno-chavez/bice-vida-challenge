package server

import (
	"api/controller"
	"github.com/julienschmidt/httprouter"
	"net/http"
)

func MakeHandler(controller *controller.Controller) (http.Handler, error) {

	router := httprouter.New()

	router.GET("/", controller.GetInsurance())

	// health check
	router.GET("/health", func(w http.ResponseWriter, _ *http.Request, _ httprouter.Params) {

		w.Header().Set("Content-Type", "application/json")
		w.WriteHeader(http.StatusOK)

		info := []byte(`{"version": "0.0.1"}`)

		_, err := w.Write(info)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
		}
	})

	h := http.Handler(router)

	return h, nil
}