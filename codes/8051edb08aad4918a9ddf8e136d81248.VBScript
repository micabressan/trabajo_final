Option Explicit

Dim objShell, objFSO, strAllUsersStartMenu
Dim strApplicationShortName, strCurrentVersion, strInstallMSI
Dim strInstallCommandLine, strInstallLogPath, strCurrentDirectory, qt, strFileToCopy, strWindowsDirectory

Const CommonAppData = &H23&
Const CSIDL_PROGRAM_FILESX86 = &H2a
Const WindowsFolder = 0

Set objShell = CreateObject("WScript.Shell") 
Set objFSO = CreateObject("Scripting.FileSystemObject")
qt = Chr(34)

'Determines the current folder the script is being run from, and the Windows directory for logging.
strCurrentDirectory = objFSO.GetParentFolderName(WScript.ScriptFullName)
Set strWindowsDirectory = objFSO.GetSpecialFolder(WindowsFolder)

'=============================================================================================================
'Define the values of the application installation here
'=============================================================================================================
strApplicationShortName = "" 'application name without spaces, e.g. MicrosoftOfficeProPlus
strCurrentVersion = "" 'application version, e.g. 6.1.7601
strInstallMSI = "" 'name of MSI file WITHOUT the MSI extension
'=============================================================================================================

'Sets the location of the installation & uninstallation logs
strInstallLogPath = strWindowsDirectory & "\CCM\LOGS\Install_" & strApplicationShortName & "_" & strCurrentVersion & ".log"

'Build application install command line
'Without transform:
strInstallCommandLine = "msiexec.exe /i " & qt & strCurrentDirectory & "\" & strInstallMSI & ".msi" & qt & " REBOOT=ReallySuppress /qn /LiV " & strInstallLogPath
'With transform:
'strInstallCommandLine = "msiexec.exe /i " & qt & strCurrentDirectory & "\" & strInstallMSI & ".msi" & qt & " TRANSFORMS=" & qt & strCurrentDirectory & "\" & strInstallMSI & ".mst" & qt & " REBOOT=ReallySuppress /qn /LiV " & strInstallLogPath
'With transform and MSP
'strInstallCommandLine = "msiexec.exe /i " & qt & strCurrentDirectory & "\" & strInstallMSI & ".msi" & qt & " /update " & qt & strCurrentDirectory & "\PATCH.msp" & qt & " TRANSFORMS=" & qt & strCurrentDirectory & "\" & strInstallMSI & ".mst" & qt & " REBOOT=ReallySuppress /qn /LiV " & strInstallLogPath

'WScript.Echo strInstallCommandLine 'Use this for testing

'Installs the Application. It will wait for the command to finish executing before continuing
objShell.Run strInstallCommandLine,0,True 

'Configure Application (regedit)
'Dim strCurrentRegFile
'strCurrentRegFile = qt & strCurrentDirectory & "\REGFILE.reg" & qt
'objShell.Run "regedit.exe /s " & strCurrentRegFile,0,True

'Moves the shortcuts to Applications folder on the start menu
'strAllUsersStartMenu = objShell.SpecialFolders("AllUsersStartMenu")
'If objFSO.FolderExists(strAllUsersStartMenu & "\Programs\Applications") = False Then
'	objFSO.CreateFolder(strAllUsersStartMenu & "\Programs\Applications")
'End If

'If objFSO.FolderExists(strAllUsersStartMenu & "\Programs\Applications") Then
'	If objFSO.FileExists(strAllUsersStartMenu & "\Programs\APPFOLDERNAME\SHORTCUTNAME.lnk") Then 
'		objFSO.CopyFile strAllUsersStartMenu & "\Programs\APPFOLDERNAME\SHORTCUTNAME.lnk",strAllUsersStartMenu & "\Programs\Applications\SHORTCUTNAME.lnk",True
'		objFSO.DeleteFolder strAllUsersStartMenu & "\Programs\APPFOLDERNAME",True
'	End If
'End If

'Grant permission to Registry keys (regini)
'objShell.Run strWindowsDirectory & "\system32\regini.exe " & strCurrentDirectory & "\regini.ini",0,True

set objShell = Nothing
set objFSO = Nothing
