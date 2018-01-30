const QvExecutable = """c:\Program Files\QlikView\qv.exe"" " 
const PsKillExecutable = "pskill.exe " 

function GetAbsolutePath(ByVal filePath)
  if Mid(filePath,2,1) = ":" OR Left(filePath,2) = "\\" then 'Absolute path in input parameter'
    GetAbsolutePath = filePath
  else
    dim fso: set fso = CreateObject("Scripting.FileSystemObject")
    GetAbsolutePath = fso.BuildPath(fso.GetParentFolderName(Wscript.ScriptFullName), filePath)
  end if
end function

Class QlikView
  Private m_App
  Private  m_Doc
  Private m_docName
  Private m_forceKill
  Private m_shell
  Private m_forceOpen
  Private Sub Class_Initialize
    m_docName = ""
    m_forceKill = False
    m_ForceOpen = False
  End Sub

  Public Property Get app
    set app = m_App
  End Property

  Public Property Get doc
    set doc = m_Doc
  End Property

  Public Property Get forceKill
    forceKill = m_forceKill
  End Property

  Public Property Let forceKill(value)
    m_forceKill = value
  End Property

  Public Property Get forceOpen
    forceOpen = m_forceOpen
  End Property

  Public Property Let forceOpen(value)
    m_forceOpen = value
  End Property


  Public Property Get docName
    docName = m_docName
  End Property

  public function setDocument(ByVal docName)
    m_docName = GetAbsolutePath(docName)
    set m_shell = WScript.CreateObject("WScript.Shell")
  end function

  Public Function open(ByVal docName)
    setDocument(docName)
    if m_forceKill then
      killProcess
    end if
    if m_forceOpen then
	    m_shell.Run QvExecutable & """" & m_docName & """"
    	WScript.Sleep 500
    end if
    set m_App  = CreateObject("QlikTech.QlikView")
    set m_Doc = app.OpenDoc(m_docName)
  End Function
  ' Kills QlikView process for current user and current document
  ' Usefull to make periodic executions from Scheduler more robust
  Public function killProcess
    killProcess = False
    Set objNetwork = Wscript.CreateObject("Wscript.Network")
    currUser = LCase(objNetwork.UserName)
    strComputer = "."
    set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
    set colProcessList = objWMIService.ExecQuery ("SELECT * FROM Win32_Process WHERE Name = 'qv.exe'")
    For Each objProcess in colProcessList
      If objProcess.GetOwner ( User, Domain ) = 0 AND LCase(User) = LCase(currUser) Then
        If InStr(objProcess.CommandLine,m_docName)>0 then
          WScript.Echo Now & " Killing process " & objProcess.ProcessId
          m_shell.Run PsKillExecutable & objProcess.ProcessId
          killProcess = True
          WScript.Sleep 1000
        end if
      end if 
    Next
  end function

  Public function Quit
    if m_forceKill then
      WScript.Sleep 500
      killProcess()
    else
      m_App.Quit
    end if
    Release
  End function
  Public function Release
    set m_shell = Nothing
    set m_Doc = Nothing
    set mApp = Nothing
  end function
End Class

'Code below would execute only if script would be directly (not as include file)
'Useful for debugging purpose.
If InStr(LCase(WScript.ScriptFullName),"qvutils.vbs") > 0 then
  with New QlikView
    .open("..\App\AutomationTest.qvw")
    set chart = .doc.GetSheetObject("CH01")
    .doc.Fields("Year").Clear
    set yearValues = .doc.Fields("Year").GetPossibleValues()
    dim curVal
    for i=0 to yearValues.Count - 1
      curVal = yearValues.Item(i).Text
      .doc.Fields("Year").Select curVal
      chart.ExportBiff(GetAbsolutePath("..\Output\Report_" & curVal & ".xls"))
    next
    .doc.CloseDoc
    .Quit
  end with
end if
