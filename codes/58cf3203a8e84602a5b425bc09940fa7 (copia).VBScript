Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

Set objFSO =  CreateObject("Scripting.FileSystemObject")
Set objFSO1 = CreateObject("Scripting.FileSystemObject")
Set objFSO2 = CreateObject("Scripting.FileSystemObject")

Set objTextFile = objFSO1.OpenTextFile("C:\Documents and Settings\mjohnson\Desktop\Guilford Group\Windows Scripts\INPUT\VM_inbound.txt", ForReading)

j = 0
Do While objTextFile.AtEndOfStream <> True
	line = objtextFile.Readline
	
	lineArray = split(line, "<?xml version=")
	For i = 1 to UBound( lineArray )
		indexValue = lineArray(i)
		trimmedIndexValue = Trim(indexValue)
		
		Wscript.Echo trimmedIndexValue & vbCrLf & vbCrLf
		
		If inStr(trimmedIndexValue, """""") Then
			replaceLine = Replace(trimmedIndexValue, """""", """")
		End If
		
		replaceLine = "<?xml version=" & replaceLine
		
		''Wscript.Echo replaceLine & vbCrLf
		
		''Set objectFile = objFSO.CreateTextFile("C:\Documents and Settings\mjohnson\Desktop\Guilford Group\Windows Scripts\OUTPUT\Row_" & j & ".xml")
		Set outputFile = objFSO2.OpenTextFile("C:\Documents and Settings\mjohnson\Desktop\Guilford Group\Windows Scripts\OUTPUT\Row_" & j & ".xml", ForAppending, TRUE)
		outputFile.Write replaceLine
	
		outputFile.Close
				
		j = j + 1
    Next 
Loop

Function removeEndOfLine(line) 
  Dim temp 
  
  lineArray = split(line, vbCrLf)

  For i = 0 to UBound( lineArray )
    temp = temp & lineArray(i) 
  Next 
  
  Wscript.Echo temp & vbCrLf
  getNewFileName = temp 
End Function 