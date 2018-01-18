type Algo interface {
  A()
  B()
}

type Perrito struct {
}

func (a *Perrito) A(){}
func (a *Perrito) B(){}

var a Algo = Perrito{} // Esto no satisface la interface
var a Algo = &Perrito{} // Esto si