package main

import (
	"bufio"
	"errors"
	"fmt"
	"log"
	"os"
	"regexp"
	"strconv"
	"strings"
)

// train struct is used to create a train or to purchase a number of seats
// for the specified train
type train struct {
	trainID   string
	seats     int
	freeSeats int
}

func (t train) buySeats(seats int) error {
	if t.freeSeats < seats {
		err := errors.New("Evento COMPRAR con numero de billetes insuficientes")
		return err
	}
	t.freeSeats = t.freeSeats - seats

	return nil
}

// Given an array of trains and a trainID it returns the train struct if exsists
func findTrainByID(trains []train, trainID string) *train {
	for _, train := range trains {
		if train.trainID == trainID {
			return &train
		}
	}
	return nil
}

// Function to parse line
// line expected to be: ACTION#TRAIN#SEATS
// output: ACTION , TRAINID, SEATS , ERROR
func parseLine(line string) (string, string, int, error) {
	var action string
	var trainID string
	var seats int

	lineParameters := strings.Split(line, `#`)
	// ERROR: Numero de # incorrecto
	if len(lineParameters) != 3 {
		err := errors.New("Numero de # incorrecto")
		return "", "", 0, err
	}
	// ERROR: Evento incorrecto
	if !(lineParameters[0] == "CREAR" || lineParameters[0] == "COMPRAR") {
		err := errors.New("Evento incorrecto")
		return "", "", 0, err
	}
	action = lineParameters[0]
	// Regular Expression to check trainID format
	trainIDRegExp := regexp.MustCompile(`^[A-Z]{2}_[A-Z]{2}_[0-9]+$`)
	if !trainIDRegExp.MatchString(lineParameters[1]) {
		err := errors.New("Tren incorrecto")
		return "", "", 0, err
	}
	trainID = lineParameters[1]

	seats, err := strconv.Atoi(lineParameters[2])
	if err != nil {
		err := errors.New("Numero de asientos incorrecto")
		return "", "", 0, err
	}

	return action, trainID, seats, nil
}

func main() {
	// Array of trains
	var trains []train

	// Expect input file path argument
	if len(os.Args) != 2 {
		log.Fatal("Usage: tenfe input-file")
	}
	// Read input file content
	file, err := os.Open(os.Args[1])
	if err != nil {
		log.Fatalf("Cannot read configuration file (%v)", err)
	}
	defer file.Close()

	// Output counters
	i := 1
	wrong := 0

	scanner := bufio.NewScanner(file)
	// Iterate line by line
	for scanner.Scan() {
		line := scanner.Text()
		fmt.Printf("\n*** Leemos linea %d-->%s\n", i, line)
		action, trainID, seats, err := parseLine(line)
		if err != nil {
			fmt.Printf("Error en linea %d: %s\n", i, err)
			wrong = wrong + 1
		} else {
			t := findTrainByID(trains, trainID)
			switch {
			case action == "CREAR":
				// Train already exists
				if t != nil {
					fmt.Printf("Error en linea %d: Evento CREAR con tren existente\n", i)
					wrong = wrong + 1
				} else {
					newTrain := train{trainID: trainID, seats: seats, freeSeats: seats}
					// Add newTrain to array of trains
					trains = append(trains, newTrain)
				}
			case action == "COMPRAR":
				// Inexistent train
				if t == nil {
					fmt.Printf("Error en linea %d: Evento COMPRAR con tren inexistente\n", i)
					wrong = wrong + 1
				} else {
					err := t.buySeats(seats)
					if err != nil {
						fmt.Printf("Error en linea %d: %s\n", i, err)
						wrong = wrong + 1
					}
				}
			}
		}
		i = i + 1
	}
	// output
	fmt.Printf("Se trataron %d lineas, siendo %d incorrectas\n", i, wrong)

	for _, train := range trains {
		fmt.Printf("Tren %s Plazas totales: %d Plazas libres: %d\n", train.trainID, train.seats, train.freeSeats)
	}

	// Scanner error
	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}
}