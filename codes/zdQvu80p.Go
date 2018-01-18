func RequestDiction() {
	response, err := http.Get("http://IP:1026/v2/entities/User?options=values&attrs=dictionary")
	defer response.Body.Close()

	if err != nil {
		log.Fatalf("ERROR: %s", err)
	}

	body, err := ioutil.ReadAll(response.Body)
	if err != nil {
		log.Fatalf("ERROR: %s", err)
	}
	bodyString := string(body)
	str45 := strings.Replace(bodyString, "\"", "", -1)
	sDec, _ := b64.StdEncoding.DecodeString(str45)
	fmt.Println(str45)
	fmt.Println(string(sDec))

}