package service

type Body struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Price       string `json:"price"`
	Image       string `json:"image"`
}

type Insurance struct {
	Body Body `json:"insurance"`
}
