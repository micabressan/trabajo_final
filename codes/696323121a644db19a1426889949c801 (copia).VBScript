Const ForReading = 1
Const ForWriting = 2

Set objFSO1 = CreateObject("Scripting.FileSystemObject") 
Set objFSO2 = CreateObject("Scripting.FileSystemObject")

srcFolder = "C:\Documents and Settings\mjohnson\Desktop\Guilford Group\VINTELLIGENT UPGRADE\VINTELLIGENT UPGRADE SCRIPTS\RESULTS\UAT Implementation Script_Step 1 - 20121015\Logs" 
Set outputFile = objFSO2.OpenTextFile("C:\Documents and Settings\mjohnson\Desktop\Guilford Group\Windows Scripts\OUTPUT\VintellUpgradeERRORS.txt", ForWriting, TRUE)

If objFSO1.FolderExists(srcFolder) Then 
	For Each file In objFSO1.GetFolder(srcFolder).Files
		fullFilePath = objFSO1.BuildPath(srcFolder,getNewFileName(file))
		'Wscript.Echo fullFilePath'
		
		outputFile.Write vbcrlf & "LogFile: " & getNewFileName(file) & vbcrlf
		
		Set objTextFile = objFSO1.OpenTextFile(fullFilePath, ForReading)
		Do While objTextFile.AtEndOfStream <> True
			line = objtextFile.Readline
			If inStr(line, "error") Then
				outputFile.Write "ERROR: " & line & vbcrlf
			Else
				If inStr(line, "ERROR") Then
					outputFile.Write "ERROR: " & line & vbcrlf
				Else
					If inStr(line, "constraint") Then
						outputFile.Write "ERROR: " & line & vbcrlf
					Else
						If inStr(line, "CONSTRAINT") Then
							outputFile.Write "ERROR: " & line & vbcrlf
						Else
							If inStr(line, "ORA-") Then
								outputFile.Write "ERROR: " & line & vbcrlf
							Else
							
							End If
						End If
					End If
				End If
			End If
		Loop

		objTextFile.Close
	Next 
Else 
	WScript.Echo "The specified folder: " & srcFolder & " does not exist." 
	WScript.Quit 
End If 

outputFile.Close 

Function getNewFileName(src) 
  Dim temp 
  temp = objFSO1.GetBaseName(src) & "." & objFSO1.GetExtensionName(src) 
  getNewFileName = temp 
End Function 



