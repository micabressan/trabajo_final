for {
		line, err := r.ReadString('\n')
		if line == "DONE\n" {
			break
		}

		res, _ := r.ReadString('\n')
		level, _ := r.ReadString('\n')
		typ, _ := r.ReadString('\n')

		

		D.addProblem(Problem{
			line[:len(line)-1],
			toResult(res[:len(res)-1]),
			int(level[:len(level)-1]),
			typ[:len(typ)-1],
		})

	}