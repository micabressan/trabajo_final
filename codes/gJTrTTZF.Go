// 2018-01-17 Sofyan
func StudentIsAssistant_Combobox() M.SS {
	query := `SELECT id
  , data->>'full_name' || ' (Asdos)' AS full_name
FROM users
WHERE COALESCE(data->>'is_assistant', 'false')='true'
AND data->>'lecturer_type'='Asdos'
AND data->>'is_student'='true'
AND is_deleted = false
AND data->>'student_status'='A'`
	return PG.QStrStrMap( query )
}