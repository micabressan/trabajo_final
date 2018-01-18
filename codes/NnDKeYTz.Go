values := M.SX{
		`title`:            ctx.Title,
		`use_time_blocks`:  fHandler.UseTimeBlocks(ctx, sem_id),
		`lecturers`:        jUsers.Lecturer_Combobox(),
		`assistants`:		jUsers.StudentIsAssistant_Combobox(),
		`subjects`:         model.Subject_Combobox(),
		`sem_code`:         sem_code,
		`sem_id`:           sem_id,
		`subject_coord`:    jTags.Unit_SubjectCoord_Combobox(),
		`is_baa`:           page[`academic_adm`],
		`majors`:           jTags.Unit_Majors_Combobox_ByMajors(major_ids),
	}