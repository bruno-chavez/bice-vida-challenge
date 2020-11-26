package controller

import (
	"encoding/json"
	"github.com/julienschmidt/httprouter"
	"log"
	"net/http"
)

func (h Controller) GetInsurance() httprouter.Handle {
	return func(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {

		w.Header().Set("Content-Type", "application/json")

		insurance, err := h.getter.Insurance()
		if err != nil {
			log.Println(err)

			w.WriteHeader(http.StatusNotFound)

			info := []byte(`{"error": "insurance not found"}`)
			_, err := w.Write(info)
			if err != nil {
				log.Println(err)
			}
			return
		}

		marshaledInsurance, err := json.Marshal(insurance)
		if err != nil {
			log.Println("error marshaling getter output: ", err)
			return
		}

		w.WriteHeader(http.StatusOK)
		_, err = w.Write(marshaledInsurance)
		if err != nil {
			log.Println(err)
		}
	}
}
