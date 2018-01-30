Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

''''------------------------------------------ Declarations Section -----------------------------------------------------''''
''''--Example of Required SQL to retrieve valid Input File--
''''SELECT MESSAGE_ID,CONTENT_TYPE,MESSAGE_SOURCE_ID,ERROR_CODE,ERROR_MESSAGE,INNER_MESSAGE,ERROR_STACK_TRACE,UPDATE_DATE,UPDATE_USER_ID,USER_DATA,USER_DATA_1,
''''       MESSAGE_TYPE_ID,MESSAGE_STATUS_ID,PROCESSING_COUNT,PROCESSING_TIME,COMMENTS,IS_DELETED,CREATE_DATE,CREATE_USER_ID,TRADING_PARTNER_ID,VERSION,PRIORITY
''''FROM VM_RAW_INBOUND_MESSAGE WHERE UPDATE_DATE between to_date('03-01-2013', 'mm-dd-yyyy') and to_date('03-29-2013', 'mm-dd-yyyy');
''''---------------------------------------------------------------------------------------------------------------------''''

Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set fileContentsArray = CreateObject("Scripting.Dictionary")

INPUT_FILE = "C:\Users\mjohnson\Desktop\Guilford Group\Windows Scripts\INPUT\20130403_RawInboundMessage.csv"
OUTPUT_FILE = "C:\Users\mjohnson\Desktop\Guilford Group\Windows Scripts\OUTPUT\20130403_Raw Inbound Messages-Performance Report.txt"
DATERANGE_FROM = "03/22/2013"
DATERANGE_TO = "04/03/2013"

i = 0
lineCount = 0
lineCounter = 0

avgProcessingTime_HOURS = 0
avgProcessingTime_MINS= 0
avgProcessingTime_SECS = 0

avgProcessingTime_HOURS_ACCUM = 0
avgProcessingTime_MINS_ACCUM= 0
avgProcessingTime_SECS_ACCUM = 0
		
creationMonth_PRVS = " "
creationDay_PRVS = " "
creationYear_PRVS = " "
creationMinutes_PRVS = " "
creationTimeStamp_HOURS_PRVS = " "
creationTimeStamp_MINS_PRVS = " "

processingTime_HOURS_PRVS = " "
processingTime_MINS_PRVS = " "
processingTime_SECS_PRVS = " "

creationMonth_CRRNT = " "
creationDay_CRRNT = " "
creationYear_CRRNT = " "
creationMinutes_CRRNT = " "
creationTimeStamp_HOURS_CRRNT = " "
creationTimeStamp_MINS_CRRNT = " "
		
processingTime_HOURS_CRRNT = " "
processingTime_MINS_CRRNT = " "
processingTime_SECS_CRRNT = " "

''''------------------------------------------ Create Output File Section --------------------------------------------''''	
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFSO1 = CreateObject("Scripting.FileSystemObject")

If objFSO.FileExists(OUTPUT_FILE) Then
	Set objFile1 = objFSO1.OpenTextFile(OUTPUT_FILE, ForAppending)
Else
	Set objFile1 = objFSO1.CreateTextFile(OUTPUT_FILE, ForWriting, True)
End If

''''------------------------------------------ Functions Section -----------------------------------------------------''''	
function createFileArray()
	Set objFSO2 = CreateObject("Scripting.FileSystemObject")
	Set objFSO3 = CreateObject("Scripting.FileSystemObject")
	Set objFile2 = objFSO2.GetFile(INPUT_FILE)
  
	If objFile2.Size > 0 Then
		objFile1.Write("------------------- Raw Inbound Message Transaction Performance Report -------------------" & vbCrLf)
		objFile1.Write("------------------- Date Range: " & DATERANGE_FROM & " to " & DATERANGE_TO & " ---------------------------------" & vbCrLf)

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
		
		createFileArray = 0
	Else
		objFile1.Write("------------------- The Input File Is Empty!!!! --------------------------------" & vbCrLf)
		createFileArray = 1
	End If
end function

function validateFileArray()
	arrayIndexValue = 0
	
	Do Until arrayIndexValue = i
		fileLine = fileContentsArray(arrayIndexValue)
		
		If fileLine <> "" Then
			fileLineTrimmed = Trim(fileLine)
		
			''WScript.Echo("------------------- Validating Array Index: " & arrayIndexValue & " -----------------------------" & vbCrLf)
			arryLineTrimmed = split(fileLineTrimmed, ",")
			
			validateFileArray = 1
			
			''''-Retrieve Record Line Information-''''
			MESSAGE_ID = arryLineTrimmed(0)
			CONTENT_TYPE = arryLineTrimmed(1)
			''''-The CONTENT Field should occur here????-''''
			MESSAGE_SOURCE_ID = arryLineTrimmed(2)
			ERROR_CODE = arryLineTrimmed(3)
			ERROR_MESSAGE = arryLineTrimmed(4)
			INNER_MESSAGE = arryLineTrimmed(5)
			ERROR_STACK_TRACE = arryLineTrimmed(6)
			UPDATE_DATE = arryLineTrimmed(7)
			UPDATE_USER_ID = arryLineTrimmed(8)
			USER_DATA = arryLineTrimmed(9)
			USER_DATA_1 = arryLineTrimmed(10)
			MESSAGE_TYPE_ID = arryLineTrimmed(11)
			MESSAGE_STATUS_ID = arryLineTrimmed(12)
			PROCESSING_COUNT = arryLineTrimmed(13)
			PROCESSING_TIME = arryLineTrimmed(14)
			COMMMENTS = arryLineTrimmed(15)
			IS_DELETED = arryLineTrimmed(16)
			CREATE_DATE = arryLineTrimmed(17)
			CREATE_USER_ID = arryLineTrimmed(18)
			TRADING_PARTNER_ID = arryLineTrimmed(19)
			VERSION = arryLineTrimmed(20)
			PRIORITY = arryLineTrimmed(21)
			
			validateFileArray = 0
		Else
			WScript.Echo("------------------- Array Value at Index: " & arrayIndexValue & " Is Empty----------------" & vbCrLf)
		End If
		
		arrayIndexValue = arrayIndexValue + 1
	Loop
end function

''''-------------------------------------------- Main Section -------------------------------------------------------''''
createRetVAl = createFileArray()

If(createRetVAl = 0) Then
	validateRetVal = validateFileArray()
	
	If(validateRetVal = 0) Then
		Do Until lineCounter = i
			line = fileContentsArray(lineCounter)
			lineTrimmed = Trim(line)
			
			arryLineTrimmed = split(lineTrimmed, ",")
			
			''''-Retrieve Record Line Information-''''
			MESSAGE_ID = arryLineTrimmed(0)
			CONTENT_TYPE = arryLineTrimmed(1)
			''''-The CONTENT Field should occur here????-''''
			MESSAGE_SOURCE_ID = arryLineTrimmed(2)
			ERROR_CODE = arryLineTrimmed(3)
			ERROR_MESSAGE = arryLineTrimmed(4)
			INNER_MESSAGE = arryLineTrimmed(5)
			ERROR_STACK_TRACE = arryLineTrimmed(6)
			UPDATE_DATE = arryLineTrimmed(7)
			UPDATE_USER_ID = arryLineTrimmed(8)
			USER_DATA = arryLineTrimmed(9)
			USER_DATA_1 = arryLineTrimmed(10)
			MESSAGE_TYPE_ID = arryLineTrimmed(11)
			MESSAGE_STATUS_ID = arryLineTrimmed(12)
			PROCESSING_COUNT = arryLineTrimmed(13)
			PROCESSING_TIME = arryLineTrimmed(14)
			COMMMENTS = arryLineTrimmed(15)
			IS_DELETED = arryLineTrimmed(16)
			CREATE_DATE = arryLineTrimmed(17)
			CREATE_USER_ID = arryLineTrimmed(18)
			TRADING_PARTNER_ID = arryLineTrimmed(19)
			VERSION = arryLineTrimmed(20)
			PRIORITY = arryLineTrimmed(21)
			
			''''-Retrieve Creation Date-''''
			arryCreationDate = split(CREATE_DATE, "/")
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
			
			''''-Retrieve Processing Time Hours, Minutes, Seconds-''''
			''''TimeStamp Format Example:  00 00:00:00.125000
			arryProcessingTime = split(PROCESSING_TIME, ":")
			processingTime_HOURS_CRRNT = arryProcessingTime(0)
			arryProcessingTime_HOURS = split(processingTime_HOURS_CRRNT, " ")
			processingTime_HOURS_CRRNT = arryProcessingTime_HOURS(1)
			
			processingTime_MINS_CRRNT = arryProcessingTime(1)
			processingTime_SECS_CRRNT = arryProcessingTime(2)
			
			''''-Performance Check via Date Retrieved-''''
			If (lineCount = 0) Then
				lineCount = lineCount + 1
				creationMonth_PRVS = creationMonth_CRRNT
				creationDay_PRVS = creationDay_CRRNT
				creationYear_PRVS = creationYear_CRRNT
				
				creationTimeStamp_HOURS_PRVS = creationTimeStamp_HOURS_CRRNT
				creationTimeStamp_MINS_PRVS = creationTimeStamp_MINS_CRRNT
				
				processingTime_HOURS_PRVS = processingTime_HOURS_CRRNT
				processingTime_MINS_PRVS = processingTime_MINS_CRRNT
				processingTime_SECS_PRVS = processingTime_SECS_CRRNT

				avgProcessingTime_HOURS_ACCUM = avgProcessingTime_HOURS_ACCUM + processingTime_HOURS_PRVS
				avgProcessingTime_MINS_ACCUM = avgProcessingTime_MINS_ACCUM + processingTime_MINS_PRVS
				avgProcessingTime_SECS_ACCUM = avgProcessingTime_SECS_ACCUM + processingTime_SECS_PRVS

				''''-Will require end of file processing-''''
			Else
				If (creationYear_PRVS = creationYear_CRRNT) Then
					If (creationMonth_PRVS = creationMonth_CRRNT) Then
						If (creationDay_PRVS = creationDay_CRRNT) Then
							If (creationTimeStamp_HOURS_PRVS = creationTimeStamp_HOURS_CRRNT) Then
								If (creationTimeStamp_MINS_PRVS = creationTimeStamp_MINS_CRRNT) Then
									lineCount = lineCount + 1
									
									avgProcessingTime_HOURS_ACCUM = avgProcessingTime_HOURS_ACCUM + processingTime_HOURS_CRRNT
									avgProcessingTime_MINS_ACCUM = avgProcessingTime_MINS_ACCUM + processingTime_MINS_CRRNT
									avgProcessingTime_SECS_ACCUM = avgProcessingTime_SECS_ACCUM + processingTime_SECS_CRRNT
									''WScript.Echo("-- Line: " & lineCounter & "   Date:   " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & " Accumulate Seconds: " & avgProcessingTime_SECS_ACCUM & " = " & avgProcessingTime_SECS_ACCUM & " + " & processingTime_SECS_CRRNT & " --" & vbCrLf)
								Else
									avgProcessingTime_HOURS = avgProcessingTime_HOURS_ACCUM / lineCount
									avgProcessingTime_MINS = avgProcessingTime_MINS_ACCUM / lineCount
									avgProcessingTime_SECS = avgProcessingTime_SECS_ACCUM / lineCount
									
									objFile1.Write("-- Date:   " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & "   TimeStamp:   " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & "   Messages Processed:   " & lineCount & "   Average Processing Time:   " & avgProcessingTime_HOURS & ":" & avgProcessingTime_MINS & ":" & avgProcessingTime_SECS & vbCrLf)
									
									lineCount = 0
									avgProcessingTime_HOURS = 0
									avgProcessingTime_MINS= 0
									avgProcessingTime_SECS = 0
									avgProcessingTime_HOURS_ACCUM = 0
									avgProcessingTime_MINS_ACCUM = 0
									avgProcessingTime_SECS_ACCUM = 0									
								End If
							Else
								objFile1.Write("-- Date:   " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & "   TimeStamp:   " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & "   Messages Processed:   " & lineCount & "   Average Processing Time:   " & avgProcessingTime_HOURS & ":" & avgProcessingTime_MINS & ":" & avgProcessingTime_SECS & vbCrLf)
								
								lineCount = 0
								avgProcessingTime_HOURS = 0
								avgProcessingTime_MINS= 0
								avgProcessingTime_SECS = 0
								avgProcessingTime_HOURS_ACCUM = 0
								avgProcessingTime_MINS_ACCUM = 0
								avgProcessingTime_SECS_ACCUM = 0	
							End If					
						Else
							objFile1.Write("-- Date:   " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & "   TimeStamp:   " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & "   Messages Processed:   " & lineCount & "   Average Processing Time:   " & avgProcessingTime_HOURS & ":" & avgProcessingTime_MINS & ":" & avgProcessingTime_SECS & vbCrLf)

							lineCount = 0
							avgProcessingTime_HOURS = 0
							avgProcessingTime_MINS= 0
							avgProcessingTime_SECS = 0
							avgProcessingTime_HOURS_ACCUM = 0
							avgProcessingTime_MINS_ACCUM = 0
							avgProcessingTime_SECS_ACCUM = 0	
						End If
					Else
						objFile1.Write("-- Date:   " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & "   TimeStamp:   " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & "   Messages Processed:   " & lineCount & "   Average Processing Time:   " & avgProcessingTime_HOURS & ":" & avgProcessingTime_MINS & ":" & avgProcessingTime_SECS & vbCrLf)
						
						lineCount = 0
						avgProcessingTime_HOURS = 0
						avgProcessingTime_MINS= 0
						avgProcessingTime_SECS = 0
						avgProcessingTime_HOURS_ACCUM = 0
						avgProcessingTime_MINS_ACCUM = 0
						avgProcessingTime_SECS_ACCUM = 0	
					End If
				Else
					objFile1.Write("-- Date:   " & creationMonth_PRVS & "/" & creationDay_PRVS & "/" & creationYear_PRVS & "   TimeStamp:   " & creationTimeStamp_HOURS_PRVS & ":" & creationTimeStamp_MINS_PRVS & "   Messages Processed:   " & lineCount & "   Average Processing Time:   " & avgProcessingTime_HOURS & ":" & avgProcessingTime_MINS & ":" & avgProcessingTime_SECS & vbCrLf)
					
					lineCount = 0
					avgProcessingTime_HOURS = 0
					avgProcessingTime_MINS= 0
					avgProcessingTime_SECS = 0
					avgProcessingTime_HOURS_ACCUM = 0
					avgProcessingTime_MINS_ACCUM = 0
					avgProcessingTime_SECS_ACCUM = 0
				End If
			End If
			
			''''-Will require end of file processing-''''
			lineCounter = lineCounter + 1
		Loop
	Else
		WScript.Echo("------------------- Input File Array Validation Failed ----------------" & vbCrLf)
	End If
Else
    WScript.Echo("------------------- Creat File Array Failed ---------------------------" & vbCrLf)
End If

objFile1.Close
