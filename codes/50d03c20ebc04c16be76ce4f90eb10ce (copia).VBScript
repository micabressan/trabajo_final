Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

''''------------------------------------------ Declarations Section -----------------------------------------------------''''
'''' System FileObjects To Recursively Traverse System Folders
Set objFSO_0 = CreateObject("Scripting.FileSystemObject")
Set objFSO_1 = CreateObject("Scripting.FileSystemObject")

'''' System FileObjects To Create Flattened Files
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFSO2 = CreateObject("Scripting.FileSystemObject")
Set objFSO3 = CreateObject("Scripting.FileSystemObject")
	
''''------------------------------------------ Section REQUIRES INTERACTION ---------------------------------------------''''
' Literals Used ThroughOut the VBScript
FILE_EXTENSION_TYPE_00 = "keep"
FILE_EXTENSION_TYPE_01 = "contrib"

INPUT_FOLDER_00 = "C:\CCROOT\T3297_au_P0003410_dev\autoedi\projects"

INPUT_FOLDER_01 = "C:\Users\T3297\Desktop\VBScripts"
OUTPUT_FILE_01 = "C:\Users\T3297\Desktop\VBScripts\FileCleanUp-Log.txt"
''''---------------------------------------------------------------------------------------------------------------------''''

''''------------------------------------------ Create Output Logfiles Section --------------------------------------------''''
If objFSO2.FileExists(OUTPUT_FILE_01) Then
	Set objFile2 = objFSO3.OpenTextFile(OUTPUT_FILE_01, ForAppending)
Else
	Set objFile2 = objFSO3.CreateTextFile(OUTPUT_FILE_01, ForWriting, True)
End If

objFile2.Write("------------------------------------------------------------------------------------------------------" & vbCrLf)
objFile2.Write("--------------------------------------- FileCleanUp - Log --------------------------------------------" & vbCrLf)
objFile2.Write("----------------------- " & INPUT_FOLDER_00 & " -----------------------------" & vbCrLf)
objFile2.Write("------------------------------------------------------------------------------------------------------" & vbCrLf & vbCrLf)

''''------------------------------------------ Function\Subroutine Section ----------------------------------------------''''
Sub CloseOutputFiles()
	' Close the Output Log FileS
	objFile2.close
End Sub

Sub RecurseFolders(sPath, funcName)
	With objFSO_0.GetFolder(sPath)
		If .SubFolders.Count > 0 Then
			For Each folder in .SubFolders
				' Perform function's operation
				Execute funcName & " " & chr(34) & folder.Path & chr(34)
				
				' Recurse to check for further subfolders
				RecurseFolders folder.Path, funcName
			Next
		Else
		End If
	End With
End Sub

Sub CleanIt(folderPath)
	' go thru each file in the folder
	For Each file In objFSO_1.GetFolder(folderPath).Files
		' Retrieve the File Extension Name
		fileExtension = objFSO.GetExtensionName(file)
		
		' If File is equal to the File Extension slated for CleanUp
		If  fileExtension = FILE_EXTENSION_TYPE_00 Then
		  ' Record the File Name to Log File
		  objFile2.Write("---- " & file.Name & vbCrLf)
		  
		  objFSO.DeleteFile(file.Path) 
		End If
		
		' If File is equal to the File Extension slated for CleanUp
		If  fileExtension = FILE_EXTENSION_TYPE_01 Then
		  ' Record the File Name to Log File
		  objFile2.Write("---- " & file.Name & vbCrLf)
		  
		  objFSO.DeleteFile(file.Path) 
		End If
	Next
end sub
		
''''------------------------------------------ Main Section ----------------------------------------------------------''''	
' Call the RecurseFolders routine with name of function to be performed
RecurseFolders INPUT_FOLDER_00, "CleanIt"

' Echo the job is completed
WScript.Echo "File Clean Up Successfully Completed!!!"

' Call the CloseOutputFiles Routine
CloseOutputFiles