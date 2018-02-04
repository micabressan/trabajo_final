Option Explicit
Dim StrComputer, StrReportFile, BlnStatus, StrFolderName, StrFilePath
Dim ObjWMI, ColSubFolders, ArrFolderPath, StrNewPath, Counter, StrPath
Dim ObjFSO, WriteHandle, ColFiles, ObjFile, ObjFolder

StrComputer = Trim(WScript.Arguments(0)):	StrReportFile = Trim(WScript.Arguments(1))
BlnStatus = Trim(WScript.Arguments(2)):	StrFolderName = Trim(WScript.Arguments(3))
WScript.Echo
WScript.Echo "Working. Please wait ..."

On Error Resume Next

Set ObjFSO = CreateObject("Scripting.FileSystemObject")
StrFilePath = Trim(ObjFSO.GetFile(WScript.ScriptFullName).ParentFolder)
Set WriteHandle = ObjFSO.OpenTextFile(StrFilePath & "\Reports\" & StrReportFile, 8, True, 0)
Set ObjWMI = GetObject("WinMgmts:\\" & StrComputer & "\Root\CIMV2")
If Err.Number <> 0 Then
	WriteHandle.WriteLine:	WriteHandle.WriteLine
	WriteHandle.WriteLine "An Error Occurred For Computer: " & Ucase(StrComputer)
	WriteHandle.WriteLine "Error: " & Err.Number & ". " & Err.Description
	Err.Clear
	Set ObjWMI = Nothing
	WriteHandle.Close:	Set WriteHandle = Nothing
	Set ObjFSO = Nothing:	WScript.Quit
End If

WriteHandle.WriteLine:	WriteHandle.WriteLine
WriteHandle.WriteLine "======================================================================================================================"
WriteHandle.WriteLine "COMPUTER: " & Ucase(StrComputer) & ". All Files In Folder: " & StrFolderName
WriteHandle.WriteLine "======================================================================================================================"
WriteHandle.WriteLine "File Name" & vbTab & "File Type" & vbTab & "File Size" & vbTab & "Creation Date" & vbTab & "Last Modified Date" & vbTab & "8.3 File Name"
WriteHandle.WriteLine "-----------------------------------------------------------------------------------------------------------------------------------------------"

Set ColSubFolders = ObjWMI.ExecQuery("Associators of {Win32_Directory.Name='" & StrFolderName & "'} " & "Where AssocClass = Win32_Subdirectory " & "ResultRole = PartComponent")

Set ColFiles = ObjWMI.ExecQuery("ASSOCIATORS OF {Win32_Directory.Name='" & StrFolderName & "'} Where ResultClass = CIM_DataFile")

If ColFiles.Count > 0 Then
	For Each ObjFile In ColFiles
    		If ObjFile.FileSize = 0 Then
			WriteHandle.WriteLine ObjFile.FileName & "." & ObjFile.Extension & vbTab & ObjFile.FileType & vbTab & "00 Bytes" & vbTab & WMIDateStringToDate(ObjFile.CreationDate) & vbTab & WMIDateStringToDate(ObjFile.LastModified) & vbTab & ObjFile.EightDotThreeFileName
		Else
			Call GetProperValue(ObjFile.FileSize)
		End If
	Next
Else
	WriteHandle.WriteLine "This Folder Has No File Saved Here."
End If

If BlnStatus = 1 Then
	For Each ObjFolder In ColSubFolders
		GetSubFolders StrFolderName
	Next
End If

WriteHandle.Close:	Set WriteHandle = Nothing
Set ObjFSO = Nothing
Set ColFiles = Nothing:	Set ColSubFolders = Nothing:	Set ObjWMI = Nothing
StrComputer = vbNullString:	StrFolderName = vbNullString:	WScript.Quit

' ========================================================================================================

Private Sub GetSubFolders(StrFolderName)

	Dim ColSubFolders2, ObjFolder2

	Set ColSubFolders2 = ObjWMI.ExecQuery("Associators of {Win32_Directory.Name='" & StrFolderName & "'} " & "Where AssocClass = Win32_Subdirectory ResultRole = PartComponent")
	For Each ObjFolder2 In ColSubFolders2
        	StrFolderName = ObjFolder2.Name
		Set ColFiles = ObjWMI.ExecQuery("ASSOCIATORS OF {Win32_Directory.Name='" & StrFolderName & "'} Where ResultClass = CIM_DataFile")
		
		WriteHandle.WriteLine:	WriteHandle.WriteLine
		WriteHandle.WriteLine "======================================================================================================================"
		WriteHandle.WriteLine "All Files In SUB FOLDER: " & StrFolderName
		WriteHandle.WriteLine "======================================================================================================================"
		WriteHandle.WriteLine "File Name" & vbTab & "File Type" & vbTab & "File Size" & vbTab & "Creation Date" & vbTab & "Last Modified Date" & vbTab & "8.3 File Name"
		WriteHandle.WriteLine "-----------------------------------------------------------------------------------------------------------------------------------------------"
		
		If ColFiles.Count > 0 Then
			For Each ObjFile In ColFiles
        			If ObjFile.FileSize = 0 Then
					WriteHandle.WriteLine ObjFile.FileName & "." & ObjFile.Extension & vbTab & ObjFile.FileType & vbTab & "00 Bytes" & vbTab & WMIDateStringToDate(ObjFile.CreationDate) & vbTab & WMIDateStringToDate(ObjFile.LastModified) & vbTab & ObjFile.EightDotThreeFileName
            			Else
					Call GetProperValue(ObjFile.FileSize)
				End If
			Next
		Else
			WriteHandle.WriteLine "This Folder Has No File Saved Here."
		End If
		GetSubFolders StrFolderName
	Next
	
End Sub


Private Function WMIDateStringToDate(DtmInstallDate)
    WMIDateStringToDate = CDate(Mid(DtmInstallDate, 5, 2) & "/" & Mid(DtmInstallDate, 7, 2) & "/" & Left(DtmInstallDate, 4) _
            & " " & Mid (DtmInstallDate, 9, 2) & ":" & Mid(DtmInstallDate, 11, 2) & ":" & Mid(DtmInstallDate, 13, 2))
End Function


Private Sub GetProperValue(LngSize)

	Dim Suffix

    	Suffix = "Bytes"
    	If CLng(LngSize) >= 1024 Then
        	Suffix = "KB"
    	End If
    	If CLng(LngSize) >= 1048576 Then
        	Suffix = "MB"
    	End If
    	If CLng(LngSize) >= (1048576 * 1024) Then
        	Suffix = "GB"
    	End If
    	Select Case Suffix
        	Case "KB"
			LngSize = Round(CLng(LngSize) / 1024, 2)
        	Case "MB"
			LngSize = Round(Clng(LngSize) / 1048576, 2)
        	Case "GB"
			LngSize = Round(Clng(LngSize) / 1073741824, 2)
    	End Select
	WriteHandle.WriteLine ObjFile.FileName & "." & ObjFile.Extension & vbTab & ObjFile.FileType & vbTab & LngSize & " " & Suffix & vbTab & WMIDateStringToDate(ObjFile.CreationDate) & vbTab & WMIDateStringToDate(ObjFile.LastModified) & vbTab & ObjFile.EightDotThreeFileName
End Sub
