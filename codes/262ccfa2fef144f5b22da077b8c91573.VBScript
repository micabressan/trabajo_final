'vbscript-campfire.vbs
'080727 - busse - the bare minimum to login, enter a room, post up a message
'
' USAGE:
'
' vbscript campfire [http|https] [account] [email username] [password] [room-id] [message]
'
' ###

varProtocol = WScript.Arguments.Item(0)
varAccount = WScript.Arguments.Item(1)
varEmail = WScript.Arguments.Item(2)
varPassword = WScript.Arguments.Item(3)
varRoom = WScript.Arguments.Item(4)
varMsg = WScript.Arguments.Item(5)

'login
Dim objSvrHTTP
Set objSvrHTTP = CreateObject("Msxml2.ServerXMLHTTP.3.0") 

objSvrHTTP.open "POST", varProtocol & "://" & varAccount & ".campfirenow.com/login?email_address=" & varEmail & "&password=" & varPassword, false
 
objSvrHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded" 
objSvrHTTP.send
objSvrHTTP.waitForResponse

'enter room

objSvrHTTP.open "GET", varProtocol & "://" & varAccount & ".campfirenow.com/room/" & varRoom, false
 
objSvrHTTP.send
objSvrHTTP.waitForResponse

objSvrHTTP.open "POST", varProtocol & "://" & varAccount & ".campfirenow.com/room/" & varRoom & "/speak?message=" & varMsg, false
 
'say it

objSvrHTTP.setRequestHeader "Content-Type", "application/x-www-form-urlencoded" 

objSvrHTTP.send
objSvrHTTP.waitForResponse

Set objSvrHTTP = Nothing

