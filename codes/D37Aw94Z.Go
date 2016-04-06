 func minimumOddsTwo(s *betfair.Session, game GameWatch, gameToBet *betgame.BetGame) {

 	lDebug("minimumOddsTwo", "Time of first goal:v% ", gameToBet.FirstGoalTime)



	filename := "report.txt"

	fmt.Println("writing: " + filename)

	f, err := os.Create(filename)

	if err != nil {

		lErr("minimumOddsTwo", "Create file error:", err)

	}

	n, err := io.WriteString(f, "Time Of First Goal\n")