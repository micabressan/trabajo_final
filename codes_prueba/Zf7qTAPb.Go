
type Saltador interface {
	Saltar()
}

type Coelho struct {}
func (Coelho c) Saltar() { }

type Robo struct {}
func (Robo c) Saltar() { }

func SaltaObstaculo(Saltador a) {
	a.Saltar()
}

SaltaObstaculo(new(Coelho))
SaltaObstaculo(new(Robo))