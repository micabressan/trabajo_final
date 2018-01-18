package main

import (
	"fmt"
)

type Animal struct {
	name string
	legs int
}

/*
 For some reason the signature:
    func (animals []Animal) bulkModify (f func(Animal) Animal) []Animal
 Doesn't work. This fixes that. #go-nuts on IRC advises against
*/
type Animals []Animal

func (animals Animals) bulkModifyMut(f func(Animal) Animal) Animals {
	for i, v := range animals {
		animals[i] = f(v)
	}
	return animals
}

func (animals Animals) bulkModify(f func(Animal) Animal) Animals {
	out := make(Animals, len(animals))
	copy(out, animals)
	return out.bulkModifyMut(f)
}

func manyLegs(animal Animal) Animal {
	animal.legs = 999
	return animal
}

func main() {
	zoo := Animals{Animal{"Dog", 4},
		Animal{"Chicken", 2},
		Animal{"Snail", 0},
	}
	fmt.Printf("-> Before update %v\n", zoo)
	fmt.Printf(
		"-> After update (updated) %v\n",
		zoo.bulkModify(manyLegs))
	fmt.Printf("-> After update (original) %v\n", zoo)
}