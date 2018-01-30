Set WshShell = WScript.CreateObject("wscript.shell")
Set objArgs = WScript.Arguments
Set fso = CreateObject("Scripting.FileSystemObject")
'answer = MsgBox("Click OK to choose an input file"  & Chr(10) & Chr(13) & "or click Cancel to use the default of servers.txt", 65, "Computer Info Tool")
'If answer = 1 Then
'	Set ObjFSO = CreateObject("UserAccounts.CommonDialog")
'	ObjFSO.Filter = "Text Documents|*.txt"
'ObjFSO.Title = "Select an Input File"
'	ObjFSO.FilterIndex = 3
'	ObjFSO.InitialDir = wshshell.currentdirectory
'	InitFSO = ObjFSO.ShowOpen
'	If InitFSO = False Then
'		WScript.Echo "Script Error: Please select a file!"
'		WScript.Quit
'	Else
'		inputfile = ObjFSO.FileName
'	End If
'End If
Dim InputFile, OutputFile


InputFile = ChooseFile()
arrFilename = Split(InputFile,"\")
OutputFile = Replace(Replace(CStr(arrFilename(UBound(arrFilename))),"""",""),".","_")
'WScript.Echo OutputFile
'WScript.Echo InputFile
'WScript.Quit


If fso.FileExists(InputFile) Then
	Set objExcel = CreateObject("Excel.Application")
	objExcel.Visible = True
	'objExcel.Workbooks.Add
	Set objWorkbook = objExcel.Workbooks.Add()
	Set objWorksheet = objWorkbook.Worksheets(1)
	objExcel.worksheets(2).delete
	objExcel.worksheets(2).delete
	'	objExcel.name = OutputFile
	objExcel.ActiveWorkbook.Windows(1).Caption = OutputFile
	strOut = ""
	getOSInfo
	
	
	
	
	'Else
	'	WScript.Echo "Input file doesnt exist. Please make sure that the servers.txt file exists in the directory you are running this from."
End If

Sub getOSInfo()
	On Error Resume Next
	
	objExcel.worksheets(1).Activate
	objExcel.worksheets(1).Name = "Computer Info"
	objExcel.Cells(1, 1).Value = "Computer Name"
	objExcel.Cells(1, 2).Value = "Ping"
	objExcel.Cells(1, 3).Value = "IP from Ping"
	objExcel.Cells(1, 4).Value = "Computer Name from system"
	objExcel.Cells(1, 5).Value = "IP(s) from system"
	objExcel.Cells(1, 6).Value = "Operating System"
	objExcel.Cells(1, 7).Value = "Last Bootup Time"
	objExcel.Cells(1, 8).Value = "Install Date"
	objExcel.Cells(1, 9).Value = "Manufacturer"
	objExcel.Cells(1, 10).Value = "Serial Number"
	objExcel.Cells(1, 11).Value = "Model"
	objExcel.Cells(1, 12).Value = "LDAP DN"
	objExcel.Cells(1, 13).Value = "Member of Group(s)"
	objExcel.Cells(1, 14).Value = "Amt. of Storage Allocated"
	objExcel.Cells(1, 15).Value = "# of Processors"
	objExcel.Cells(1, 16).Value = "Processor Type"
	objExcel.Cells(1, 17).Value = "Memory (GB)"
	'	objExcel.Cells(1, 18).Value = "Location (from MDL)"
	'	objExcel.Cells(1, 19).Value = "Environment (from MDL)"
	rowVar=2
	
	Set txtStreamIn = fso.OpenTextFile(InputFile)
	Do While Not (txtStreamIn.AtEndOfStream)
		strComputer = txtStreamIn.ReadLine
		strComputer = ereg_replace(strComputer, "/s", "", True)
		If strComputer <> "" Then
			objExcel.ActiveWorkbook.Windows(1).Caption = "Pinging " & strComputer
			Set objPing = GetObject("winmgmts:{impersonationLevel=impersonate}")._
			ExecQuery("select * from Win32_PingStatus where address = '"_
			& strComputer & "'")
			For Each objStatus In objPing
				If IsNull(objStatus.StatusCode) Or objStatus.StatusCode<>0 Then
					'WScript.Echo objStatus.StatusCode
					'WScript.Echo("Computer " & strComputer & " did not respond.")
					objExcel.Cells(rowVar, 2).Value = "No response"
					objExcel.Cells(rowVar, 3).Value = objStatus.ProtocolAddress
				Else
					'WScript.Echo("Computer " & strComputer & " responded on " & objStatus.ProtocolAddress & " in " & objStatus.ResponseTime & "ms.")
					objExcel.Cells(rowVar, 2).Value = objStatus.ResponseTime & "ms"
					objExcel.Cells(rowVar, 3).Value = objStatus.ProtocolAddress
				End If
			Next
			
			Set objWMIService = GetObject("winmgmts:" _
			& "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
			If Err.Number <> 0 Then
				objExcel.Cells(rowVar, 1).Value = strComputer
				objExcel.Cells(rowVar, 4).Value = "Error # " & CStr(Err.Number) & " " & Err.Description
				printout "Error # " & CStr(Err.Number) & " " & Err.Description
				rowvar = rowvar+1
				Err.Clear
			Else
				
				objExcel.ActiveWorkbook.Windows(1).Caption = "Getting Win32_OperatingSystem for " & strComputer
				Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
				
				objExcel.ActiveWorkbook.Windows(1).Caption = "Getting Win32_BIOS for " & strComputer
				Set colBIOS = objWMIService.ExecQuery ("Select * from Win32_BIOS")
				
				objExcel.ActiveWorkbook.Windows(1).Caption = "Getting Win32_ComputerSystem for " & strComputer
				Set colComputerSystem = objWMIService.ExecQuery ("Select * from Win32_ComputerSystem")
				
				objExcel.ActiveWorkbook.Windows(1).Caption = "Getting Win32_NetworkAdapterConfiguration for " & strComputer
				Set colNetworkAdapterConfiguration = objWMIService.ExecQuery ("Select * from Win32_NetworkAdapterConfiguration")
				
				objExcel.ActiveWorkbook.Windows(1).Caption = "Getting Win32_Processor info for " & strComputer
				Set colProc = objWMIService.ExecQuery("Select * from Win32_Processor")
				
				For Each objOS In colOperatingSystems
					
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting Computer Name for " & strComputer
					objExcel.Cells(rowVar, 1).Value = strComputer
					
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting Last Boot Time for " & strComputer
					Set dtmConvertedDate = CreateObject("WbemScripting.SWbemDateTime")
					dtmConvertedDate.Value = objOS.InstallDate
					dtmInstallDate = dtmConvertedDate.GetVarDate
					objExcel.Cells(rowVar, 8).Value = dtmInstallDate
					tempArray = Split(objOS.name, "|")
					objExcel.Cells(rowVar, 6).Value = tempArray(0)
					'dtmBootup = objOS.LastBootUpTime
					'dtmLastBootupTime = WMIDateStringToDate(dtmBootup)
					'objExcel.Cells(rowVar, 7).Value = DateDiff("s", dtmLastBootUpTime, Now)
					dtmConvertedDate.Value = objOS.LastBootUpTime
					dtmBootTime = dtmConvertedDate.GetVarDate
					objExcel.Cells(rowVar, 7).Value = dtmBootTime
				Next
				
				For Each objBIOS In colBIOS
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting BIOS info for " & strComputer
					objExcel.Cells(rowVar, 10).Value = objBIOS.SerialNumber
				Next
				
				For Each objCS In colComputerSystem
					
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting Manufacturer info for " & strComputer
					objExcel.Cells(rowVar, 9).Value = objCS.Manufacturer
					
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting Model info for " & strComputer
					objExcel.Cells(rowVar, 11).Value = objCS.Model
					
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting name from WMI for " & strComputer
					objExcel.Cells(rowVar, 4).Value = objCS.name
					
					objExcel.ActiveWorkbook.Windows(1).Caption = "Setting Total Physical Memory for " & strComputer
					objExcel.Cells(rowVar, 17).Value = Round(objCS.TotalPhysicalMemory/1024/1024/1024,2)
				Next
				
				For Each objNetAdapter In colNetworkAdapterConfiguration
					objExcel.ActiveWorkbook.Windows(1).Caption = "Getting IP Addresses for " & strComputer
					ipAddress = objNetAdapter.ipaddress
					For i = 0 To UBound(ipaddress)
						If iplist = "" Then
							iplist = ipaddress(i)
						Else
							iplist = iplist & ", " & ipaddress(i)
						End If
					Next
					objExcel.Cells(rowVar, 5).Value = iplist
					
				Next
				
				
				Err.Clear
				strUser = strComputer & "$"
				objExcel.ActiveWorkbook.Windows(1).Caption = "Getting AD Group info for " & strComputer
				Set objRoot = GetObject("LDAP://RootDSE")
				defaultNC = objRoot.Get("defaultnamingcontext")
				computerDN = FindUser(strUser, defaultNC)
				ouarray = Split(computerDN,",")
				For i = 1 To UBound(ouarray)
					If ou = "" Then
						ou = ouarray(i)
					Else
						ou = ou & "," & ouarray(i)
					End If
				Next
				objExcel.Cells(rowVar, 12).Value = ou
				
				Set dicSeenGroup = CreateObject("Scripting.Dictionary")
				strGroups = DisplayGroups(computerDN,"",dicSeenGroup)
				aryGroups = Split(strGroups,"CN=")
				strGroups = ""
				For i = 2 To UBound(aryGroups)
					strGroups = strGroups & ", " & aryGroups(i)
				Next
				objExcel.Cells(rowVar, 13).Value = Right(strGroups,Len(strGroups) -2)
				Err.Clear
				
				stroutput = getDriveLettersAndSize(strComputer)
				objExcel.Cells(rowVar, 14).Value = Left(stroutput,Len(stroutput)-2)
				
				'On Error Goto 0
				ProcCount = 0
				objExcel.ActiveWorkbook.Windows(1).Caption = "Setting number of processors for " & strComputer
				For Each processor In colProc
					ProcCount = ProcCount + 1
					ProcName = processor.name
				Next
				objExcel.Cells(rowVar, 15).Value = ProcCount
				objExcel.Cells(rowVar, 16).Value = Trim(ProcName)
				
				strOut = ""
				iplist = ""
				ou = ""
				rowvar = rowvar+1
			End If
		End If
		
	Loop
	objExcel.Cells.Select
	objExcel.Cells.EntireColumn.AutoFit
	objExcel.Range("B2").Select
	objExcel.ActiveWindow.FreezePanes = True
	objExcel.ActiveWorkbook.Windows(1).Caption = "Finished gathering computer info"
	
End Sub 'getUpdatesInfo

Sub printOut (data)
	'WScript.Echo data
	txtStreamOut.writeline data
End Sub 'printOut

Function cleanme(str)
	On Error Resume Next
	Dim regEx
	Set regEx = New RegExp
	regEx.Global = True
	regEx.IgnoreCase = True
	regEx.Pattern = "\s"
	str = Trim(regEx.Replace(str, ""))
	return str
End Function 'cleanme

Function ereg_replace(strOriginalString, strPattern, strReplacement, varIgnoreCase)
	' Function replaces pattern with replacement
	' varIgnoreCase must be TRUE (match is case insensitive) or FALSE (match is case sensitive)
	Dim objRegExp :
	Set objRegExp = New RegExp
	With objRegExp
		.Pattern = strPattern
		.IgnoreCase = varIgnoreCase
		.Global = True
	End With
	ereg_replace = objRegExp.Replace(strOriginalString, strReplacement)
	Set objRegExp = Nothing
End Function

Function FindUser(Byval UserName, Byval Domain)
	On Error Resume Next
	
	Set cn = CreateObject("ADODB.Connection")
	Set cmd = CreateObject("ADODB.Command")
	Set rs = CreateObject("ADODB.Recordset")
	
	cn.open "Provider=ADsDSOObject;"
	
	cmd.activeconnection=cn
	cmd.commandtext="SELECT ADsPath FROM 'LDAP://" & Domain & _
	"' WHERE sAMAccountName = '" & UserName & "'"
	
	Set rs = cmd.Execute
	
	If Err<>0 Then
		FindUser="Error connecting to Active Directory Database:" & Err.description
		'wscript.quit
	Else
		If Not rs.BOF And Not rs.EOF Then
			rs.MoveFirst
			FindUser = rs(0)
		Else
			FindUser = "Not Found"
		End If
	End If
	cn.close
End Function

Function DisplayGroups ( strObjectADsPath, strSpaces, dicSeenGroup)
	Set objObject = GetObject(strObjectADsPath)
	'strOut must be global variable
	strOut = strOut & strSpaces & objObject.Name
	On Error Resume Next ' Doing this to avoid an error when memberOf is empty
	If IsArray( objObject.Get("memberOf") ) Then
		colGroups = objObject.Get("memberOf")
	Else
		colGroups = Array( objObject.Get("memberOf") )
	End If
	
	For Each strGroupDN In colGroups
		If Not dicSeenGroup.Exists(strGroupDN) Then
			dicSeenGroup.Add strGroupDN, 1
			DisplayGroups "LDAP://" & strGroupDN, strSpaces & " ", dicSeenGroup
		End If
	Next
	Err.Clear
	DisplayGroups = strOut
End Function

Function getDriveLettersAndSize(strComputer)
	On Error Resume Next
	Set objWMIService = GetObject("winmgmts://" & strComputer & "/root/cimv2")
	If Err.Number Then
		getDriveLettersAndSize = "Error # " & CStr(Err.Number) & " " & Err.Description & "  "
		Err.Clear
	Else
		On Error Goto 0
		Set colItems = objWMIService.ExecQuery("Select * from Win32_LogicalDisk where DriveType=3", , 48)
		For Each objItem In colItems
			getDriveLettersAndSize = getDriveLettersAndSize & objItem.Name & " " & Round(getDriveSizeTotal(strComputer,objItem.Name)/1024/1024/1024,2) & "GB, "
		Next
	End If
End Function

Function getDriveSizeTotal(strComputer, drvLetter)
	On Error Resume Next
	Set objWMIService = GetObject("winmgmts://" & strComputer & "/root/cimv2")
	strTemp = strComputer
	If Err.Number Then
		getDriveSizeTotal = "0"
		Err.Clear
	Else
		On Error Goto 0
		Set colItems = objWMIService.ExecQuery("Select * from Win32_LogicalDisk where DriveType=3", , 48)
		For Each objItem In colItems
			If UCase(objItem.Name) = UCase(drvLetter) Then
				getDriveSizeTotal = objItem.Size
			End If
		Next
	End If
End Function

Function ChooseFile( )
	Dim objFSO, objShell, objTempFolder, strTempFileName, strFullTempFileName, objOpenFile, objTextFile, strTempTextFileName
	Const TemporaryFolder = 2
	Const ForReading = 1
	strTempFileName = "OpenFile.hta"
	strTempTextFileName = "OpenFile.txt"
	Set objFSO= CreateObject("Scripting.FileSystemObject")
	Set objTempFolder = objFSO.GetSpecialFolder(TemporaryFolder)
	strFullTempFileName=objTempFolder.Path & "\" & strTempFileName
	Set objOpenFile = objFSO.CreateTextFile(strFullTempFileName,True)
	objOpenFile.writeline("<html><head><meta http-equiv=""Content-Type"" content=""text/html; charset=windows-1252"">")
	objOpenFile.writeline("<title>Open File</title>")
	objOpenFile.writeline("<script language=""vbscript"">")
	objOpenFile.writeline("Sub Window_Onload")
	objOpenFile.writeline("FileName.click")
	objOpenFile.writeline("WriteFile FileName.value")
	objOpenFile.writeline("Self.Close()")
	objOpenFile.writeline("End Sub")
	objOpenFile.writeline("Sub WriteFile(strFileName)")
	objOpenFile.writeline("Dim objFSO, objTempFolder, strTempFileName, strFullTempFileName, objOpenFile")
	objOpenFile.writeline("Const TemporaryFolder = 2")
	objOpenFile.writeline("strTempFileName = ""OpenFile.txt""")
	objOpenFile.writeline("Set objFSO=CreateObject(""Scripting.FileSystemObject"")")
	objOpenFile.writeline("Set objTempFolder = objFSO.GetSpecialFolder(TemporaryFolder)")
	objOpenFile.writeline("strFullTempFileName=objTempFolder.Path & ""\"" & strTempFileName")
	objOpenFile.writeline("Set objOpenFile = objFSO.CreateTextFile(strFullTempFileName,True)")
	objOpenFile.writeline("objOpenFile.writeline(strFileName)")
	objOpenFile.writeline("objOpenFile.Close")
	objOpenFile.writeline("Set objFSO=Nothing")
	objOpenFile.writeline("Set objTempFolder=Nothing")
	objOpenFile.writeline("Set objSleepFile=Nothing")
	objOpenFile.writeline("Set objShell=Nothing")
	objOpenFile.writeline("End Sub")
	objOpenFile.writeline("</script>")
	objOpenFile.writeline("<hta:application applicationname=""Open File"" border=""dialog"" borderstyle=""normal"" caption=""Open File"" contextmenu=""no"" maximizebutton=""no"" minimizebutton=""no"" navigable=""no"" scroll=""no"" selection=""no"" showintaskbar=""no"" singleinstance=""yes"" sysmenu=""no"" version=""1.0"" windowstate=""minimize"">")
	objOpenFile.writeline("</head>")
	objOpenFile.writeline("<body>")
	objOpenFile.writeline("<input Application=""True"" type=""file"" id=""FileName"" />")
	objOpenFile.writeline("</body>")
	objOpenFile.writeline("</html>")
	objOpenFile.Close
	Set objShell = CreateObject("WScript.Shell")
	objShell.Run "mshta.exe " & strFullTempFileName,0,True
	objFSO.DeleteFile strFullTempFileName, True
	Set objShell=Nothing
	Set objOpenFile=Nothing
	strFullTempFileName = objTempFolder.Path & "\" & strTempTextFileName
	Set objTextFile=objFSO.OpenTextFile(strFullTempFileName, ForReading)
	ChooseFile = objTextFile.ReadLine 
	objTextFile.Close
	objFSO.DeleteFile strFullTempFileName, True
	Set objTextFile=Nothing
	Set objFSO=Nothing
	Set objTempFolder=Nothing
End Function