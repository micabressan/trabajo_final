Option Explicit

Dim StrFolder, ObjShell, ObjFolder, StrFile, StrReportFile
Dim ObjFSO, WriteHandle, StrFilePath

StrFolder = Trim(WScript.Arguments(0))
StrReportFile = Trim(WScript.Arguments(1))

WScript.Echo
WScript.Echo "Working. Please wait ..."

Set ObjFSO = CreateObject("Scripting.FileSystemObject")
StrFilePath = Trim(ObjFSO.GetFile(WScript.ScriptFullName).ParentFolder)
Set WriteHandle = ObjFSO.OpenTextFile(StrFilePath & "\Reports\" & StrReportFile, 8, True, 0)

Set ObjShell = CreateObject("Shell.Application")
Set ObjFolder = ObjShell.Namespace(Strfolder)

For Each StrFile In ObjFolder.Items
	WriteHandle.WriteLine ObjFolder.GetDetailsOf(StrFile, 0) & vbTab & ObjFolder.GetDetailsOf(StrFile, 1) & vbTab & ObjFolder.GetDetailsOf(StrFile, 2) & vbTab & ObjFolder.GetDetailsOf(StrFile, 4) & vbTab & ObjFolder.GetDetailsOf(StrFile, 3) & vbTab & ObjFolder.GetDetailsOf(StrFile, 10)
Next
StrFolder = vbNullString:	StrFilePath = vbNullString:	StrFile = vbNullString
Set ObjFolder = Nothing:	Set ObjShell = Nothing
WriteHandle.Close:	Set WriteHandle = Nothing
Set ObjFSO = Nothing:	WScript.Quit