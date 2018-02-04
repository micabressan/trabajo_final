'Ping multiple computers and log when one doesn't respond.
'################### Configuration #######################

'Enter the IPs or machine names on the line below separated by a semicolon
strMachines = "www.yahoo.com;www.google.com;www.microsoft.com"

'Make sure that this log file exists, if not, the script will fail.
strLogFile = "c:\logs\pinglog.txt"

'################### End Configuration ###################

'The default application for .vbs is wscript. If you double-click on the script,
'this little routine will capture it, and run it in a command shell with cscript.
If Right(WScript.FullName,Len(WScript.FullName) - Len(WScript.Path)) <> "\cscript.exe" Then
	Set objWMIService = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
	Set objStartup = objWMIService.Get("Win32_ProcessStartup")
	Set objConfig = objStartup.SpawnInstance_
	Set objProcess = GetObject("winmgmts:root\cimv2:Win32_Process")
	objProcess.Create WScript.Path + "\cscript.exe """ + WScript.ScriptFullName + """", Null, objConfig, intProcessID
	WScript.Quit
End If

Const ForAppending = 8
Const ForReading = 1
Const ForWriting = 2

Set objFSO = CreateObject("Scripting.FileSystemObject")

If objFSO.FileExists(strLogFile) Then
    Set objFolder = objFSO.GetFile(strLogFile)
Else
    Wscript.Echo "Log file does not exist. Please create " & strLogFile
    WScript.Quit
End If

aMachines = Split(strMachines, ";")

Do While True 
	For Each machine In aMachines
		Set objPing = GetObject("winmgmts:{impersonationLevel=impersonate}")._
		ExecQuery("select * from Win32_PingStatus where address = '"_
		& machine & "'")
		For Each objStatus In objPing
			If IsNull(objStatus.StatusCode) Or objStatus.StatusCode<>0 Then 
				Call logme(Time & " - "  & machine & " is not responding to ping",strLogFile) 
			Else
				WScript.Echo(Time & " + "  & machine & " is responding to ping")    
			End If
		Next
	Next
	WScript.Sleep 5000
Loop

Sub logme(message,logfile)
	Set objTextFile = objFSO.OpenTextFile(logfile, ForAppending, True)
	objtextfile.WriteLine(message)
	WScript.Echo(message)
	objTextFile.Close
End Sub