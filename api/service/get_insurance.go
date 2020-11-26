package service

func (s service) Insurance() (Insurance, error) {

	insurance, err := s.getter.GetInsurance(s.url)
	if err != nil {
		return insurance, err
	}

	return insurance, nil
}
