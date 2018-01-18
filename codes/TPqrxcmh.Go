package main

import "fmt"
import "flag"
import "./message"

func main() {
    nodesCntPtr := flag.Int("n", 0, "nodes cnt")
    //withholdingPtr := flag.Int("t", 0, "withholding time")
    flag.Parse()

    doneChan := make(chan int)
    cnt := 0
	for i := 0; i < *nodesCntPtr; i++ {
		go start(i, *nodesCntPtr, doneChan)
        cnt++;
	}
	for i := 0; i < *nodesCntPtr; i++ {
		<-doneChan
	}

    fmt.Println(cnt)

}

func start(nodeId int, nodesCnt int, leaderId int, doneChan chan int) {
    monitorId = 0
    msgPort, servicePort = 30000, 40000
    prev, next = (nodeId + 1) % nodesCnt, (nodeId - 1) % nodesCnt

    ServerAddr, err := net.ResolveUDPAddr("udp",":10001")
    CheckError(err)

    ServerConn, err := net.ListenUDP("udp", ServerAddr)
    CheckError(err)
    defer ServerConn.Close()

    ServerAddr, err := net.ResolveUDPAddr("udp",":10001")
    CheckError(err)

    ServiceServerConn, err := net.ListenUDP("udp", ServerAddr)
    CheckError(err)
    defer ServerConn.Close()


    buf := make([]byte, 1024)

    if nodeId == leaderId {
        CheckError(ServerConn.SetReadDeadline(time.Now().Add(time.Second * 4)))
    }
    textToSends := ""
    for {
        select {
        case n, addr, err := ServerConn.ReadFromUDP(buf):
            if nodeId == leaderId {
                if addr == nil {
                    sendUdp("", next)
                }
                CheckError(ServerConn.SetReadDeadline(time.Now().Add(time.Second * 4)))
                continue
            }
            msg := buf[0:n]
            if empty(msg) {
                if (empty(msgToSend)) {
                    sendUdp(msg, next)
                } else {
                    sendMsg(nodeId, next, addresantId, textToSend, ServerConn)
                    textToSend = ""
                }
            } else {
                sendUdp(msg, next)
            }
        case n, addr, err := ServiceServerConn.ReadFromUDP(buf):
            msg := NewMsg(buf[0:n])
            if NewMsg()
        }
    }

    doneChan <- 1
}

func sendMsg(nodeId, next, addresantId, msgToSends int, ServerConn struct {}) {
    sendUdp(msgToSend, next)

    CheckError(ServerConn.SetReadDeadline(time.Now().Add(time.Second * 4)))
    for {
        n, addr, err := ServerConn.ReadFromUDP(buf)
        msg := buf[0:n]
        if isMsgForMe(msg) && getMsgText(msg) == "Accept" {
            return
        }
        sendUdp(msgToSend, next)
        CheckError(ServerConn.SetReadDeadline(time.Now().Add(time.Second * 4)))
    }
}

func sendUdp(msg, port) {
    ServerAddr,err := net.ResolveUDPAddr("udp","127.0.0.1:" + port)
    CheckError(err)

    LocalAddr, err := net.ResolveUDPAddr("udp", "127.0.0.1:0")
    CheckError(err)

    Conn, err := net.DialUDP("udp", LocalAddr, ServerAddr)
    CheckError(err)

    buf := []byte(msg)
    _,err := Conn.Write(buf)

    ServerConn.Close()
}

func empty(msg string) {
    return msg != ""
}

func CheckError(err error) {
    if err  != nil {
        fmt.Println("Error: " , err)
        os.Exit(0)
    }
}