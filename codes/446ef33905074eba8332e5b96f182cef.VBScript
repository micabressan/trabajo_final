' netmessenger-ptbr.vbs
' Script que envia mensagens pela rede, como o velho NET SEND
' Versão 1.1
' Data da versão: 26/8/2011
' Melhorias da versão : Processamento não mostra várias janelas do prompt de comando
'                       e mensagens de progresso são mostradas no processamento         
' Por Pedro Lima (pedrofln.blogspot.com)
' MBA em Tecnologia da Informação
' MCT, MCSE, MCSA, MCP+I, Network+ Certified Professional
' ------------------------------------------------------------

Option Explicit  
On Error Resume Next  
Const ADS_SCOPE_SUBTREE = 2 
Dim objConnection, objCommand, objRecordSet, objShell, objSA, objArquivoTexto, objProcessEnv
Dim strDomain, strContent, strCommand, strComputer, strMessage, strComputers, strCall, strLdapDomain
Dim intCounter, intLines, intDomainParts, intDomainLenght, intPosition, intSent, intNotSent, intComputermatch
IntNotSent = 0
IntSent = 0

Set objShell = CreateObject("WScript.Shell")
Set objProcessEnv = objShell.Environment("Process")

'Asks the user to type the message
strMessage = InputBox("Digite a mensagem a ser enviada para o(s) computador(es) da rede","Serviço Mensageiro", strMessage)
If strMessage = "" Then
   Wscript.Echo "Operação cancelada pelo usuário"
   Wscript.Quit
End If

'Determina o escopo da mensagem a ser enviada
strComputer = InputBox("--> Digite * para todos os computadores, ou " & vbcr & "--> um nome de um único computador, ou" & vbcr & "--> um caminho para um arquivo contendo " & vbcr & "uma lista de computadores como c:\list.txt" & vbcr & "OBS: Deve conter o caractere ':' no caminho","Escolha o escopo correto", strComputer)
If strComputer = "" Then
   Wscript.Echo "Operação cancelada pelo usuário"
   Wscript.Quit
End If

If strComputer = "*" then  
  ' Pega o nome de domínio que a máquina faz parte (se ela não fizer o modo * não vai funcionar)
  strdomain = objProcessEnv("USERDNSDOMAIN")
  If strdomain = "" then
     Wscript.Echo "Este computador não  é membro de  um  domínio, ou talvez a conta que você" & vbcr & "usou para chamar o script não tenha privilégios de consulta ao AD. Por favor," & vbcr & "tente novamente usando um nome de computador ou uma lista de computa-" & vbcr & "dores em arquivo."
	 Wscript.Quit
  else
    intdomainparts = Int(Conta(strdomain,".", false))
	For intCounter = 1 to intdomainparts
	  intdomainlenght = len(strdomain)
	  If intCounter < intDomainparts Then 
        intposition = InStr(strdomain, ".")
	  Else
	    intposition = intdomainlenght+1
	  End if
      strldapdomain = strldapdomain & ",DC=" & left(strdomain, intposition - 1)
	  If intCounter < intDomainparts Then 
	    strdomain = right(strdomain, intdomainlenght-intposition)
	  End If
    Next
  End If
  strLdapDomain = right(strldapdomain, len(strldapdomain)-1)
  Set objConnection = CreateObject("ADODB.Connection")
  Set objCommand =   CreateObject("ADODB.Command")  
  objConnection.Provider = "ADsDSOObject"  
  objConnection.Open "Active Directory Provider"  
  Set objCOmmand.ActiveConnection = objConnection  

  'Pega todos os objetos de computador ativos no domínio  
  objCommand.CommandText = "Select Name from 'LDAP://" & strLdapDomain & _
  "' where objectClass='computer'"
  objCommand.Properties("Page Size") = 1500  
  objCommand.Properties("Timeout") = 30  
  objCommand.Properties("Searchscope") = ADS_SCOPE_SUBTREE  
  objCommand.Properties("Cache Results") = False  
  Set objRecordSet = objCommand.Execute  
  intComputermatch = objRecordSet.RecordCount 
  Set objRecordSet = objCommand.Execute  ' Necessário chamar novamente por conta do RecordCount
    
  'Falha quando há erro no nome do domínio 
  If Err.Number <> 0 Then 
     Wscript.Echo "O  script  mensageiro  não  conseguiu  encontrar  o domínio  especificado." & vbcr & "Veja se a conta utilizada para chamar o script tem privilégios suficientes" & vbcr & "Nenhuma mensagem foi enviada."
	Wscript.Quit 
  Else
     Do While not objRecordSet.EOF                 
	   strComputer = objRecordSet.Fields("name").Value
       Set objShell = CreateObject("WScript.Shell")
       strCommand = objShell.Run ("cmd /c msg * /server:" & strComputer & " " & strMessage,0,True)	   
	   If strCommand <> 0 Then
	      intNotSent = IntNotSent + 1
		  objShell.Popup strcomputer & " parece estar offline",2
	   Else
	      intSent = intSent + 1
		  objShell.Popup intSent & "/" & intComputermatch & " mensagens enviadas com sucesso para a rede, mas" & vbcr & "pelo menos " & intNotSent & " computadores estavam offline ou não" & vbcr & "existiam ou não puderam ser contactados.",1
	   End If
	   Set objShell = Nothing
       objRecordSet.MoveNext  
       Err.Clear   
     Loop  
     If intNotSent > 0 Then
	   wscript.echo intSent & " mensagens enviadas com sucesso para a rede, " & vbcr & "mas pelo menos " & intNotSent & " computadores estavam offline ou não" & vbcr & "existiam ou não puderam ser contactados."
	 Else 
	   wscript.echo intSent & " mensagens enviadas com sucesso para a rede."
	 End If
  End If   
  wscript.quit
  
Elseif instr(strComputer,":") then
  
  ' Rotina para ler um arquivo contendo uma lista de computadores
  Set objSA = CreateObject("Scripting.FileSystemObject")
  Const ForReading = 1
  intLines = 0
  Set objArquivoTexto = objSA.OpenTextFile(strComputer, ForReading)
  If Err.Number <> 0 then
     Wscript.echo "O arquivo especificado não existe. Tente novamente com um caminho correto para o arquivo. Saindo."
     Wscript.Quit
  End If
  strContent = ObjArquivoTexto.ReadAll
  intLines = Conta(strContent, chr(13), false)
  Redim strComputers(intLines+1)
  
  For intCounter = 1 to intLines
     strCall = GetLine(strContent, intCounter)
     strComputers(intCounter) = strCall
     Set objShell = WScript.CreateObject( "WScript.Shell" )
     strCommand = objShell.Run ("cmd /c msg * /server:" & strComputers(intCounter) & " " & strMessage,0,True)
     If strCommand <> 0 Then
	    intNotSent = IntNotSent + 1
		objShell.Popup strComputers(intCounter) & " parece estar offline",2
	 Else
	    intSent = intSent + 1
		objShell.Popup intSent &"/" & intLines & " mensagens enviadas com sucesso para a rede, mas" & vbcr & "pelo menos " & intNotSent & " computadores estavam offline ou não" & vbcr & "existiam ou não puderam ser contactados.",1
	 End If
	 Set objShell = Nothing
  Next
  If intNotSent > 0 Then
     Wscript.Echo intSent & " mensagens enviadas com sucesso para a rede, mas" & vbcr & "pelo menos " & intNotSent & " computadores estavam offline ou não " & vbcr & "existiam ou não puderam ser contactados."
  Else 
	 Wscript.Echo intSent & " mensagens enviadas com sucesso para a rede."
  End If
  Wscript.Quit
Else
  Set objShell = CreateObject("WScript.Shell")
  strCommand = objShell.Run("cmd /c msg * /server:" & strComputer & " " & strMessage,0,True)
  Set objShell = Nothing
  if strCommand <> 0 Then
     Wscript.Echo "O  computador  especificado  não existe  ou  pode  estar off-"  & vbcr & "line, ou  você  pode não ter privilégios suficientes para enviar" & vbcr & "uma mensagem para ele. Mensagem não enviada."
  else
	 Wscript.Echo "Mensagem enviada com sucesso!"
  End If
End If

wscript.quit

'----------------------------------------------------------------------------------------------------------------
' Functions
'----------------------------------------------------------------------------------------------------------------

Function GetLine(strbuffer, Line)

  Dim intEnd, strData, StrLine, IntLine

  StrLine = StrBuffer
  intEnd = InStr(strLine, Chr(13)) '  Pega a posição inicial do código ASCII 13 (ENTER)
  IntLine = 0
  Do  
  IntLine = IntLine + 1
  If intEnd > 0 Then    
     If IntLine = Line Then
        strLine = Left(strLine, intEnd-1)
        intEnd = InStr(strLine, Chr(13))
     Else
        StrLine = Mid(StrLine,IntEnd+2)
        intEnd = InStr(strLine, Chr(13))
     End If
  Else 
     strLine = strLine
  End If
  Loop While IntLine < Line

  GetLine = strLine

End Function

'--------------------------------------------------------------------------------------------------------------------

Function Conta(strText, strFind, fCaseSensitive)
    Dim intCount, intPos, intMode
    
    If Len(strFind) > 0 Then
        ' Configura o modo de comparação.
        If fCaseSensitive Then
            intMode = vbBinaryCompare
        Else
            intMode = vbTextCompare
        End If
        intPos = 1
        Do
           intPos = InStr(intPos, strText, strFind, intMode)
            If intPos > 0 Then
                intCount = intCount + 1
                intPos = intPos + Len(strFind)
            End If
        Loop While intPos > 0
    Else
        intCount = 0
    End If
    Conta = intCount+1
End Function

