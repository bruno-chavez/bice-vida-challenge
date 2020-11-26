package controller

import (
	"api/service"
)

type getter interface {
	Insurance() (service.Insurance, error)
}

type Controller struct {
	getter getter
}

func NewController(getter getter) *Controller {
	return &Controller{
		getter: getter,
	}
}
