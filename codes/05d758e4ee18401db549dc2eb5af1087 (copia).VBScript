Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

''''------------------------------------------ Declarations Section -----------------------------------------------------''''
'''' System FileObjects To Recursively Traverse System Folders
Set objFSO_0 = CreateObject("Scripting.FileSystemObject")
Set objFSO_1 = CreateObject("Scripting.FileSystemObject")

'''' System FolderObjects To Create Flattened Files
Set objFS4 = CreateObject("Scripting.FileSystemObject")
Set objFS5 = CreateObject("Scripting.FileSystemObject")

'''' System FileObjects To Create Flattened Files
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFSO1 = CreateObject("Scripting.FileSystemObject")
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objFSO3 = CreateObject("Scripting.FileSystemObject")
Set objFSO4 = CreateObject("Scripting.FileSystemObject")
Set objFSO5 = CreateObject("Scripting.FileSystemObject")

Set fileContentsArray1 = CreateObject("Scripting.Dictionary")
Set fileContentsArray2 = CreateObject("Scripting.Dictionary")

''''------------------------------------------ Section REQUIRES INTERACTION ---------------------------------------------''''
' Literals Used ThroughOut the VBScript
i = 0
j = 0
lineCounter_File1 = 0
lineCounter_File2 = 0

INPUT_FOLDER_00 = "C:\Users\mjohnson\Desktop\Guilford Group\DEVELOPMENT RESOURCES_CONFIGURATIONS\Windows Scripts\INPUT\VINInput.txt"
INPUT_FOLDER_01 = "C:\Users\mjohnson\Desktop\Guilford Group\DEVELOPMENT RESOURCES_CONFIGURATIONS\Windows Scripts\INPUT\660Transactions.txt"
OUTPUT_FILE_00 = "C:\Users\mjohnson\Desktop\Guilford Group\DEVELOPMENT RESOURCES_CONFIGURATIONS\Windows Scripts\OUTPUT\660Validation.txt"
''''---------------------------------------------------------------------------------------------------------------------''''

''''------------------------------------------ Create Output Logfiles Section --------------------------------------------''''
If objFSO.FileExists(OUTPUT_FILE_00) Then
	Set objFile1 = objFSO1.OpenTextFile(OUTPUT_FILE_00, ForAppending)
Else
	Set objFile1 = objFSO1.CreateTextFile(OUTPUT_FILE_00, ForWriting, True)
End If

objFile1.Write("------------------- Chrysler 660 Message Transaction Validation Report -------------------" & vbCrLf)
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objFile2 = objFSO2.GetFile(INPUT_FOLDER_00)
Set objFile3 = objFSO2.GetFile(INPUT_FOLDER_01)

''''-Load First Input File into an array-''''
If objFile2.Size > 0 Then
    Set objReadFile1 = objFSO3.OpenTextFile(INPUT_FOLDER_00, ForReading)
	
	''''-Read Text File into an Array-''''
	Do Until objReadFile1.AtEndOfStream
		strNextLine1 = objReadFile1.Readline
		If strNextLine1 <> "" Then
			fileContentsArray1.Add i, strNextLine1
		End If
		i = i + 1
	Loop
	objReadFile1.Close
Else
    objFile1.Write("-- First Input File Is Empty!!!! --")
End If

''''-Load Second Input File into an array-''''
If objFile3.Size > 0 Then
    Set objReadFile2 = objFSO4.OpenTextFile(INPUT_FOLDER_01, ForReading)
	
	''''-Read Text File into an Array-''''
	Do Until objReadFile2.AtEndOfStream
		strNextLine2 = objReadFile2.Readline
		If strNextLine2 <> "" Then
			fileContentsArray2.Add j, strNextLine2
		End If
		j = j + 1
	Loop
	objReadFile2.Close
Else
    objFile1.Write("-- Second Input File Is Empty!!!! --")
End If


''''-Loop through the first array and find all occurences within in the second array-''''
''''-Once Found write them to the output file-''''
Do Until lineCounter_File1 = i
	line1 = fileContentsArray1(lineCounter_File1)
	line1_Trimmed = Trim(line1)
	
	''''-Reset Second File Line Counter-''''
	lineCounter_File2 = 0
	
	objFile1.Write("--------------------------- VIN: " &  line1_Trimmed & " ---------------------------" & vbCrLf)
	
	Do Until lineCounter_File2 = j
		line2 = fileContentsArray2(lineCounter_File2)
		line2_Trimmed = Trim(line2)

		foundString = Instr(line2_Trimmed, line1_Trimmed)
		If Instr(line2_Trimmed, line1_Trimmed) Then
		    Wscript.Echo line2_Trimmed
			objFile1.Write(line2_Trimmed & VbCrLf)
		End If
		
		''''-Retrieve Record Line Information-''''
		''''-Will require end of file processing-''''
		lineCounter_File2 = lineCounter_File2 + 1
	Loop
	
	objFile1.Write("------------------------------------------------------------------------------------------" & vbCrLf)
	
	''''-Retrieve Record Line Information-''''
	''''-Will require end of file processing-''''
	lineCounter_File1 = lineCounter_File1 + 1
Loop

objFile1.Close
