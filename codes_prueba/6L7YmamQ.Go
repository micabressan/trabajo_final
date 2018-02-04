package main

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

func main() {
	prom := exec.Command("tail", "-f /dev/null")
	done := make(chan error)
	go func() {
		done <- prom.Run()
	}()

	prom.Process.Signal(os.Interrupt)
	<-done

	pid, e := os.FindProcess(prom.Process.Pid)

	fmt.Println(pid.Pid) // Here it always returns some PID as if the process hasn't stopped yet.
	fmt.Println(e)
}