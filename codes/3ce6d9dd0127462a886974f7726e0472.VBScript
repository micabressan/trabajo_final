Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

''''------------------------------------------ Declarations Section -----------------------------------------------------''''
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set fileContentsArray = CreateObject("Scripting.Dictionary")

INPUT_FOLDER = "C:\Users\mjohnson\Desktop\Guilford Group\PROJECTS\2013\P0003410 - Classic AAPS to New AAPS Conversion Project - Phase II\REFERENCE_C Value\"
OUTPUT_FOLDER = "C:\Users\mjohnson\Desktop\Guilford Group\Windows Scripts\OUTPUT\"

fileName_ARG00 = Wscript.Arguments(0)
INPUT_FILE = fileName_ARG00 & ".csv"
OUTPUT_FILE = fileName_ARG00 & " Report.txt"

INPUT = INPUT_FOLDER & INPUT_FILE
OUTPUT = OUTPUT_FOLDER & OUTPUT_FILE

TRANSACTION_I_PRVS = " "
TP_I_PRVS = " "
MESSAGE_STATE_I_PRVS = " "
ERROR_C_PRVS = " "
TRANSACTION_TYPE_C_PRVS = " "
VIN_I_PRVS = " "
RAILCAR_C_PRVS = " "
RAMP_C_PRVS = " "
MESSAGE_D_PRVS = " "
XML_REC_X_PRVS = " "
CREATION_TS_PRVS = " "
CREATION_USER_I_PRVS = " "
LAST_UPDATED_TS_PRVS = " "
LAST_UPDATE_USER_I_PRVS = " "
EDIREF_I_PRVS = " "
MSGLEVEL_I_PRVS = " "
ACTION_C_PRVS = " "
OWNER_C_PRVS = " "
REFERENCE_C_PRVS = " "
REFERENCE1_PRVS = " "
REFERENCE2_PRVS = " "
				
TRANSACTION_I_CRRNT = " "
TP_I_CRRNT = " "
MESSAGE_STATE_I_CRRNT = " "
ERROR_C_CRRNT = " "
TRANSACTION_TYPE_C_CRRNT = " "
VIN_I_CRRNT = " "
RAILCAR_C_CRRNT = " "
RAMP_C_CRRNT = " "
MESSAGE_D_CRRNT = " "
XML_REC_X_CRRNT = " "
CREATION_TS_CRRNT = " "
CREATION_USER_I_CRRNT = " "
LAST_UPDATED_TS_CRRNT = " "
LAST_UPDATE_USER_I_CRRNT = " "
EDIREF_I_CRRNT = " "
MSGLEVEL_I_CRRNT = " "
ACTION_C_CRRNT = " "
OWNER_C_CRRNT = " "
REFERENCE_C_CRRNT = " "
REFERENCE1_CRRNT = " "
REFERENCE2_CRRNT = " "

i = 0
lineCount = 0
lineCounter = 0

ediRef_EQUALS_ReferenceC_ACCUM_GM = 0
ediRef_EQUALS_Reference1_ACCUM_GM = 0
ediRef_EQUALS_Reference2_ACCUM_GM = 0
ReferenceC_EQUALS_Reference1_ACCUM_GM = 0
ReferenceC_EQUALS_Reference2_ACCUM_GM = 0

ediRef_EQUALS_ReferenceC_ACCUM_CHRY = 0
ediRef_EQUALS_Reference1_ACCUM_CHRY = 0
ediRef_EQUALS_Reference2_ACCUM_CHRY = 0
ReferenceC_EQUALS_Reference1_ACCUM_CHRY = 0
ReferenceC_EQUALS_Reference2_ACCUM_CHRY = 0

ediRef_EQUALS_ReferenceC_ACCUM_FORD = 0
ediRef_EQUALS_Reference1_ACCUM_FORD = 0
ediRef_EQUALS_Reference2_ACCUM_FORD = 0
ReferenceC_EQUALS_Reference1_ACCUM_FORD = 0
ReferenceC_EQUALS_Reference2_ACCUM_FORD = 0

response_Total_GM = 0
response_Total_CHRY = 0
response_Total_FORD = 0

EDIREF_I_NON_ACCUM_GM = 0
REFERENCE_C_NON_ACCUM_GM = 0
REFERENCE1_C_NON_ACCUM_GM = 0
REFERENCE2_C_NON_ACCUM_GM = 0

EDIREF_I_NON_ACCUM_CHRY = 0
REFERENCE_C_NON_ACCUM_CHRY = 0
REFERENCE1_C_NON_ACCUM_CHRY = 0
REFERENCE2_C_NON_ACCUM_CHRY = 0

EDIREF_I_NON_ACCUM_FORD = 0
REFERENCE_C_NON_ACCUM_FORD = 0
REFERENCE1_C_NON_ACCUM_FORD = 0
REFERENCE2_C_NON_ACCUM_FORD = 0

EDIREF_I_TOTAL_ACCUM_GM = 0
EDIREF_I_TOTAL_ACCUM_CHRY = 0
EDIREF_I_TOTAL_ACCUM_FORD = 0
REFERENCE_C_TOTAL_ACCUM_GM = 0
REFERENCE_C_TOTAL_ACCUM_CHRY = 0
REFERENCE_C_TOTAL_ACCUM_FORD = 0
REFERENCE1_C_TOTAL_ACCUM_GM = 0
REFERENCE1_C_TOTAL_ACCUM_CHRY = 0
REFERENCE1_C_TOTAL_ACCUM_FORD = 0
REFERENCE2_C_TOTAL_ACCUM_GM = 0
REFERENCE2_C_TOTAL_ACCUM_CHRY = 0
REFERENCE2_C_TOTAL_ACCUM_FORD = 0
''''------------------------------------------ Create Output File Section --------------------------------------------''''	
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFSO1 = CreateObject("Scripting.FileSystemObject")

If objFSO.FileExists(OUTPUT) Then
	Set objFile1 = objFSO1.OpenTextFile(OUTPUT, ForAppending)
Else
	Set objFile1 = objFSO1.CreateTextFile(OUTPUT, ForWriting, True)
End If

''''------------------------------------------ Functions Section -----------------------------------------------------''''	
function createFileArray()
	Set objFSO2 = CreateObject("Scripting.FileSystemObject")
	Set objFSO3 = CreateObject("Scripting.FileSystemObject")
	Set objFile2 = objFSO2.GetFile(INPUT)
  
	If objFile2.Size > 0 Then
		objFile1.Write("----------------------------- Transaction Performance Report -----------------------------" & vbCrLf & vbCrLf)
		
	    Set objReadFile = objFSO3.OpenTextFile(INPUT, ForReading)
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
			TRANSACTION_I = arryLineTrimmed(0)
			TP_I = arryLineTrimmed(1)
			MESSAGE_STATE_I = arryLineTrimmed(2)
			ERROR_C = arryLineTrimmed(3)
			TRANSACTION_TYPE_C = arryLineTrimmed(4)
			VIN_I = arryLineTrimmed(5)
			RAILCAR_C = arryLineTrimmed(6)
			RAMP_C = arryLineTrimmed(7)
			MESSAGE_D = arryLineTrimmed(8)
			XML_REC_X = arryLineTrimmed(9)
			CREATION_TS  = arryLineTrimmed(10)
			CREATION_USER_I = arryLineTrimmed(11)
			LAST_UPDATED_TS = arryLineTrimmed(12)
			LAST_UPDATE_USER_I = arryLineTrimmed(13)
			EDIREF_I = arryLineTrimmed(14)
			MSGLEVEL_I = arryLineTrimmed(15)
			ACTION_C = arryLineTrimmed(16)
			OWNER_C = arryLineTrimmed(17)
			REFERENCE_C = arryLineTrimmed(18)
			
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
			TRANSACTION_I_CRRNT = arryLineTrimmed(0)
			TP_I_CRRNT = arryLineTrimmed(1)
			MESSAGE_STATE_I_CRRNT = arryLineTrimmed(2)
			ERROR_C_CRRNT = arryLineTrimmed(3)
			TRANSACTION_TYPE_C_CRRNT = arryLineTrimmed(4)
			VIN_I_CRRNT = arryLineTrimmed(5)
			RAILCAR_C_CRRNT = arryLineTrimmed(6)
			RAMP_C_CRRNT = arryLineTrimmed(7)
			MESSAGE_D_CRRNT = arryLineTrimmed(8)
			XML_REC_X_CRRNT = arryLineTrimmed(9)
			CREATION_TS_CRRNT  = arryLineTrimmed(10)
			CREATION_USER_I_CRRNT = arryLineTrimmed(11)
			LAST_UPDATED_TS_CRRNT = arryLineTrimmed(12)
			LAST_UPDATE_USER_I_CRRNT = arryLineTrimmed(13)
			
			EDIREF_I_CRRNT = arryLineTrimmed(14)
			EDIREF_I_CRRNT = Trim(EDIREF_I_CRRNT)
			
			MSGLEVEL_I_CRRNT = arryLineTrimmed(15)
			ACTION_C_CRRNT = arryLineTrimmed(16)
			OWNER_C_CRRNT = arryLineTrimmed(17)
			
			REFERENCE_C_CRRNT = arryLineTrimmed(18)
			REFERENCE_C_CRRNT = Trim(REFERENCE_C_CRRNT)
			
			''''-Retrieve Reference 1 from XML Message-''''
			arryXMLREC_1 = split(XML_REC_X_CRRNT, "<REFERENCE1>")
			everythingToTheLeft1_CRRNT = arryXMLREC_1(0)
			everythingToTheRight1_CRRNT = arryXMLREC_1(1)
			arryReference1 = split(everythingToTheRight1_CRRNT, "</REFERENCE1>")
			REFERENCE1_CRRNT = arryReference1(0)
			REFERENCE1_CRRNT = Trim(REFERENCE1_CRRNT)
			
			''''-Retrieve Reference 2 from XML Message-''''
			arryXMLREC_2 = split(XML_REC_X_CRRNT, "<REFERENCE2>")
			everythingToTheLeft2_CRRNT = arryXMLREC_2(0)
			everythingToTheRight2_CRRNT = arryXMLREC_2(1)
			arryReference2 = split(everythingToTheRight2_CRRNT, "</REFERENCE2>")
			REFERENCE2_CRRNT = arryReference2(0)
			REFERENCE2_CRRNT = Trim(REFERENCE2_CRRNT)
			
			''''-Performance Check via Date Retrieved-''''
			If (lineCount = 0) Then
			
				''''-ReInitialize Counters-''''
				lineCount = lineCount + 1
				
				ediRef_EQUALS_ReferenceC_ACCUM_GM = 0
				ediRef_EQUALS_Reference1_ACCUM_GM = 0
				ediRef_EQUALS_Reference2_ACCUM_GM = 0
				ReferenceC_EQUALS_Reference1_ACCUM_GM = 0
				ReferenceC_EQUALS_Reference2_ACCUM_GM = 0

				ediRef_EQUALS_ReferenceC_ACCUM_CHRY = 0
				ediRef_EQUALS_Reference1_ACCUM_CHRY = 0
				ediRef_EQUALS_Reference2_ACCUM_CHRY = 0
				ReferenceC_EQUALS_Reference1_ACCUM_CHRY = 0
				ReferenceC_EQUALS_Reference2_ACCUM_CHRY = 0

				ediRef_EQUALS_ReferenceC_ACCUM_FORD = 0
				ediRef_EQUALS_Reference1_ACCUM_FORD = 0
				ediRef_EQUALS_Reference2_ACCUM_FORD = 0
				ReferenceC_EQUALS_Reference1_ACCUM_FORD = 0
				ReferenceC_EQUALS_Reference2_ACCUM_FORD = 0

				response_Total_GM = 0
				response_Total_CHRY = 0
				response_Total_FORD = 0

				EDIREF_I_NON_ACCUM_GM = 0
				REFERENCE_C_NON_ACCUM_GM = 0
				REFERENCE1_C_NON_ACCUM_GM = 0
				REFERENCE2_C_NON_ACCUM_GM = 0

				EDIREF_I_NON_ACCUM_CHRY = 0
				REFERENCE_C_NON_ACCUM_CHRY = 0
				REFERENCE1_C_NON_ACCUM_CHRY = 0
				REFERENCE2_C_NON_ACCUM_CHRY = 0

				EDIREF_I_NON_ACCUM_FORD = 0
				REFERENCE_C_NON_ACCUM_FORD = 0
				REFERENCE1_C_NON_ACCUM_FORD = 0
				REFERENCE2_C_NON_ACCUM_FORD = 0

				EDIREF_I_TOTAL_ACCUM_GM = 0
				EDIREF_I_TOTAL_ACCUM_CHRY = 0
				EDIREF_I_TOTAL_ACCUM_FORD = 0
				
				REFERENCE_C_TOTAL_ACCUM_GM = 0
				REFERENCE_C_TOTAL_ACCUM_CHRY = 0
				REFERENCE_C_TOTAL_ACCUM_FORD = 0
				
				REFERENCE1_C_TOTAL_ACCUM_GM = 0
				REFERENCE1_C_TOTAL_ACCUM_CHRY = 0
				REFERENCE1_C_TOTAL_ACCUM_FORD = 0
				
				REFERENCE2_C_TOTAL_ACCUM_GM = 0
				REFERENCE2_C_TOTAL_ACCUM_CHRY = 0
				REFERENCE2_C_TOTAL_ACCUM_FORD = 0

				''''-Establish Previous to Current Values-''''
				TRANSACTION_I_PRVS = TRANSACTION_I_CRRNT
				TP_I_PRVS = TP_I_CRRNT
				MESSAGE_STATE_I_PRVS = MESSAGE_STATE_I_CRRNT
				ERROR_C_PRVS = ERROR_C_CRRNT
				TRANSACTION_TYPE_C_PRVS = TRANSACTION_TYPE_C_CRRNT
				VIN_I_PRVS = VIN_I_CRRNT
				RAILCAR_C_PRVS = RAILCAR_C_CRRNT
				RAMP_C_PRVS = RAMP_C_CRRNT
				MESSAGE_D_PRVS = MESSAGE_D_CRRNT
				XML_REC_X_PRVS = XML_REC_X_CRRNT
				CREATION_TS_PRVS  = CREATION_TS_CRRNT
				CREATION_USER_I_PRVS = CREATION_USER_I_CRRNT
				LAST_UPDATED_TS_PRVS = LAST_UPDATED_TS_CRRNT
				LAST_UPDATE_USER_I_PRVS = LAST_UPDATE_USER_I_CRRNT
				EDIREF_I_PRVS = EDIREF_I_CRRNT
				MSGLEVEL_I_PRVS = MSGLEVEL_I_CRRNT
				ACTION_C_PRVS = ACTION_C_CRRNT
				OWNER_C_PRVS = OWNER_C_CRRNT
				REFERENCE_C_PRVS = REFERENCE_C_CRRNT
				REFERENCE1_PRVS = REFERENCE1_CRRNT
				REFERENCE2_PRVS = REFERENCE2_CRRNT
				''''-Will require end of file processing-''''
			Else
				''''-If It is a New AAPs Trading Partner: RESPONSE Counts and Record Inserts MUST EXIST-''''
				If (TP_I_PRVS = "100090") Then
				''WScript.Echo("Trading Partner: " & TP_I_PRVS & " Owner: " & OWNER_C_PRVS & " Trans Type: " & TRANSACTION_TYPE_C_PRVS & " EdiRef: " & EDIREF_I_PRVS & " Ref_C: " & REFERENCE_C_PRVS & " Ref1: " & REFERENCE1_PRVS & " Ref2: " & REFERENCE2_PRVS & vbCrLf)
				
				''''-Is the manufacturer GM-''''
					If (OWNER_C_PRVS = "GM") Then
						If ((TRANSACTION_TYPE_C_PRVS = "RC_LOAD") OR (TRANSACTION_TYPE_C_PRVS = "INGATE")) Then
							response_Total_GM = response_Total_GM + 1
							''''--Test for Numeric Values if Not Count--''''
							If (IsNumeric(EDIREF_I_PRVS)) Then 
								EDIREF_I_PRVS = CDbl(EDIREF_I_PRVS) 
								
								EDIREF_I_TOTAL_ACCUM_GM = EDIREF_I_TOTAL_ACCUM_GM + 1
							Else
								EDIREF_I_NON_ACCUM_GM = EDIREF_I_NON_ACCUM_GM + 1								
							End If
							
							If (IsNumeric(REFERENCE_C_PRVS)) Then 
								REFERENCE_C_PRVS = CDbl(REFERENCE_C_PRVS) 
								
								REFERENCE_C_TOTAL_ACCUM_GM = REFERENCE_C_TOTAL_ACCUM_GM + 1	
							Else
								REFERENCE_C_NON_ACCUM_GM = REFERENCE_C_NON_ACCUM_GM + 1	
							End If
							
							If (IsNumeric(REFERENCE1_PRVS)) Then 
								REFERENCE1_PRVS = CDbl(REFERENCE1_PRVS) 
								
								REFERENCE1_C_TOTAL_ACCUM_GM = REFERENCE1_C_TOTAL_ACCUM_GM + 1
							Else
								REFERENCE1_C_NON_ACCUM_GM = REFERENCE1_C_NON_ACCUM_GM + 1								
							End If
							
							If (IsNumeric(REFERENCE2_PRVS)) Then 
								REFERENCE2_PRVS = CDbl(REFERENCE2_PRVS) 
																
								REFERENCE2_C_TOTAL_ACCUM_GM = REFERENCE2_C_TOTAL_ACCUM_GM + 1
							Else
								REFERENCE2_C_NON_ACCUM_GM = REFERENCE2_C_NON_ACCUM_GM + 1									
							End If
							
							''''--Compare Values and Count IF Equate--''''
							''objFile1.Write("GM       EdiRef: " & EDIREF_I_PRVS & " Ref_C: " & REFERENCE_C_PRVS & " Ref1: " & REFERENCE1_PRVS & " Ref2: " & REFERENCE2_PRVS & vbCrLf)

							If (EDIREF_I_PRVS = REFERENCE_C_PRVS) Then
								ediRef_EQUALS_ReferenceC_ACCUM_GM = ediRef_EQUALS_ReferenceC_ACCUM_GM + 1			
							End If

							If (EDIREF_I_PRVS = REFERENCE1_PRVS) Then
								ediRef_EQUALS_Reference1_ACCUM_GM = ediRef_EQUALS_Reference1_ACCUM_GM + 1			
							End If

							If (EDIREF_I_PRVS = REFERENCE2_PRVS) Then
								ediRef_EQUALS_Reference2_ACCUM_GM = ediRef_EQUALS_Reference2_ACCUM_GM + 1			
							End If		

							If (REFERENCE_C_PRVS = REFERENCE1_PRVS) Then
								ReferenceC_EQUALS_Reference1_ACCUM_GM = ReferenceC_EQUALS_Reference1_ACCUM_GM + 1			
							End If

							If (REFERENCE_C_PRVS = REFERENCE2_PRVS) Then
								ReferenceC_EQUALS_Reference2_ACCUM_GM = ReferenceC_EQUALS_Reference2_ACCUM_GM + 1			
							End If								
						End If
					End If
					
					''''-Is the manufacturer CHRYSLER-''''
					If (OWNER_C_PRVS = "CHRYSLER") Then
						If (TRANSACTION_TYPE_C_PRVS = "RC_LOAD") Then
							response_Total_CHRY = response_Total_CHRY + 1

							''''--Test for Numeric Values if Not Count--''''
							If (IsNumeric(EDIREF_I_PRVS)) Then 
								EDIREF_I_PRVS = CDbl(EDIREF_I_PRVS) 
								
								EDIREF_I_TOTAL_ACCUM_CHRY = EDIREF_I_TOTAL_ACCUM_CHRY + 1
							Else
								EDIREF_I_NON_ACCUM_CHRY = EDIREF_I_NON_ACCUM_CHRY + 1								
							End If
							
							If (IsNumeric(REFERENCE_C_PRVS)) Then 
								REFERENCE_C_PRVS = CDbl(REFERENCE_C_PRVS) 
								
								REFERENCE_C_TOTAL_ACCUM_CHRY = REFERENCE_C_TOTAL_ACCUM_CHRY + 1	
							Else
								REFERENCE_C_NON_ACCUM_CHRY = REFERENCE_C_NON_ACCUM_CHRY + 1	
							End If
							
							If (IsNumeric(REFERENCE1_PRVS)) Then 
								REFERENCE1_PRVS = CDbl(REFERENCE1_PRVS) 
								
								REFERENCE1_C_TOTAL_ACCUM_CHRY = REFERENCE1_C_TOTAL_ACCUM_CHRY + 1
							Else
								REFERENCE1_C_NON_ACCUM_CHRY = REFERENCE1_C_NON_ACCUM_CHRY + 1								
							End If
							
							If (IsNumeric(REFERENCE2_PRVS)) Then 
								REFERENCE2_PRVS = CDbl(REFERENCE2_PRVS) 
								
								REFERENCE2_C_TOTAL_ACCUM_CHRY = REFERENCE2_C_TOTAL_ACCUM_CHRY + 1
							Else
								REFERENCE2_C_NON_ACCUM_CHRY = REFERENCE2_C_NON_ACCUM_CHRY + 1									
							End If
							
							''''--Compare Values and Count IF Equate--''''
							''objFile1.Write("CHRYSLER EdiRef: " & EDIREF_I_PRVS & " Ref_C: " & REFERENCE_C_PRVS & " Ref1: " & REFERENCE1_PRVS & " Ref2: " & REFERENCE2_PRVS & vbCrLf)
							If (EDIREF_I_PRVS = REFERENCE_C_PRVS) Then
								ediRef_EQUALS_ReferenceC_ACCUM_CHRY = ediRef_EQUALS_ReferenceC_ACCUM_CHRY + 1			
							End If

							If (EDIREF_I_PRVS = REFERENCE1_PRVS) Then
								ediRef_EQUALS_Reference1_ACCUM_CHRY = ediRef_EQUALS_Reference1_ACCUM_CHRY + 1			
							End If

							If (EDIREF_I_PRVS = REFERENCE2_PRVS) Then
								ediRef_EQUALS_Reference2_ACCUM_CHRY = ediRef_EQUALS_Reference2_ACCUM_CHRY + 1			
							End If		

							If (REFERENCE_C_PRVS = REFERENCE1_PRVS) Then
								ReferenceC_EQUALS_Reference1_ACCUM_CHRY = ReferenceC_EQUALS_Reference1_ACCUM_CHRY + 1			
							End If

							If (REFERENCE_C_PRVS = REFERENCE2_PRVS) Then
								ReferenceC_EQUALS_Reference2_ACCUM_CHRY = ReferenceC_EQUALS_Reference2_ACCUM_CHRY + 1			
							End If					
						End If
					End If

					''''-Is the manufacturer FORD-''''
					If (OWNER_C_PRVS = "FORD") Then
						If (TRANSACTION_TYPE_C_PRVS = "RC_LOAD") Then
							response_Total_FORD = response_Total_FORD + 1

							''''--Test for Numeric Values if Not Count--''''
							If (IsNumeric(EDIREF_I_PRVS)) Then 
								EDIREF_I_PRVS = CDbl(EDIREF_I_PRVS) 
								
								EDIREF_I_TOTAL_ACCUM_FORD = EDIREF_I_TOTAL_ACCUM_FORD + 1
							Else
								EDIREF_I_NON_ACCUM_FORD = EDIREF_I_NON_ACCUM_FORD + 1								
							End If
							
							If (IsNumeric(REFERENCE_C_PRVS)) Then 
								REFERENCE_C_PRVS = CDbl(REFERENCE_C_PRVS) 
								
								REFERENCE_C_TOTAL_ACCUM_FORD = REFERENCE_C_TOTAL_ACCUM_FORD + 1	
							Else
								REFERENCE_C_NON_ACCUM_FORD = REFERENCE_C_NON_ACCUM_FORD + 1	
							End If
							
							If (IsNumeric(REFERENCE1_PRVS)) Then 
								REFERENCE1_PRVS = CDbl(REFERENCE1_PRVS) 
								
								REFERENCE1_C_TOTAL_ACCUM_FORD = REFERENCE1_C_TOTAL_ACCUM_FORD + 1
							Else
								REFERENCE1_C_NON_ACCUM_FORD = REFERENCE1_C_NON_ACCUM_FORD + 1								
							End If
							
							If (IsNumeric(REFERENCE2_PRVS)) Then 
								REFERENCE2_PRVS = CDbl(REFERENCE2_PRVS) 
								
								REFERENCE2_C_TOTAL_ACCUM_FORD = REFERENCE2_C_TOTAL_ACCUM_FORD + 1
							Else
								REFERENCE2_C_NON_ACCUM_FORD = REFERENCE2_C_NON_ACCUM_FORD + 1									
							End If
							
							''''--Compare Values and Count IF Equate--''''
							''objFile1.Write("FORD     EdiRef: " & EDIREF_I_PRVS & " Ref_C: " & REFERENCE_C_PRVS & " Ref1: " & REFERENCE1_PRVS & " Ref2: " & REFERENCE2_PRVS & vbCrLf)

							If (EDIREF_I_PRVS = REFERENCE_C_PRVS) Then
								ediRef_EQUALS_ReferenceC_ACCUM_FORD = ediRef_EQUALS_ReferenceC_ACCUM_FORD + 1			
							End If

							If (EDIREF_I_PRVS = REFERENCE1_PRVS) Then
								ediRef_EQUALS_Reference1_ACCUM_FORD = ediRef_EQUALS_Reference1_ACCUM_FORD + 1			
							End If

							If (EDIREF_I_PRVS = REFERENCE2_PRVS) Then
								ediRef_EQUALS_Reference2_ACCUM_FORD = ediRef_EQUALS_Reference2_ACCUM_FORD + 1			
							End If		

							If (REFERENCE_C_PRVS = REFERENCE1_PRVS) Then
								ReferenceC_EQUALS_Reference1_ACCUM_FORD = ReferenceC_EQUALS_Reference1_ACCUM_FORD + 1			
							End If

							If (REFERENCE_C_PRVS = REFERENCE2_PRVS) Then
								ReferenceC_EQUALS_Reference2_ACCUM_FORD = ReferenceC_EQUALS_Reference2_ACCUM_FORD + 1			
							End If					
						End If
					End If	

				End If
				
				''''-Establish Previous to Current Values-''''
				TRANSACTION_I_PRVS = TRANSACTION_I_CRRNT
				TP_I_PRVS = TP_I_CRRNT
				MESSAGE_STATE_I_PRVS = MESSAGE_STATE_I_CRRNT
				ERROR_C_PRVS = ERROR_C_CRRNT
				TRANSACTION_TYPE_C_PRVS = TRANSACTION_TYPE_C_CRRNT
				VIN_I_PRVS = VIN_I_CRRNT
				RAILCAR_C_PRVS = RAILCAR_C_CRRNT
				RAMP_C_PRVS = RAMP_C_CRRNT
				MESSAGE_D_PRVS = MESSAGE_D_CRRNT
				XML_REC_X_PRVS = XML_REC_X_CRRNT
				CREATION_TS_PRVS  = CREATION_TS_CRRNT
				CREATION_USER_I_PRVS = CREATION_USER_I_CRRNT
				LAST_UPDATED_TS_PRVS = LAST_UPDATED_TS_CRRNT
				LAST_UPDATE_USER_I_PRVS = LAST_UPDATE_USER_I_CRRNT
				EDIREF_I_PRVS = EDIREF_I_CRRNT
				MSGLEVEL_I_PRVS = MSGLEVEL_I_CRRNT
				ACTION_C_PRVS = ACTION_C_CRRNT
				OWNER_C_PRVS = OWNER_C_CRRNT
				REFERENCE_C_PRVS = REFERENCE_C_CRRNT
				REFERENCE1_PRVS = REFERENCE1_CRRNT
				REFERENCE2_PRVS = REFERENCE2_CRRNT
			End If
			
			''''-Will require end of file processing-''''
			lineCounter = lineCounter + 1
		Loop
		
		''objFile1.Write("----------------------------------------- GM -----------------------------------------" & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE_C:       Count: " & ediRef_EQUALS_ReferenceC_ACCUM_GM & " Percent: " & FormatPercent(ediRef_EQUALS_ReferenceC_ACCUM_GM/response_Total_GM) & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE1:        Count: " & ediRef_EQUALS_Reference1_ACCUM_GM & " Percent: " & FormatPercent(ediRef_EQUALS_Reference1_ACCUM_GM/response_Total_GM) & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE2:        Count: " & ediRef_EQUALS_Reference2_ACCUM_GM & " Percent: " & FormatPercent(ediRef_EQUALS_Reference2_ACCUM_GM/response_Total_GM) & vbCrLf)
		''objFile1.Write("---- REFERENCE_C => REFERENCE1:   Count: " & ReferenceC_EQUALS_Reference1_ACCUM_GM & " Percent: " & FormatPercent(ReferenceC_EQUALS_Reference1_ACCUM_GM/response_Total_GM) & vbCrLf)
		''objFile1.Write("---- REFERENCE_C => REFERENCE2:   Count: " & ReferenceC_EQUALS_Reference2_ACCUM_GM & " Percent: " & FormatPercent(ReferenceC_EQUALS_Reference2_ACCUM_GM/response_Total_GM) & vbCrLf & vbCrLf)
		
		''objFile1.Write("---------------------------------------- FORD ----------------------------------------" & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE_C:       Count: " & ediRef_EQUALS_ReferenceC_ACCUM_FORD & " Percent: " & FormatPercent(ediRef_EQUALS_ReferenceC_ACCUM_FORD/response_Total_FORD) & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE1:        Count: " & ediRef_EQUALS_Reference1_ACCUM_FORD & " Percent: " & FormatPercent(ediRef_EQUALS_Reference1_ACCUM_FORD/response_Total_FORD) & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE2:        Count: " & ediRef_EQUALS_Reference2_ACCUM_FORD & " Percent: " & FormatPercent(ediRef_EQUALS_Reference2_ACCUM_FORD/response_Total_FORD) & vbCrLf)
		''objFile1.Write("---- REFERENCE_C => REFERENCE1:   Count: " & ReferenceC_EQUALS_Reference1_ACCUM_FORD & " Percent: " & FormatPercent(ReferenceC_EQUALS_Reference1_ACCUM_FORD/response_Total_FORD) & vbCrLf)
		''objFile1.Write("---- REFERENCE_C => REFERENCE2:   Count: " & ReferenceC_EQUALS_Reference2_ACCUM_FORD & " Percent: " & FormatPercent(ReferenceC_EQUALS_Reference2_ACCUM_FORD/response_Total_FORD) & vbCrLf & vbCrLf)
		
		''objFile1.Write("-------------------------------------- CHRYSLER --------------------------------------" & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE_C:       Count: " & ediRef_EQUALS_ReferenceC_ACCUM_CHRY & " Percent: " & FormatPercent(ediRef_EQUALS_ReferenceC_ACCUM_CHRY/response_Total_CHRY) & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE1:        Count: " & ediRef_EQUALS_Reference1_ACCUM_CHRY & " Percent: " & FormatPercent(ediRef_EQUALS_Reference1_ACCUM_CHRY/response_Total_CHRY) & vbCrLf)
		''objFile1.Write("---- EDIREF => REFERENCE2:        Count: " & ediRef_EQUALS_Reference2_ACCUM_CHRY & " Percent: " & FormatPercent(ediRef_EQUALS_Reference2_ACCUM_CHRY/response_Total_CHRY) & vbCrLf)
		''objFile1.Write("---- REFERENCE_C => REFERENCE1:   Count: " & ReferenceC_EQUALS_Reference1_ACCUM_CHRY & " Percent: " & FormatPercent(ReferenceC_EQUALS_Reference1_ACCUM_CHRY/response_Total_CHRY) & vbCrLf)
		''objFile1.Write("---- REFERENCE_C => REFERENCE2:   Count: " & ReferenceC_EQUALS_Reference2_ACCUM_CHRY & " Percent: " & FormatPercent(ReferenceC_EQUALS_Reference2_ACCUM_CHRY/response_Total_CHRY) & vbCrLf & vbCrLf)
		
		objFile1.Write(vbCrLf)
		objFile1.Write("----------------------------------------- GM -----------------------------------------" & vbCrLf)
		objFile1.Write("---- Total Response:                Count: " & response_Total_GM & vbCrLf)
		objFile1.Write("---- Total EDIREF_I Numeric:        Count: " & EDIREF_I_TOTAL_ACCUM_GM & vbCrLf)
		objFile1.Write("---- Total REFERENCE_c Numeric:     Count: " & REFERENCE_C_TOTAL_ACCUM_GM & vbCrLf)
		objFile1.Write("---- Total REFERENCE1 Numeric:      Count: " & REFERENCE1_C_TOTAL_ACCUM_GM & vbCrLf)
		objFile1.Write("---- Total REFERENCE2 Numeric:      Count: " & REFERENCE2_C_TOTAL_ACCUM_GM & vbCrLf)
		objFile1.Write("--------------------------------------------------------------------------------------" & vbCrLf)
		objFile1.Write("---- Total EDIREF NonNumeric:       Count: " & EDIREF_I_NON_ACCUM_GM & vbCrLf)
		objFile1.Write("---- Total REFERENCE_c NonNumeric:  Count: " & REFERENCE_C_NON_ACCUM_GM & vbCrLf)
		objFile1.Write("---- Total REFERENCE1 NonNumeric:   Count: " & REFERENCE1_C_NON_ACCUM_GM & vbCrLf)
		objFile1.Write("---- Total REFERENCE2 NonNumeric:   Count: " & REFERENCE2_C_NON_ACCUM_GM & vbCrLf)
		objFile1.Write("--------------------------------------------------------------------------------------" & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE_C:         Count: " & ediRef_EQUALS_ReferenceC_ACCUM_GM & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE1:          Count: " & ediRef_EQUALS_Reference1_ACCUM_GM & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE2:          Count: " & ediRef_EQUALS_Reference2_ACCUM_GM & vbCrLf)
		objFile1.Write("---- REFERENCE_C => REFERENCE1:     Count: " & ReferenceC_EQUALS_Reference1_ACCUM_GM & vbCrLf)
		objFile1.Write("---- REFERENCE_C => REFERENCE2:     Count: " & ReferenceC_EQUALS_Reference2_ACCUM_GM & vbCrLf & vbCrLf & vbCrLf)
		
		objFile1.Write("---------------------------------------- FORD ----------------------------------------" & vbCrLf)
		objFile1.Write("---- Total Response:                Count: " & response_Total_FORD & vbCrLf)
		objFile1.Write("---- Total EDIREF_I Numeric:        Count: " & EDIREF_I_TOTAL_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- Total REFERENCE_c Numeric:     Count: " & REFERENCE_C_TOTAL_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- Total REFERENCE1 Numeric:      Count: " & REFERENCE1_C_TOTAL_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- Total REFERENCE2 Numeric:      Count: " & REFERENCE2_C_TOTAL_ACCUM_FORD & vbCrLf)
		objFile1.Write("--------------------------------------------------------------------------------------" & vbCrLf)
		objFile1.Write("---- Total EDIREF NonNumeric:       Count: " & EDIREF_I_NON_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- Total REFERENCE_c NonNumeric:  Count: " & REFERENCE_C_NON_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- Total REFERENCE1 NonNumeric:   Count: " & REFERENCE1_C_NON_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- Total REFERENCE2 NonNumeric:   Count: " & REFERENCE2_C_NON_ACCUM_FORD & vbCrLf)
		objFile1.Write("--------------------------------------------------------------------------------------" & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE_C:         Count: " & ediRef_EQUALS_ReferenceC_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE1:          Count: " & ediRef_EQUALS_Reference1_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE2:          Count: " & ediRef_EQUALS_Reference2_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- REFERENCE_C => REFERENCE1:     Count: " & ReferenceC_EQUALS_Reference1_ACCUM_FORD & vbCrLf)
		objFile1.Write("---- REFERENCE_C => REFERENCE2:     Count: " & ReferenceC_EQUALS_Reference2_ACCUM_FORD & vbCrLf & vbCrLf & vbCrLf)
		
		objFile1.Write("-------------------------------------- CHRYSLER --------------------------------------" & vbCrLf)
		objFile1.Write("---- Total Response:                Count: " & response_Total_CHRY & vbCrLf)
		objFile1.Write("---- Total EDIREF_I Numeric:        Count: " & EDIREF_I_TOTAL_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- Total REFERENCE_c Numeric:     Count: " & REFERENCE_C_TOTAL_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- Total REFERENCE1 Numeric:      Count: " & REFERENCE1_C_TOTAL_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- Total REFERENCE2 Numeric:      Count: " & REFERENCE2_C_TOTAL_ACCUM_CHRY & vbCrLf)
		objFile1.Write("--------------------------------------------------------------------------------------" & vbCrLf)
		objFile1.Write("---- Total EDIREF NonNumeric:       Count: " & EDIREF_I_NON_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- Total REFERENCE_c NonNumeric:  Count: " & REFERENCE_C_NON_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- Total REFERENCE1 NonNumeric:   Count: " & REFERENCE1_C_NON_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- Total REFERENCE2 NonNumeric:   Count: " & REFERENCE2_C_NON_ACCUM_CHRY & vbCrLf)
		objFile1.Write("--------------------------------------------------------------------------------------" & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE_C:         Count: " & ediRef_EQUALS_ReferenceC_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE1:          Count: " & ediRef_EQUALS_Reference1_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- EDIREF => REFERENCE2:          Count: " & ediRef_EQUALS_Reference2_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- REFERENCE_C => REFERENCE1:     Count: " & ReferenceC_EQUALS_Reference1_ACCUM_CHRY & vbCrLf)
		objFile1.Write("---- REFERENCE_C => REFERENCE2:     Count: " & ReferenceC_EQUALS_Reference2_ACCUM_CHRY & vbCrLf & vbCrLf & vbCrLf)
		
	Else
		WScript.Echo("------------------- Input File Array Validation Failed ----------------" & vbCrLf)
	End If
Else
    WScript.Echo("------------------- Create File Array Failed ---------------------------" & vbCrLf)
End If

WScript.Echo("Program has Successfully completed.  Well Done my good man, Well Done in deed!!!")
objFile1.Close
