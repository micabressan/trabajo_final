reader := bufio.NewReader(csvFile)
lineStr, _ = reader.ReadString('\n')
line := strings.Split(lineStr, separator)
uf, _ := strconv.Atoi(line[1])