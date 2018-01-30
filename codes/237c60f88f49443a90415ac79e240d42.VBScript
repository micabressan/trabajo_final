Option Explicit

Dim objShell, objFSO, strAllUsersStartMenu
Dim strApplicationShortName, strCurrentVersion, strUninstallGUID
Dim strUninstallCommandLine, strUninstallLogPath, strCurrentDirectory, qt, strWindowsDirectory

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
'Define the values of the application uninstallation here
'=============================================================================================================
strApplicationShortName = "ApplicationShortName" 'application name without spaces, e.g. MicrosoftOfficeProPlus
strCurrentVersion = "MSIVersion" 'application version, e.g. 6.1.7601
strUninstallGUID = "GUID" 'insert application GUID, WITHOUT the curly brackets
'=============================================================================================================

'Sets the location of the uninstallation log
strUninstallLogPath = strWindowsDirectory & "\CCM\LOGS\Uninstall_" & strApplicationShortName & "_" & strCurrentVersion & ".log"

'Build application uninstall command line
strUninstallCommandLine = "MsiExec.exe /x{" & strUninstallGUID & "} REBOOT=ReallySuppress /qn /Liv " & strUninstallLogPath

'Uninstalls the Application. It will wait for the command to finish executing before continuing
objShell.Run strUninstallCommandLine,0,True

'Delete application shortcuts
'strAllUsersStartMenu = objShell.SpecialFolders("AllUsersStartMenu")
'If objFSO.FileExists(strAllUsersStartMenu & "\Programs\Applications\SHORTCUTNAME.lnk") Then 
'		objFSO.DeleteFile strAllUsersStartMenu & "\Programs\Applications\SHORTCUTNAME.lnk",True
'End If

set objShell = Nothing
set objFSO = Nothing
