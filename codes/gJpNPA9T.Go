tx, errtx := db.Begin()
	if errtx != nil {
		return errtx
	}
	query := "UPDATE `account` SET `balance` = balance - ? WHERE `id` = ?;"
	_, errUpd := tx.Exec(query, amount, a.ID)
	if errUpd != nil {
		tx.Rollback()
		return errors.New("Error prepare update query for withdrawal balance for account.")
	}
	tx.Commit()
	return nil