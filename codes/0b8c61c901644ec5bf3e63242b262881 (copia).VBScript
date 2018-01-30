Option Explicit

Dim StrFolder, ObjShell, ObjFolder, StrFile, StrReportFile
Dim ObjFSO, WriteHandle, StrFilePath

StrFolder = Trim(WScript.Arguments(0)):	StrReportFile = Trim(WScript.Arguments(1))
WScript.Echo
WScript.Echo "Working. Please wait ..."
Set ObjFSO = CreateObject("Scripting.FileSystemObject")
StrFilePath = Trim(ObjFSO.GetFile(WScript.ScriptFullName).ParentFolder)
Set WriteHandle = ObjFSO.OpenTextFile(StrFilePath & "\Reports\" & StrReportFile, 8, True, 0)
WriteHandle.WriteLine "List of All Files In PARENT FOLDER: " & StrFolder
WriteHandle.WriteLine "----------------------------------------------------------------------------------------------------------------------------"
WriteHandle.WriteLine "File Name" & vbTab & "File Size" & vbTab & "File Type" & vbTab & "Last Modified Date" & vbTab & "Date Created" & vbTab & "File Owner"
WriteHandle.WriteLine "----------------------------------------------------------------------------------------------------------------------------"
Call FetchInfo(StrFolder)
Call ShowSubFolders(ObjFSO.GetFolder(StrFolder))
StrFolder = vbNullString:	StrFilePath = vbNullString:	StrFile = vbNullString
Set ObjFolder = Nothing:	Set ObjShell = Nothing
WriteHandle.Close:	Set WriteHandle = Nothing
Set ObjFSO = Nothing:	WScript.Quit

Private Sub FetchInfo(StrFolder)
	Set ObjShell = CreateObject("Shell.Application")
	Set ObjFolder = ObjShell.Namespace(Strfolder)
	For Each StrFile In ObjFolder.Items
		WriteHandle.WriteLine ObjFolder.GetDetailsOf(StrFile, 0) & vbTab & ObjFolder.GetDetailsOf(StrFile, 1) & vbTab & ObjFolder.GetDetailsOf(StrFile, 2) & vbTab & ObjFolder.GetDetailsOf(StrFile, 4) & vbTab & ObjFolder.GetDetailsOf(StrFile, 3) & vbTab & ObjFolder.GetDetailsOf(StrFile, 10)
	Next
End Sub

Private Sub ShowSubFolders(Folder)
	Dim SubFolder	
	For Each SubFolder In Folder.SubFolders
		WriteHandle.WriteLine:	WriteHandle.WriteLine
		WriteHandle.WriteLine "List of All Files In SUB FOLDER: " & SubFolder.Path
		WriteHandle.WriteLine "----------------------------------------------------------------------------------------------------------------------------"
		WriteHandle.WriteLine "File Name" & vbTab & "File Size" & vbTab & "File Type" & vbTab & "Last Modified Date" & vbTab & "Date Created" & vbTab & "File Owner"
		WriteHandle.WriteLine "----------------------------------------------------------------------------------------------------------------------------"
		Call FetchInfo(SubFolder.Path)		
		ShowSubFolders SubFolder
	Next
End Sub