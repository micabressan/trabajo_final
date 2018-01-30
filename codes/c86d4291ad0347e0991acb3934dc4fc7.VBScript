Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFSO1 = CreateObject("Scripting.FileSystemObject")
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objFSO3 = CreateObject("Scripting.FileSystemObject")
Set fileContentsArray = CreateObject("Scripting.Dictionary")

INPUT_FILE = "C:\Users\mjohnson\Desktop\Guilford Group\Windows Scripts\INPUT\Chrysler_610_Messages.csv"
OUTPUT_FILE = "C:\Users\mjohnson\Desktop\Guilford Group\Windows Scripts\OUTPUT\Chrysler 610 Messages-Performance Report.txt"

i = 0
lineCount = 0
lineCounter = 0
creationMonth_PRVS = " "
creationDay_PRVS = " "
creationYear_PRVS = " "
creationMinutes_PRVS = " "
creationTimeStamp_HOURS_PRVS = " "
creationTimeStamp_MINS_PRVS = " "

creationMonth_CRRNT = " "
creationDay_CRRNT = " "
creationYear_CRRNT = " "
creationMinutes_CRRNT = " "
creationTimeStamp_HOURS_CRRNT = " "
creationTimeStamp_MINS_CRRNT = " "
		
If objFSO.FileExists(OUTPUT_FILE) Then
    Set objFile1 = objFSO1.OpenTextFile(OUTPUT_FILE, ForAppending)
Else
    Set objFile1 = objFSO1.CreateTextFile(OUTPUT_FILE, ForWriting, True)
End If

objFile1.Write("------------------- Chrysler 610 Message Transaction Performance Report -------------------" & vbCrLf)
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objFile2 = objFSO2.GetFile(INPUT_FILE)

If objFile2.Size > 0 Then
    Set objReadFile = objFSO3.OpenTextFile(INPUT_FILE, ForReading)
    ''fileContentsArray = objReadFile.ReadAll
	
	''''-Read Text File into an Array-''''
	Do Until objReadFile.AtEndOfStream
		strNextLine = objReadFile.Readline
		If strNextLine <> "" Then
			fileContentsArray.Add i, strNextLine
		End If
		i = i + 1
	Loop
	objReadFile.Close

	''lineCounter = LBound(fileContentsArray)
	
	Do Until lineCounter = i
		line = fileContentsArray(lineCounter)
		lineTrimmed = Trim(line)
		
		arryLineTrimmed = split(lineTrimmed, ",")
		
		''''-Retrieve Record Line Information-''''
		RESPONSE_I = arryLineTrimmed(0)
		TP_i = arryLineTrimmed(1)
		REFERENCE_C = arryLineTrimmed(2)
		EVENT_C = arryLineTrimmed(3)
		VIN_C = arryLineTrimmed(4)
		RAILCAR_C = arryLineTrimmed(5)
		VDC_RAMP_C = arryLineTrimmed(6)
		ACTION_C = arryLineTrimmed(7)
		OWNER_C = arryLineTrimmed(8)
		ERROR_C = arryLineTrimmed(9)
		CREATION_TS = arryLineTrimmed(10)
		CREATION_USER_I = arryLineTrimmed(11)
		LAST_UPDATED_TS = arryLineTrimmed(12)
		LAST_UPDATE_USER_I = arryLineTrimmed(13)

		''''-Retrieve Creation Date-''''
		arryCreationDate = split(CREATION_TS, "/")
		creationMonth_CRRNT = arryCreationDate(0)
		creationDay_CRRNT = arryCreationDate(1)
		creationYear_CRRNT = arryCreationDate(2)
		arryCreationYear = split(creationYear_CRRNT, " ")
		creationYear_CRRNT = arryCreationYear(0)
		
		''''-Retrieve Creation Hours, Minutes-''''
		creationTimeStamp_CRRNT = arryCreationYear(1)
		arryCreationDate = split(creationTimeStamp_CRRNT, ":")
		creationTimeStamp_HOURS_CRRNT = arryCreationDate(0)
		creationTimeStamp_MINS_CRRNT = arryCreationDate(1)
		
		''''-Performance Check via Date Retrieved-''''
		If (lineCount = 0) Then
			lineCount = lineCount + 1
			creationMonth_PRVS = creationMonth_CRRNT
			creationDay_PRVS = creationDay_CRRNT
			creationYear_PRVS = creationYear_CRRNT
			
			creationTimeStamp_HOURS_PRVS = creationTimeStamp_HOURS_CRRNT
			creationTimeStamp_MINS_PRVS = creationTimeStamp_MINS_CRRNT
			''''-Will require end of file processing-''''
		Else
			If (creationYear_PRVS = creationYear_CRRNT) Then
				If (creationMonth_PRVS = creationMonth_CRRNT) Then
					If (creationDay_PRVS = creationDay_CRRNT) Then
						If (creationTimeStamp_HOURS_PRVS = creationTimeStamp_HOURS_CRRNT) Then
							If (creationTimeStamp_MINS_PRVS = creationTimeStamp_MINS_CRRNT) Then
								lineCount = lineCount + 1
							Else
								objFile1.Write("-- Date: " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & " TimeStamp: " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & " Messages Processed: " & lineCount & vbCrLf)
								lineCount = 0
							End If
						Else
							objFile1.Write("-- Date: " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & " TimeStamp: " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & " Messages Processed: " & lineCount & vbCrLf)
							lineCount = 0
						End If					
					Else
						objFile1.Write("-- Date: " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & " TimeStamp: " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & " Messages Processed: " & lineCount & vbCrLf)
						lineCount = 0
					End If
				Else
					objFile1.Write("-- Date: " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & " TimeStamp: " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & " Messages Processed: " & lineCount & vbCrLf)
					lineCount = 0
				End If
			Else
				objFile1.Write("-- Date: " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & " TimeStamp: " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & " Messages Processed: " & lineCount & vbCrLf)
				lineCount = 0
			End If
		End If
		
		''''-Will require end of file processing-''''
		lineCounter = lineCounter + 1
	Loop
Else
    objFile1.Write("-- The Input File Is Empty!!!! --")
End If

objFile1.Close
