func TestBuildInternalTasks(t *testing.T) {
	taskFieldsToCheck := []string{
		"Schedule",
		"Regularity",
		"Trigger",
		"Type",
		"Parameters",
		"TaskLocation",
	}

	templateFieldsToCheck := []string{
		"Name",
		"Description",
		"OriginID",
	}

	checkFields := func(t *testing.T, list []string, val1, val2 interface{}) {
		for _, field := range taskFieldsToCheck {
			got := reflect.ValueOf(val1).Field(0).FieldByName(field)
			want := reflect.ValueOf(val2).Field(0).FieldByName(field)

			if got.Kind().String() == "int" && got.Int() != want.Int() {
				t.Fatalf("Mismatched %v value, got %v, want %v", field, got.Int(), want.Int())
				continue
			}

			if got.Type().String() == "gocql.UUID" &&
				got.Interface().(gocql.UUID) != want.Interface().(gocql.UUID) {
				t.Fatalf("Mismatched %s: got %v, want %v", field, got, want)
				continue
			}

			if got.String() != want.String() {
				t.Fatalf("Mismatched %s: got %v, want %v", field, got, want)
			}
		}
	}
	
	tests := []struct {
		name              string
		task              *models.TaskInput
		template          models.TemplateDetails
		partnerID         string
		initiatedBy       string
		wantInternalTasks []models.TaskInternal
		wantErr           bool
	}{
		{
			name: `good1`,
			task: &models.TaskInput{
				TaskCommonFields: modelMocks.DefaultTasks[1].TaskCommonFields,
				Targets:          []string{modelMocks.DefaultTasks[1].Target},
			},
			template:          modelMocks.DefaultTemplatesDetails[1],
			partnerID:         modelMocks.DefaultTasks[1].PartnerID,
			initiatedBy:       "me",
			wantInternalTasks: []models.TaskInternal{modelMocks.DefaultTasks[1]},
			wantErr:           false,
		},
		{
			name: `good2`,
			task: &models.TaskInput{
				TaskCommonFields: modelMocks.DefaultTasks[2].TaskCommonFields,
				Targets:          []string{modelMocks.DefaultTasks[2].Target},
			},
			template:          modelMocks.DefaultTemplatesDetails[2],
			partnerID:         modelMocks.DefaultTasks[2].PartnerID,
			initiatedBy:       "me",
			wantInternalTasks: []models.TaskInternal{modelMocks.DefaultTasks[2]},
			wantErr:           false,
		},
		{
			name: `bad`,
			task: &models.TaskInput{
				TaskCommonFields: models.TaskCommonFields{
					TaskLocation: "### INVALID LOCATION $$$",
				},
			},
			template:          models.TemplateDetails{},
			partnerID:         "",
			initiatedBy:       "",
			wantInternalTasks: []models.TaskInternal{},
			wantErr:           true,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			gotInternalTasks, err := buildInternalTasks(tt.task, tt.template, tt.partnerID, tt.initiatedBy)
			if (err != nil) != tt.wantErr {
				t.Errorf("buildInternalTasks() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			
			for _, gotTask := range gotInternalTasks {
				testInternalTask := models.TaskInternal{
					TaskCommonFields: models.TaskCommonFields{
						ID:               gocql.UUID{},
						Name:             tt.template.Name,
						Description:      tt.template.Description,
						Schedule:         tt.task.Schedule,
						CreatedAt:        time.Now().Truncate(time.Millisecond).UTC(),
						CreatedBy:        tt.initiatedBy,
						PartnerID:        tt.partnerID,
						OriginID:         tt.template.OriginID,
						State:            models.TaskStateActive,
						Regularity:       tt.task.Regularity,
						Trigger:          tt.task.Trigger,
						Type:             tt.task.Type,
						Parameters:       tt.task.Parameters,
						TaskLocation:     tt.task.TaskLocation,
					},
				}
				
				checkFields(t, taskFieldsToCheck, gotTask, testInternalTask)
				checkFields(t, templateFieldsToCheck, gotTask, testInternalTask)
			}
		})
	}
}