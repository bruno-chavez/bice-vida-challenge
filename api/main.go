package main

import (
	"api/controller"
	"api/repository"
	"api/server"
	"api/service"
	"log"
	"net/http"
	"time"
)

func main() {

	// Makes error line show for log.Println()
	log.SetFlags(log.LstdFlags | log.Llongfile)

	repo := repository.NewRepository(repository.NewHttpClient())
	s := service.NewService(repo, "https://dn8mlk7hdujby.cloudfront.net/interview/insurance/58")
	c := controller.NewController(s)

	handler, err := server.MakeHandler(c)
	if err != nil {
		log.Println(err)
	}

	srvr := http.Server{
		Addr:         ":8080",
		Handler:      handler,
		ReadTimeout:  5 * time.Second,
		WriteTimeout: 5 * time.Second,
		IdleTimeout:  120 * time.Second,
	}

	log.Println("server started")
	err = srvr.ListenAndServe()
	if err != nil {
		log.Println(err)
	}
	log.Println("server exited properly")
}
