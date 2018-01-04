package main

import (
	"fmt"
	"time"
)
//Non costruisco la struct di broker, poichè è solo colui che smista i messaggi nella mia config
type Sensor struct {
	id int
	topicsS map[int]string
	value int
}

type Actuator struct {
	id int
	topicsA map[int][]string
}
type Message struct {

	topic string
	value int
}
//al momento tutti gli attori e i topic sono costanti, poi si potrebbero mettere interattivi
const numactuators = 3
const numsensors   = 3
const numtopics    = 2
//uso delle variabili globali cosicchè istanzio solo una volta la memoria per le funzioni che vengono richiamate più volte
//alla fine, li usiamo sempre nel nostro progetto
var csensor   [numsensors]chan Sensor
var cactuator [numactuators]chan Actuator
var cbroker   chan Message
var attuatore  [numactuators]Actuator
var sensore    [numsensors]Sensor

//la funzione main non fa altro che le routine normali SEQUENZIALI alle quali sono associate go routine "multithread"
func main() {

	sensors(true)
	actuators(true,nil,0)
	sensors(false)

}

//la booleana registration, serve per la connect e per il make dei channel e dei topics,
//il message è il tipo di channel che prende per poi processaarlo
//l'id lo userò per la funzione del broker per stampare a schermo(e poi eventualmente si userà per altro..tipo liste ecc)
func actuators(registration bool, message chan Message, id int){

	numact  := numactuators

	ida := 0

	if registration {
		for i := range cactuator {
			cactuator[i] = make(chan Actuator)
		}

		topicsA := &Actuator{
			topicsA: make(map[int][]string),
		}

		//al momento, sto usando gli stessi topic per ogni attuatore, poi ovviamente si possono cambiare
		for (numact > 0) {
			topicsA.topicsA[ida] = []string{"topic1", "topic4"}
			go broker(nil, cactuator[numact-1], true)
			cactuator[numact-1] <- Actuator{ida, topicsA.topicsA}
			ida++
			time.Sleep(1 * time.Second)
			<-cactuator[numact-1]
			numact--

		} //l'else serve ad accogliere i messaggi del broker e a stampare su schermo ciò che riceve l'attuatore
	}else{
		select{
			case x := <-message:
				fmt.Println("Acutator",id,"received",x.topic,"with value",x.value)
		}
	}
}
//stesso discorso dell'attuatore per il bool
func sensors(registration bool){

	numsens := numsensors
	ids := 0

	if registration {
		for i := range csensor {
			csensor[i] = make(chan Sensor)
		}

		for numsens > 0 {
			go broker(csensor[numsens-1], nil, true)
			csensor[numsens-1] <- Sensor{ids, nil, 0}//non servono nè topic nè value per la registrazione
			ids++
			time.Sleep(1 * time.Second)
			<-csensor[numsens-1]
			numsens--
		}
	}else{
		topicsS := &Sensor{
			topicsS: make(map[int]string),
		}

		for numsens > 0 {
			go broker(csensor[numsens-1], nil, false)
			topicsS.topicsS[ids] = "topic1"// per ora, topic uguale per tutti i sensori
			csensor[numsens-1] <- Sensor{ids, topicsS.topicsS, 50}//poi il value sarà random
			ids++
			time.Sleep(1 * time.Second)
			<-cbroker//questo serve per non far andare in deadlock il broker così non si aspettano a vicenda con csensor
			<-csensor[numsens-1]
			numsens--
		}
	}
}
//variabili di loop per riempire gli array di struct actuator e di struct Sensor (potrebbero anche essere provvisori, mi interessava la communication al momento)
var i = 0
var j = 0
func broker(sensor chan Sensor, actuator chan Actuator, registration bool) {

	//registrazione di sensori e attuatori e negli attuatori salvo su array di struct Actuator e stampo un verbose ovunque.
	if registration {
		select{
			case connectS := <-sensor:
				fmt.Println("Sensor",connectS.id," registered")
				time.Sleep(100 * time.Millisecond)
				sensor <- connectS
			case x :=<-actuator:
				attuatore[i] = Actuator{x.id,x.topicsA}
				fmt.Println("Actuator",attuatore[i].id," registered with topics",attuatore[i].topicsA[attuatore[i].id])
				i++
				time.Sleep(100 * time.Millisecond)
				actuator <- attuatore[i-1]

		}
	}else{
		cbroker = make(chan Message)
		select{
			case connectS := <-sensor:
				//salvo su array di struct Sensor
				sensore[j]  = Sensor{connectS.id,connectS.topicsS,connectS.value}
				j++
				fmt.Println("Broker : received",connectS.topicsS[connectS.id],"with value", connectS.value,"From Sensor",connectS.id)
				time.Sleep(100 * time.Millisecond)
				//scorro sugli attuatori e vedo se il topic serve a quaalcuno e lo mando nel caso.
				for i := range attuatore {
					for j :=0; j<numtopics; j++{
						if attuatore[i].topicsA[i][j] == connectS.topicsS[connectS.id] {
							go actuators(false,cbroker,i)
							cbroker <- Message{connectS.topicsS[connectS.id],connectS.value}
							time.Sleep(1 * time.Second)

						}
					}
				}
				sensor <- connectS

		}

	}

}