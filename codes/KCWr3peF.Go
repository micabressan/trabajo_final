package main

import (
    "fmt"
)

type Animal struct {
	name string
	legs int
}

func bulkModifyAnimals(animals []Animal, f func(Animal) Animal) []Animal {
    out := make([]Animal, len(animals))
    for i, v := range animals {
        out[i] = f(v)
    }
    return out
}

func manyLegs(animal Animal) Animal {
    animal.legs = 999
    return animal
}

func main() {
    zoo := []Animal{ Animal{ "Dog", 4 },
        Animal{ "Chicken", 2 },
        Animal{ "Snail", 0 },
    }
    fmt.Printf("-> Before update %v\n", zoo)
    fmt.Printf(
        "-> After update (updated) %v\n",
        bulkModifyAnimals(zoo, manyLegs))
    fmt.Printf("-> After update (original) %v\n", zoo)
}