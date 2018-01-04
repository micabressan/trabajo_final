var config Config
var db *sql.DB
var matchUserId string
var configArg = flag.String("-c", "--config")


func init(){
	configFile, err := os.Open(string(configArg))
	if *configArg == "" {
		flag.PrintDefaults("you did not specify a configuration file")
		os.Exit(1)
	}
	//configFile, err := os.Open("/opt/image_downloader/config.json")
	//configFile, err := os.Open("/Users/melnichenko/image_downloader/src/config.json")
	defer configFile.Close()
	if err != nil {
		log.Fatal(err)
	}
	jsonParser := json.NewDecoder(configFile)
	err = jsonParser.Decode(&config)
}

func init() {
	db, err := sql.Open("postgres", config.DbConnectString)
        if err != nil {
	        log.Fatal(err)
	}
	defer db.Close()

	err = db.Ping()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}