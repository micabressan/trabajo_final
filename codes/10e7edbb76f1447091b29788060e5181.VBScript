Option Explicit

Const FullAccessMask = 2032127, ModifyAccessMask = 1245631, WriteAccessMask = 1180095, ROAccessMask = 1179817
Const wbemFlagReturnImmediately = &h10
Const wbemFlagForwardOnly = &h20
Const ForReading = 1
Dim ColShares, Folder, Share, ObjDACL, WMIAce, Trustee, WMIShare, WMIShareSecSetting, ObjFSO, WriteHandle
Dim RetVal, TheShareNameRetVal, TheFolderNameRetVal, StrComputer, StrReportFile, ObjWMI, TheShareName
Dim ShareName, SharePath, TheFolderName

On Error Resume Next 

StrComputer = Trim(WScript.Arguments(0)):	StrReportFile = Trim(WScript.Arguments(1))

WScript.Echo
WScript.Echo "Working. Please wait ..."
Set ObjFSO = CreateObject("Scripting.FileSystemObject") 
Set WriteHandle = ObjFSO.OpenTextFile(StrReportFile, 8, True, 0)
WriteHandle.WriteLine "========================================================================================================="
WriteHandle.WriteLine "LISTING NTFS AND SHARED FOLDER PERMISSION ON COMPUTER: " & UCase(StrComputer)
WriteHandle.WriteLine "As On: " & FormatDateTime(Now(), 2) & " At: " & FormatDateTime(Now(), 3)
WriteHandle.WriteLine "========================================================================================================="
WriteHandle.WriteLine

Set ObjWMI = GetObject("WinMgmts:{impersonationLevel=impersonate}!\\" & StrComputer & "\Root\CIMV2")

If Err.Number <> 0 Then
	WriteHandle.WriteLine "An Error Occurred On: " & StrComputer
	WriteHandle.WriteLine "Error: " & Err.Number & ". " & Err.Description
	WriteHandle.WriteLine:	WriteHandle.WriteLine
	Err.Clear
	Set ObjWMI = Nothing
	WriteHandle.Close:	Set WriteHandle = Nothing
	Set ObjFSO = Nothing:	WScript.Quit
End If

Set ColShares = ObjWMI.ExecQuery("Select Name, Type, Path From Win32_Share", "WQL", wbemFlagReturnImmediately + wbemFlagForwardOnly)
For Each Share In ColShares
	If Share.Type = 0 Then
 		ShareName = Share.Name:	SharePath = Share.Path
		If StrComp(ShareName, "Print$", vbTextCompare) <> 0 Then
			WriteHandle.WriteLine "Permissions For Share: " & ShareName
			WriteHandle.WriteLine "Full Path To Share: " & SharePath
			WriteHandle.WriteLine "-----------------------------------------------------------------------------------------------"
			WriteHandle.WriteLine "Users" & vbTab & vbTab & vbTab & vbTab & "Access Type"
			WriteHandle.WriteLine "-----------------------------------------------------------------------------------------------"
 			Set Folder = GetObject("WinMgmts:\\" & StrComputer & "\Root\CIMV2:Win32_LogicalFileSecuritySetting.path='" & SharePath & "'")
 			TheFolderNameRetVal = Folder.GetSecurityDescriptor(TheFolderName)
 			RetVal = Folder.GetSecurityDescriptor(TheFolderName)
 			ObjDACL = TheFolderName.DACL
 			For Each WMIAce In ObjDACL
 				Set Trustee = WMIAce.Trustee
				Select Case WMIAce.AccessMask
					Case 2032127
						WriteHandle.WriteLine Trustee.Domain & "\" & Trustee.Name & vbTab & vbTab & "FULL CONTROL"
					Case 1245631
						WriteHandle.WriteLine Trustee.Domain & "\" & Trustee.Name & vbTab & vbTab & "MODIFY"
					Case 1180095
						WriteHandle.WriteLine Trustee.Domain & "\" & Trustee.Name & vbTab & vbTab & "READ/WRITE"
					Case 1179817
						WriteHandle.WriteLine Trustee.Domain & "\" & Trustee.Name & vbTab & vbTab & "READ ONLY"
					Case Else
						WriteHandle.WriteLine Trustee.Domain & "\" & Trustee.Name & vbTab & vbTab & "CUSTOM"
				End Select
				Set Trustee = Nothing
 			Next
			WriteHandle.WriteLine:	WriteHandle.WriteLine
		End If
 	End If
Next
Set ColShares = Nothing:	Set ObjWMI = Nothing
WriteHandle.Close:	Set WriteHandle = Nothing
Set ObjFSO = Nothing:	WScript.Quit