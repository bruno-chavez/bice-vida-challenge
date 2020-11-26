package service

type body struct {
	Name        string `json:"name"`
	Description string `json:"description"`
	Price       string `json:"price"`
	Image       string `json:"image"`
}

type Insurance struct {
	Body body `json:"insurance"`
}

func (s service) Insurance() (Insurance, error) {

	insurance, err := s.getter.Insurance()
	if err != nil {
		return insurance, err
	}

	return insurance, nil
}
