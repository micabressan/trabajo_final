func Read() (kasior [] krepsininkas) {
	file, err := os.Open("data.txt") // just pass the file name
    if err != nil {
        fmt.Print(err)
	}

	kasior = make([] krepsininkas, 0)

	scanner := bufio.NewScanner(file)
	scanner.Scan();
	for scanner.Scan(){
		line := scanner.Text()
		if(line != ""){
			s := strings.Split(line," ")
			sk, err := strconv.Atoi(s[1])
			if(err != nil){
				fmt.Print(err)}
			fl, err := strconv.ParseFloat(s[2],64)
			if(err != nil){
				fmt.Print(err)}
			kreps := krepsininkas{s[0], sk, fl}
			kasior = append(kasior,kreps)
	}
	}

	if err := scanner.Err(); err != nil {
		log.Fatal(err)
	}

		return
    }