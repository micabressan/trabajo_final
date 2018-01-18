func GetFusoHorario(relogio models.Relogio, connString string, dt time.Time)(time.Time, error){
	var db_config = config.GetDatabaseParams()
	var idFuso int
	var iniHoraVerao, fimHoraVerao time.Time
	var trash time.Time
	//Open database
	db, err := sql.Open(db_config.Driver, connString)
	if err != nil {
		return trash, err
	}

	rows, err := db.Query("SELECT ID_FUSO_HORA, DT_INI_HORA_VERAO, DT_FIM_HORA_VERAO FROM RELOGIO WHERE ID_RELOG =?1", relogio.Id)
	for rows.Next(){
		err = rows.Scan(&idFuso, &iniHoraVerao, &fimHoraVerao)
		if err != nil{
			return trash, err
		}
	}

	//verifica se esta dentro do horario de verao
	if dt.After(iniHoraVerao) == true && dt.Before(fimHoraVerao) == true{
		fmt.Println("Adicionando hora de verao")
		dt = dt.Add(time.Hour *1)
	}

	switch idFuso{
	case 1:
		dt = dt.Add(time.Hour * -11)
	case 2:
		dt = dt.Add(time.Hour * -10)
	case 3:
		dt = dt.Add(time.Hour * -9)
	case 4:
		dt = dt.Add(time.Hour * -8)
	case 5:
		dt = dt.Add(time.Hour * -7)
	case 6:
		dt = dt.Add(time.Hour * -6)
	case 7:
		dt = dt.Add(time.Hour * -5)
	case 8:
		dt = dt.Add(time.Hour * -4)
	case 9:
		dt = dt.Add((time.Hour * - 3) - (time.Hour/2))
	case 10:
		dt = dt.Add(time.Hour * - 3)
	case 11:
		dt = dt.Add(time.Hour *-2)
	case 12:
		dt = dt.Add(time.Hour *-1)
	case 13:
		dt = dt
	case 14:
		dt = dt.Add(time.Hour *1)
	case 15:
		dt = dt.Add(time.Hour *2)
	case 16:
		dt = dt.Add(time.Hour *3)
	case 17:
		dt = dt.Add((time.Hour * 3) + 30)
	case 18:
		dt = dt.Add(time.Hour *4)
	case 19:
		dt = dt.Add(time.Hour *5)
	case 20:
		dt = dt.Add((time.Hour * 5) + (time.Hour/2))
	case 21:
		dt = dt.Add(time.Hour *6)
	case 22:
		dt = dt.Add((time.Hour * 6) + (time.Hour/2))
	case 23:
		dt = dt.Add(time.Hour *7)
	case 24:
		dt = dt.Add(time.Hour *8)
	case 25:
		dt = dt.Add(time.Hour *9)
	case 26:
		dt = dt.Add(time.Hour *10)
	case 27:
		dt = dt.Add((time.Hour * 10) + (time.Hour/2))
	case 28:
		dt = dt.Add(time.Hour *11)
	case 29:
		dt = dt.Add((time.Hour * 11) + (time.Hour/2))
	case 30:
		dt = dt.Add(time.Hour *12)
	case 31:
		dt = dt.Add((time.Hour * 12) + (time.Hour/2) + (time.Hour/4))
	case 32:
		dt = dt.Add(time.Hour *14)
	case 34:
		dt = dt.Add(time.Hour * -12)
	default:
		dt = dt.Add(time.Hour * -3)
	}
	defer db.Close()
	return dt, nil
}