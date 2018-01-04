func nuskaitymas() {
	file, err := os.Open("IFF56_BorovikovasM_L3a_dat1.txt")
	if err != nil {
		panic(err)
	}
	defer file.Close()

	scanner := bufio.NewScanner(file)
	scanner.Scan()
	line := scanner.Text()
	a, err := strconv.Atoi(line)
	if err != nil {
		fmt.Print(err)
	}
	scanner.Scan()
	line = scanner.Text()
	b, err := strconv.Atoi(line)
	if err != nil {
		fmt.Print(err)
	}
	fmt.Println(a)
	fmt.Println(b)

	for i := 0; i < a; i++ {
		scanner.Scan()
		line := scanner.Text()
		if line != "" {
			s := strings.Split(line, " ")
			kiek, err := strconv.Atoi(s[1])
			if err != nil {
				fmt.Print(err)
			}
			fmt.Println(kiek)
			for j := 0; j < kiek; j++ {
				scanner.Scan()
				line := scanner.Text()
				if line != "" {
                    s := strings.Split(line, " ")
                    pav := s[0]
                    kiekis := s[1]
                    kaina := s[2]
                    fmt.Println(pav, kiekis, kaina)
				}
			}
		}
	}

	if err := scanner.Err(); err != nil {
		panic(err)
	}
}