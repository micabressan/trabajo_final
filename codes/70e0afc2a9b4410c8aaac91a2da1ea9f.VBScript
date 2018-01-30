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
	
''''------------------------------------------ Section REQUIRES INTERACTION ---------------------------------------------''''
' Literals Used ThroughOut the VBScript
EARFILE_00 = "autoediweb_dev_815"
EARFILE_01 = "autoediweb_dev_816"

INPUT_FOLDER_00 = "C:\Users\s6653\Desktop\AutoEDI Ear Files\AutoEDIWeb\" & EARFILE_00 & " - Expanded"
OUTPUT_FILE_00 = "C:\Users\s6653\Desktop\AutoEDI Ear Files\AutoEDIWeb\" & EARFILE_00 & " - Flattened.txt"

INPUT_FOLDER_01 = "C:\Users\s6653\Desktop\AutoEDI Ear Files\AutoEDIWeb\" & EARFILE_01 & " - Expanded"
OUTPUT_FILE_01 = "C:\Users\s6653\Desktop\AutoEDI Ear Files\AutoEDIWeb\" & EARFILE_01 & " - Flattened.txt"
''''---------------------------------------------------------------------------------------------------------------------''''

''''------------------------------------------ Create Output Logfiles Section --------------------------------------------''''
If objFSO.FileExists(OUTPUT_FILE_00) Then
	Set objFile1 = objFSO1.OpenTextFile(OUTPUT_FILE_00, ForAppending)
Else
	Set objFile1 = objFSO1.CreateTextFile(OUTPUT_FILE_00, ForWriting, True)
End If

If objFSO2.FileExists(OUTPUT_FILE_01) Then
	Set objFile2 = objFSO3.OpenTextFile(OUTPUT_FILE_01, ForAppending)
Else
	Set objFile2 = objFSO3.CreateTextFile(OUTPUT_FILE_01, ForWriting, True)
End If

objFile1.Write("------------------------------------------------------------------------------------------------------" & vbCrLf)
objFile1.Write("----------------------------------- AutoEDI Ear File Flattened ---------------------------------------" & vbCrLf)
objFile1.Write("------------- " & INPUT_FOLDER_00 & " ------------" & vbCrLf)
objFile1.Write("------------------------------------------------------------------------------------------------------" & vbCrLf & vbCrLf)

objFile2.Write("------------------------------------------------------------------------------------------------------" & vbCrLf)
objFile2.Write("----------------------------------- AutoEDI Ear File Flattened ---------------------------------------" & vbCrLf)
objFile2.Write("------------- " & INPUT_FOLDER_01 & " ------------" & vbCrLf)
objFile2.Write("------------------------------------------------------------------------------------------------------" & vbCrLf & vbCrLf)

''''------------------------------------------ Function\Subroutine Section ----------------------------------------------''''
Sub CreateInputFolders()
	If objFS4.FolderExists(INPUT_FOLDER_00) Then
	Else
		Set objINPUT_FOLDER_00 = objFS4.CreateFolder(INPUT_FOLDER_00)
	End If

	If objFS5.FolderExists(INPUT_FOLDER_01) Then
	Else
		Set objINPUT_FOLDER_01 = objFS5.CreateFolder(INPUT_FOLDER_01)
	End If
End Sub

Sub CreateOutputFiles()
	If objFSO.FileExists(OUTPUT_FILE_00) Then
		Set objFile1 = objFSO1.OpenTextFile(OUTPUT_FILE_00, ForAppending)
	Else
		Set objFile1 = objFSO1.CreateTextFile(OUTPUT_FILE_00, ForWriting, True)
	End If

	If objFSO2.FileExists(OUTPUT_FILE_01) Then
		Set objFile2 = objFSO3.OpenTextFile(OUTPUT_FILE_01, ForAppending)
	Else
		Set objFile2 = objFSO3.CreateTextFile(OUTPUT_FILE_01, ForWriting, True)
	End If

	objFile1.Write("------------------------------------------------------------------------------------------------------" & vbCrLf)
	objFile1.Write("----------------------------------- AutoEDI Ear File Flattened ---------------------------------------" & vbCrLf)
	objFile1.Write("------------- " & INPUT_FOLDER_00 & " ------------" & vbCrLf)
	objFile1.Write("------------------------------------------------------------------------------------------------------" & vbCrLf & vbCrLf)

	objFile2.Write("------------------------------------------------------------------------------------------------------" & vbCrLf)
	objFile2.Write("----------------------------------- AutoEDI Ear File Flattened ---------------------------------------" & vbCrLf)
	objFile2.Write("------------- " & INPUT_FOLDER_01 & " ------------" & vbCrLf)
	objFile2.Write("------------------------------------------------------------------------------------------------------" & vbCrLf & vbCrLf)
End Sub

Sub CloseOutputFiles()
	' Close the Output Log FileS
	objFile1.close
	objFile2.close
End Sub

Sub RunEARExpander(earFileName, folderSwitch)
	''''------------------------------------ CommandLine Example for EarExpander --------------------------------------------''''
	''''EARExpander.bat -ear "C:\Users\T3297\Desktop\AutoEDI Ear Files\AutoEDIWeb\autoediweb_dev_817.ear" -operation expand -operationDir "C:\Users\T3297\Desktop\AutoEDI Ear Files\AutoEDIWeb\autoediweb_dev_817 - Expanded"
	''''---------------------------------------------------------------------------------------------------------------------''''
	If folderSwitch = "00" Then
		Set WshShell = CreateObject("WScript.Shell")
		
		WScript.Echo chr(34) & "EARExpander -ear C:\Users\s6653\Desktop\AutoEDIEarFiles\AutoEDI\" & earFileName & ".ear -operation expand -operationDir " & INPUT_FOLDER_00 & Chr(34)
		WshShell.Run chr(34) & "EARExpander -ear C:\Users\s6653\Desktop\AutoEDIEarFiles\AutoEDI\" & earFileName & ".ear -operation expand -operationDir " & INPUT_FOLDER_00 & Chr(34)
		
		Set WshShell = Nothing
	End If
	
	If folderSwitch = "01" Then
		Set WshShell = CreateObject("WScript.Shell")
		
		WshShell.Run chr(34) & "EARExpander -ear C:\Users\s6653\Desktop\AutoEDIEarFiles\AutoEDI\" & earFileName & ".ear -operation expand -operationDir " & INPUT_FOLDER_01 & Chr(34)
		
		Set WshShell = Nothing
	End If
End Sub

Sub RecurseFolders(sPath, funcName, fileSwitch)
	With objFSO_0.GetFolder(sPath)
		If .SubFolders.Count > 0 Then
			For Each folder in .SubFolders
				' Perform function's operation
				Execute funcName & " " & chr(34) & folder.Path & chr(34) & ", " & chr(34) & fileSwitch & chr(34)
				
				' Recurse to check for further subfolders
				RecurseFolders folder.Path, funcName, fileSwitch
			Next
		Else
		End If
	End With
End Sub

Sub RecordIt(folderPath, fileSwitch)
	If fileSwitch = "00" Then
		' Record the Folder Path Name to Log File
		objFile1.Write("- " & folderPath & vbCrLf)
		
		' go thru each file in the folder
		For Each file In objFSO_1.GetFolder(folderPath).Files
			' Record the File Name to Log File
			objFile1.Write("---- " & file.Name & vbCrLf)
		Next
		
		objFile1.Write(vbCrLf)
	End If
	
	If fileSwitch = "01" Then
		' Record the Folder Path Name to Log File
		objFile2.Write("- " & folderPath & vbCrLf)
		
		' go thru each file in the folder
		For Each file In objFSO_1.GetFolder(folderPath).Files
			' Record the File Name to Log File
			objFile2.Write("---- " & file.Name & vbCrLf)
		Next
		
		objFile2.Write(vbCrLf)
	End If
end sub
		
''''------------------------------------------ Main Section ----------------------------------------------------------''''	
' Call the CreateInputFolders Routine
CreateInputFolders

' Call the CreateOutputFiles Routine
'CreateOutputFiles

' Call the RunEARExpander routine with the First EAR File
'RunEARExpander EARFILE_00, "00"

' Call the RunEARExpander routine with the Second EAR File
'RunEARExpander EARFILE_01, "01"

' Call the RecurseFolders routine with name of function to be performed
' Takes one argument - in this case, the Path of the folder to be searched
RecurseFolders INPUT_FOLDER_00, "RecordIt", "00"

' Call the RecurseFolders routine with name of function to be performed
' Takes one argument - in this case, the Path of the folder to be searched
RecurseFolders INPUT_FOLDER_01, "RecordIt", "01"

' Echo the job is completed
WScript.Echo "Completed!"

' Call the CloseOutputFiles Routine
CloseOutputFiles