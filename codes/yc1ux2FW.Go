package server

import (
	"net/http"
	"encoding/json"
)

type JsonError struct {
	Error interface{} `json:"error"`
}

type ErrorDetail struct {
	Errors map[string]string `json:"errors,omitempty"`
	Message string `json:"message"`
}

func (s *Server) RegisterApiV1(w http.ResponseWriter, r *http.Request) {

	if r.Method != "POST" {
		http.Error(w, http.StatusText(http.StatusMethodNotAllowed), 
			http.StatusMethodNotAllowed)
		return
	}

	var resp interface{}

	jsonDecoder := json.NewDecoder(r.Body)
	err := jsonDecoder.Decode(resp)
	if err != nil {
		resp, _ := json.Marshal(JsonError{
			Error: ErrorDetail{
				Message: "Неверный формат JSON",
			},
		})
		w.Write(resp)
	}

	w.Header().Set("Content-Type", "application/json")

	w.Write([]byte("{}"))
}