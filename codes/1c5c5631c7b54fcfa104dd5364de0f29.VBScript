Const FullAccessMask = 2032127, ModifyAccessMask = 1245631, WriteAccessMask = 1180095, ROAccessMask = 1179817 
Const ForReading = 1, ForWriting = 2, ForAppending = 8
Dim ObjWMI

StrComputer = Trim(WScript.Arguments(0))
StrFolderPath = Trim(WScript.Arguments(1))
StrReportFile = Trim(WScript.Arguments(2))

WScript.Echo
WScript.Echo "Working. Please wait ..."
WScript.Echo "------------------------------"
WScript.Echo

Set ObjFSO = CreateObject("Scripting.FileSystemObject")
FullFileName = StrReportFile
Set FSWrite = ObjFSO.OpenTextFile(FullFileName, ForAppending, True)

FSWrite.WriteLine "===================================================================================="
FSWrite.WriteLine "List Folder And Sub-Folder Permission On Computer: " & StrComputer
FSWrite.WriteLine "As On: " & FormatDateTime(Now(), 2) & " At: " & FormatDateTime(Now(), 3)
FSWrite.WriteLine "===================================================================================="

On Error Resume Next

Set ObjWMI = GetObject("WinMgmts:\\" & StrComputer & "\Root\CIMV2")

If Err.Number <> 0 Then
	FSWrite.WriteLine "An Error Occurred On Computer: " & StrComputer
	FSWrite.WriteLine "Error: " & Err.Number & ". " & Err.Description
	FSWrite.WriteLine:	FSWrite.WriteLine
     	Err.Clear
	FSWrite.Close:	Set FSWrite = Nothing
	Set ObjFSO = Nothing:	WScript.Quit
End If

Set ObjWMI = Nothing

ShowSubFolders ObjFSO.GetFolder(StrFolderPath), FullFileName
WScript.Echo vbTab & ">> Now Checking Parent Folder: " & StrFolderPath
OutputFolderInfo StrFolderPath, FullFileName
FSWrite.Close:	Set FSWrite = Nothing
Set ObjFSO = Nothing:	WScript.Quit

' ==============================================================================================================================

Public Sub OutputFolderInfo(FolderName , sOutfile)

On Error Resume Next 
 
' --- Build the path to the folder because it requites 2 backslashes 
FolderPath = Replace(FolderName, "\", "\\")
ObjectPath = "WinMgmts:\\" & StrComputer & "\Root\CIMV2:Win32_LogicalFileSecuritySetting.path='" & FolderPath & "'"
 
' --- Get the security set for the object 
Set wmiFileSecSetting = GetObject(objectpath)

If Err.Number <> 0 Then
	FSWrite.WriteLine "An Error Occurred On Computer: " & StrComputer
	FSWrite.WriteLine "Error: " & Err.Number & ". " & Err.Description
	FSWrite.WriteLine:	FSWrite.WriteLine
     	Err.Clear
	FSWrite.Close:	Set FSWrite = Nothing
	Set ObjFSO = Nothing:	WScript.Quit
End If
 
'verify that the get was successful 
RetVal = wmiFileSecSetting.GetSecurityDescriptor(wmiSecurityDescriptor)
If Err.Number <> 0 Then
	FSWrite.WriteLine "Failed To Obtain The Security Descriptor For: " & StrComputer
	FSWrite.WriteLine "Error: " & Err.Number & ". " & Err.Description
	FSWrite.WriteLine:	FSWrite.WriteLine
     	Err.Clear
	FSWrite.Close:	Set FSWrite = Nothing
	Set ObjFSO = Nothing:	WScript.Quit
End If
 
Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2") 
Set colFolders = objWMIService.ExecQuery("SELECT * FROM Win32_Directory WHERE Name ='" & FolderPath & "'") 
For Each objFolder In colFolders
	' --- Retrieve the DACL array of Win32_ACE objects.
	DACL = wmiSecurityDescriptor.DACL  
	Set ObjFSO = CreateObject("Scripting.FileSystemObject") 
	Set FSWrite = ObjFSO.OpenTextFile(StrReportFile, ForAppending, True)		
		If StrComp(StrFolderPath, ObjFolder.Name, vbTextCompare) = 0 Then
			FSWrite.WriteLine "PARENT FOLDER: " & ObjFolder.Name
		Else
			FSWrite.WriteLine "Sub-Folder: " & ObjFolder.Name
		End If
		FSWrite.WriteLine "---------------------------------------------------------------------"
    	For Each wmiAce In DACL 
		' -- Get Win32_Trustee object from ACE 
        	Set Trustee = wmiAce.Trustee 
        	FoundAccessMask = False:	CustomAccessMask = False 
        	While Not FoundAccessMask And Not CustomAccessMask 
            		If wmiAce.AccessMask = FullAccessMask Then 
                		AccessType = "Full Control" 
               			FoundAccessMask = True 
            		End If 
            		If wmiAce.AccessMask = ModifyAccessMask Then 
                		AccessType = "Modify" 
                		FoundAccessMask = True 
            		End If 
            		If wmiAce.AccessMask = WriteAccessMask Then 
                		AccessType = "Read/Write Control" 
                		FoundAccessMask = True 
            		End If 
            		If wmiAce.AccessMask = ROAccessMask Then 
                		AccessType = "Read Only" 
                		FoundAccessMask = True 
            		Else 
                		CustomAccessMask = True 
            		End If 
        	Wend		
		If FoundAccessMask Then 
			FSWrite.Writeline Trustee.Domain & "\" & Trustee.Name & " ---> " & AccessType
		Else 
			FSWrite.Writeline Trustee.Domain & "\" & Trustee.Name & " ---> Custom"
		End If		
    	Next
	FSWrite.WriteLine:	FSWrite.WriteLine 
Next  
 
End Sub

Private Sub ShowSubFolders (Folder, FName)
	On Error Resume Next
	If Err.Number <> 0 Then
		FSWrite.WriteLine "An Error Occurred On Computer: " & StrComputer
		FSWrite.WriteLine "Error: " & Err.Number & ". " & Err.Description
		FSWrite.WriteLine:	FSWrite.WriteLine
     		Err.Clear
		FSWrite.Close:	Set FSWrite = Nothing
		Set ObjFSO = Nothing:	WScript.Quit
	End If
	For Each SubFolder In Folder.SubFolders 
        	Call OutputFolderInfo(SubFolder.Path,FName) 
        	WScript.Echo vbTab & ">> Checking Folder: " & SubFolder.Path 
        	Call ShowSubFolders (SubFolder, FName) 
    	Next 
End Sub