package main

type IServer interface {
  getTime(Sender *SSender) int
  sendTo(Sender *SSender, ReceiverId int, data []byte)
}

type SSender struct {
  Id              int
  NumberOfSenders int
  Times           []int
  server          IServer
  data            interface{}
}

func NewSender(id int, numberOfSenders int, server IServer) *SSender {
  Sender := new(SSender)
  Sender.Id = id
  Sender.NumberOfSenders = numberOfSenders
  Sender.server = server
  Sender.Times = make([]int, numberOfSenders)
  for i := range Sender.Times {
    Sender.Times[i] = 0
  }
  return Sender
}

func (Sender *SSender) send(receiverId int) {
  time := Sender.server.getTime(Sender)
  Sender.server.sendTo(Sender, receiverId, []byte{})
}

func (sender *SSender) receive(data []byte) bool {
  return false
}