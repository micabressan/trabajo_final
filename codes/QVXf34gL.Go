// Check if any pending alerts should be removed or fire now. Write out alert timeseries.
	for fp, a := range r.active {
		fmt.Println("S")
		if _, ok := resultFPs[fp]; !ok {
			fmt.Println("HERE1")
			// If the alert was previously firing, keep it around for a given
			// retention time so it is reported as resolved to the AlertManager.
			if a.State == StatePending || (!a.ResolvedAt.IsZero() && ts.Sub(a.ResolvedAt) > resolvedRetention) {
				fmt.Println("HERE2")
				delete(r.active, fp)
			}
			if a.State != StateInactive {
				fmt.Println("HERE3")
				a.State = StateInactive
				a.ResolvedAt = ts
				a.FiredAt = time.Time{}
				fmt.Printf("timeStamp: %v, firedAt %v", a.ResolvedAt, a.FiredAt)
			}
			continue
		}

		if a.State == StatePending && ts.Sub(a.ActiveAt) >= r.holdDuration {
			fmt.Println("HERE4")
			a.State = StateFiring
			a.FiredAt = ts
		}

		// if a.State == StateFiring && ts.Sub(a.ActiveAt) < r.holdDuration {
		// 	fmt.Println("HERE7")
		// 	a.State = StateInactive
		// 	a.FiredAt = ts
		// }

		fmt.Println("HERE5")
		vec = append(vec, r.sample(a, ts))
	}
	fmt.Println("HERE6")
	return vec, nil
}