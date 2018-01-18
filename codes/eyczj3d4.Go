package json

import (
        "reflect"
        "testing"
)

func TestSetNilSlice(t *testing.T) {
        var buf []byte = []byte{1, 2, 3} 
        v := reflect.ValueOf(buf)
        v.Set(reflect.Zero(v.Type()))
        if buf != nil {
                t.Fatal("Expected nil buf, was", buf)
        }  
}