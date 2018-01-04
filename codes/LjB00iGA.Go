// THIS IS WHERE THE OBJECT IS SET UP

func NewLspClient(host string, port int) * LspClient{
	var udpAddr *net.UDPAddr;
	var error os.Error;
	serverStr := host+":"+strconv.Itoa(port)
	
	lspClient := new(LspClient)
	lspClient.HaveConneciton = true
	lspClient.Connid = -1
	lspClient.LastSentSeqNum = 0
	lspClient.LastRecvSeqNum = 0
	lspClient.EpochsSinceLastComm = 0
	lspClient.SendChan = make(chan *Packet, 1000)
	lspClient.RecvChan = make(chan *Packet)
	lspClient.Need2Resend = NewPacketBuffer()
	
	udpAddr,error = net.ResolveUDPAddr("udp", serverStr)
	if(error != nil){
			fmt.Printf("Error when establishing UDP connection to server %s -- Error is: %v\n",serverStr,error)
		}else{
			fmt.Printf("Established connection to %s\n",serverStr);
			// vlog(ALL, "Established connection to:\t"+serverStr)
		}
	lspClient.UdpAddr = udpAddr
	lspClient.Destination,error = net.ListenUDP("udp", udpAddr)
	if(error != nil){
		fmt.Printf("Error when making UDP connection to server %s -- Error is: %v\n",serverStr,error)
	}else{
		fmt.Printf("Set listenting to %s\n",serverStr);
		// vlog(ALL, "Established LISTENTING UDP with:\t"+serverStr)
	}
	
	go lspClient.networkSender()
	go lspClient.networkReceiver()
	go lspClient.epochHandler()
	
	lspClient.connectionRequest()

	return lspClient
}


// THIS IS THE CONNECTION REQUEST FUNCTION - THIS IS WHERE I HAVE ERRORS
func (cli *LspClient) connectionRequest(){
	connectionRequest := &Packet{Connid : 0, Seqnum : 0, Payload : nil}
	SendOnConnection(cli.Destination, cli.UdpAddr, connectionRequest)
}

// SEND FUNCTION
// Sends packet on the UDP connection connection.
func SendOnConnection(connection *net.UDPConn,  addr *net.UDPAddr, sendPacket *Packet){
	marshalled, error := json.Marshal(*sendPacket)
	if(error != nil){
		fmt.Println("[SendOnConnection] Error encountered when marshalling: error = %v",
								error)
	}
	bytesSent := 0
	for(bytesSent == 0){ // retry sending.......how many times?
		
		fmt.Printf("trying to send %v ...\n", sendPacket)
		fmt.Printf("connection:\t%v\n", connection)
		fmt.Printf("address:\t%v\n", addr)
		fmt.Printf("MARSHALLED:\t%s\n\n",marshalled)
		
		bytesSent,error = connection.WriteToUDP(marshalled, addr)
		fmt.Printf("error:\t%v\n",error)
		if(error != nil){
			fmt.Printf("[networkSender] Recieved error when sending packet %v: error is:: %v\n",
									sendPacket,error)
		}
	}
}