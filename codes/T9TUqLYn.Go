package gorm_test

import (
	"log"
	"testing"

	"github.com/jinzhu/gorm"
)

type Owner struct {
	Name string
}

func (o *Owner) AfterCreate(tx *gorm.DB) (err error) {
	log.Println("Owner AfterCreate")

	// Now create a Parent object
	c := Child{Kid: "Bob"}
	children := []Child{c}
	p := Parent{Pops: "Pop",
		Children: children,
	}

	// Use same tx
	e := tx.Save(&p).Error
	if e != nil {
		log.Fatal("Parent save failed")
	}
	return
}

type Parent struct {
	Pops     string
	Children []Child
}

func (p *Parent) AfterCreate() (err error) {
	log.Println("Parent AfterCreate")
	return
}

type Child struct {
	Kid                  string
	Parent               Parent
	ParentID             int
	AfterCreateCallTimes int64
}

func (s *Child) AfterCreate(tx *gorm.DB) (err error) {
	log.Println("Child AfterCreate")
	tx.Model(s).UpdateColumn(Child{AfterCreateCallTimes: s.AfterCreateCallTimes + 1})
	return
}

func (s *Child) GetCallTimes() []int64 {
	return []int64{s.AfterCreateCallTimes}
}

func TestRunAssociationCallbacks(t *testing.T) {
	DB.LogMode(true)
	DB.AutoMigrate(&Owner{}, &Parent{}, &Child{})

	o := Owner{Name: "Hello"}
	DB.Save(&o)

	var c []Child
	DB.Find(&c)

	var p []Parent
	DB.Find(&p)

	if len(c) > 1 {
		t.Errorf("More than 1 child created!")
	}

	if len(p) > 1 {
		t.Errorf("More than 1 parent created!")
	}

	times := c[0].GetCallTimes()
	if times[0] != 1 {
		t.Errorf("Child AfterCreate never called!")
	}

	/*
		for i, v := range c {
			log.Printf("%v: Child: %#v", i, v)
		}

		for i, v := range p {
			log.Printf("%v: Parent: %#v", i, v)
		}
	*/
}