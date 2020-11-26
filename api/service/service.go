package service

type getter interface {
	GetInsurance(string) (Insurance, error)
}

type service struct {
	getter getter
	url    string
}

func NewService(getter getter, url string) *service {
	return &service{
		getter: getter,
		url:    url,
	}
}
