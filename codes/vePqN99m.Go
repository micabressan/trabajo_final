type RumorMessage struct {
	Origin  string
	RoundId uint32
	//Map player name to position or Direction
	Directions map[string] *pixel.Vec
}

type StatusPacket struct {
	Origin string
	RoundId uint32
	//Basically, this is a set...
	KnownDir map[string] *pixel.Vec
	//Basically, this is a set...
	Acks map[string] int
}