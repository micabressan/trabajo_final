body, err := ioutil.ReadAll(r.Body)
		defer r.Body.Close() // важный пункт!
		if err != nil {
			http.Error(w, err.Error(), 500)
			return
		}