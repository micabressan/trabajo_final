package main

import (
	"fmt"
	"gopkg.in/mgo.v2"
	"gopkg.in/mgo.v2/bson"
)

type Student struct {
	ID     int `bson:"_id,omitempty"`
	Scores []Score
}

type Score struct {
	Type  string
	Score float64
}

func main() {
	session, err := mgo.Dial("localhost:27017")
	if (err != nil) {
		panic("Cannot connect to mongodb")
	}

	c := session.DB("school").C("students_copy")

	var students []Student

	err = c.Find(bson.M{}).All(&students)
	if err != nil {
		panic("Documtnts not found")
	}

	for _, student := range students {
		var minScore float64 = 100

		for _, score := range student.Scores {
			if score.Type == "homework" && minScore > score.Score {
				minScore = score.Score
			}
		}

		var newScores []Score

		for _, score := range student.Scores {
			if score.Score != minScore {
				newScores = append(newScores, score)
			}
		}

		c.Update(bson.M{"_id": student.ID}, bson.M{"$set": bson.M{"scores": newScores}})
	}

	fmt.Println("Done")
}