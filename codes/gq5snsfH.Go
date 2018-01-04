package vector

import (
	"sync"
)

type IVector interface {
	Len() int
	GetAt(int) float64
	SetAt(int, float64)
}

type Vector struct {
	sync.RWMutex
	vec []float64
}

func New(args ...float64) IVector {
	v := new(Vector)
	v.vec = make([]float64, len(args))

	for i, e := range args {
		v.SetAt(i, e)

	}

	return v
}

// The length of the vector
func (v *Vector) Len() int {
	return len(v.vec)
}

// Getter
func (v *Vector) GetAt(i int) float64 {
	if i < 0 || i >= v.Len() {
		panic("Index out of range")
	}

	return v.vec[i]
}

// Setter
func (v *Vector) SetAt(i int, data float64) {
	if i < 0 || i >= v.Len() {
		panic("Index out of range")
	}

	v.Lock()
	v.vec[i] = data
	v.Unlock()
}

/ Vector algebra delegating to function object.
// This method delegates vector algebra to function object set by users, making
// it faster then these methods relying on reflection.
func Apply(v1 IVector, v2 IVector, f func(float64, float64) float64) IVector {
	_len := v1.Len()

	if !(_len == v2.Len()) {
		panic("Unequal vector size")
	}

	out := WithSize(_len)

	var wg sync.WaitGroup

	for i := 0; i < _len; i++ {
		wg.Add(1)

		go func(v1 IVector, v2 IVector, out IVector, f func(float64, float64) float64, i int) {
			defer wg.Done()

			out.SetAt(i, f(v1.GetAt(i), v2.GetAt(i)))
		}(v1, v2, out, f, i)
	}

	wg.Wait()

	return out
}