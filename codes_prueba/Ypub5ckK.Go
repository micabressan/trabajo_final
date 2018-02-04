package main

import (
	"net/http"

	"github.com/labstack/echo"
)

// Curso struct
type Curso struct {
	ID    uint   `json:"id"`
	Ativo uint   `json:"ativo,string"`
	Nome  string `json:"nome"`
}

var cursos = []Curso{
	Curso{ID: 1, Ativo: 1, Nome: "Matemática"},
	Curso{ID: 2, Ativo: 1, Nome: "Português"},
	Curso{ID: 3, Ativo: 1, Nome: "História"},
	Curso{ID: 4, Ativo: 1, Nome: "Geografia"},
}

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.JSON(http.StatusOK, cursos)
	})
	e.POST("/", func(c echo.Context) error {
		curso := new(Curso)
		c.Bind(&curso)
		cursos = append(cursos, *curso)
		return c.JSON(http.StatusOK, map[string]interface{}{
			"code":    http.StatusOK,
			"message": "SUCESSO",
		})
	})
	e.Start(":8080")
}