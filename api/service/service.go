package service

type getter interface {
	Insurance() (Insurance, error)
}

type service struct {
	getter getter
}

func NewService(getter getter) *service {
	return &service{
		getter: getter,
	}
}
