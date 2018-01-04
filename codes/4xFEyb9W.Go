	rows, err := db.Query("EXEC PRCATUALIZACOES @IDVEICULO=" + urlqry.Get("idveiculo") + ", @TAMANHOPAGINA=1, @NUMEROPAGINA=1, @SATELITAL=" + Satelital)

	defer rows.Close()

	if err != nil {
		GeraLog(err.Error())
		return
	}

	if rows.Next() {
		columns, err := rows.ColumnTypes()
		if err != nil {
			GeraLog(err.Error())
			return
		}

		values := make([]interface{}, len(columns))
		object := map[string]interface{}{}

		for i, column := range columns {
			//object[column.Name()] = reflect.New(column.ScanType()).Interface()
			//values[i] = object[column.Name()]
			object[column.Name()] = new(sql.RawBytes)
			values[i] = object[column.Name()]
		}

		err = rows.Scan(values...)
		if err != nil {
			GeraLog(err.Error())
			return
		}

		JsonUltimaPosicao.Status.Cod = "1"
		JsonUltimaPosicao.Status.Msg = "Sucesso."
		JsonUltimaPosicao.Info = object
	} else {
		JsonUltimaPosicao.Status.Cod = "-3"
		JsonUltimaPosicao.Status.Msg = "Nenhuma posicao ainda registrada para este alvo, ou o alvo informado e invalido."
	}

	json.NewEncoder(w).Encode(&JsonUltimaPosicao)