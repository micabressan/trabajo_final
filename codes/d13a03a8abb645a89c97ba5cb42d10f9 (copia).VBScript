'Option Explicit
' vbsProcaine:Exception v0.01
'    Copyright (C) 2011  Anton Vattay
'
'    This program is free software: you can redistribute it and/or modify
'    it under the terms of the GNU General Public License as published by
'    the Free Software Foundation, either version 3 of the License, or
'    (at your option) any later version.
'
'    This program is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'    GNU General Public License for more details.
'
'    You should have received a copy of the GNU General Public License
'    along with this program.  If not, see <http://www.gnu.org/licenses/>.

'===============================================================================
'===============================================================================
' Error Handling ---------------------------------------------------------------
' This section supports try-catch&throw functionality in vbscript.
' You should only surround one exception throwing command with this
' construct, otherwise you might lose the error.
' The usage idiom for a tr-catch-throw is:
' On Error Resume Next 'try
' 	... 'code that could throw exception
' Set Ex = e.catch() 'catch
' On Error GoTo 0 'catch part two
' If (Ex = <some_err_num>) Then
' 	... 'Handle error
'	Set newEx = New ErrWrap.initExM(<somenum>,"<source>", "<description>", Ex)'
'	e.preRaise(newEx)
'	Err.Raise newEx.number, newEx.source, newEx.description
' End If

' Note that code called within an error handler that re-throws (using Err.raise)
' must be "exception raise safe" all the way up the call chain.
' If your called function has an "On Error..." statement in it, that will reset
' The global Err object, thereby losing the exception the code was handling. When
' The raise is called at the end of the handling to re-throw, it will throw an
' "non-error" Err object with code 0, which will then slip by any upstream
' error handlers. A nightmare to debug if it happens.

' Another nightmare to avoid. Never have a class destructor that calls code
' with a try-catch emulator if the constructor has code that could throw an
' exception. If a vb class constructor fails the destructor will be called
' immediatly. If your destructor calls something that uses this try catch,
' that try catch will intercept the exception intended for the contructors 
' caller, leading to a nightmare.

Class ErrWrap
	Private pNumber
	Private pSource
	Private pDescription
	Private pHelpContext
	Private pHelpFile
	Private objReasonEx
	
	Public Function catch()
		init()		
		objReasonEx = NULL
		Set catch = Me
	End Function
	
	Public Function init()
		pNumber = Err.Number
		pSource = Err.Source
		pDescription = Err.Description
		pHelpContext = Err.HelpContext
		pHelpFile = Err.HelpFile
		objReasonEx = NULL
		Set init = Me
	End Function
	
	Public Function initM(intCode, strSource, strDescription)
		pNumber = intCode
		pSource = strSource
		pDescription = strDescription
		pHelpContext = ""
		pHelpFile = ""		
		Set initM = Me
	End Function
	
	Public Function initExM(intCode, strSource, strDescription, objEx)
		pNumber = intCode
		pSource = strSource
		pDescription = strDescription
		pHelpContext = ""
		pHelpFile = ""		
		Set objReasonEx = objEx
		Set initExM = Me
	End Function
	
	Public Function initEx(objEx)
		pNumber = Err.Number
		pSource = Err.Source
		pDescription = Err.Description
		pHelpContext = Err.HelpContext
		pHelpFile = Err.HelpFile
		Set objReasonEx = objEx
		Set initEx = Me
	End Function
	
	Public Function getReason() 'returns objEx
		If NOT isObject(objReasonEx) Then
			getReason = NULL
		Else
			Set getReason = objReasonEx
		End If
	End Function
	
	Public Function toString() 'returns string
		toString = ""
		toString = "ExNum:[" & pNumber & " : 0x" & hex(pNumber) & "] " & VbCrLf & _
			"ExSource: " & pSource & VbCrLf & _
			"ExDescription: " & pDescription & VbCrLf
	End Function
	
	Public Default Property Get Number
		Number = pNumber
	End Property
	
	Public Property Get Source
		Source = pSource
	End Property
	
	Public Property Get Description
		Description = pDescription
	End Property
	
	Public Property Get HelpContext
		HelpContext = pHelpContextl
	End Property
	
	Public Property Get HelpFile
		HelpFile = HelpFile
	End Property
	
End Class

'===============================================================================
'===============================================================================
' Usage: declare this at the glocal scope.
Class ExceptionManager
	Dim currentEx
	
	Function init()
		currentEx = NULL
		Set init = Me
	End Function
	
	Function catch()
		If ( isNull(currentEx) ) Then
			If ( Err.number <> 0 ) Then
				Set currentEx = New ErrWrap.catch()
			End If
		Else
			If (Err.number <> currentEx.number) Then
				'Exception mismatch, when the current exception
				'does not match the last recorded currentEx.
				'Happens when an exception is thrown in an 
				'exception handlerl
				If ( Err.number <> 0 ) Then
					Set currentEx = New ErrWrap.initEx(currentEx)
				End IF
			End If
			catch = true
		End If
		
	End Function
	
	Function isException()
		isException = true
		If NOT ( isObject(currentEx) )Then
			isException = false
		End If
	End Function
	
	Function getException()
		Set getException = currentEx
		currentEx = NULL
	End Function
	
	' Do not use if you care about localizing the line number of the error
	' This function will set the error line to the Raise called within
	Function throw(objEx)
		Set currentEx = objEx
		Err.Raise currentEx.number, currentEx.Source, currentEx.Description
	End Function
	
	Function preRaise(objEx)
		Set currentEx = objEx
		Set preRaise = currentEx
	End Function
	
	Function dump(objEx)
		dump = ""
		If NOT (isObject(objEx.getReason)) Then
			dump = objEx.toString() & VbCrLf
		Else
			dump = dump(objEx.getReason) & objEx.toString() & VbCrLf
		End If
	End Function
End Class

'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'Tests

Dim e

Set e = New ExceptionManager.init()

test()

Function test()

	WScript.echo "Starting"
	
	Dim testEx
	Dim testEx2

	
	On Error Resume Next
		a()
	e.Catch()
	On Error GoTo 0
	If ( e.isException() ) Then
		Dim Ex
		Set Ex = e.getException()
		WScript.echo e.dump(Ex)
	End If	
	WScript.echo "Finishing"
End Function

Function c()
	intA = 5/0
End Function

Function fail()
	inta = 5 + "asdf"
End Function

Function a()
	WScript.echo "Doing a"
	dim intA
	On Error Resume Next
		b()
	e.catch()
	On Error GoTo 0
	If ( e.isException() ) Then
		Dim Ex
		Set Ex = e.getException()
		Dim newEx
		WScript.echo "caught exception from b()"
		'Set newEx = New ErrWrap.initExM(10001,"a()", "call to b() failed", Ex)
		'e.preRaise(newEx)
		'Set newEx = New ErrWrap.initExM(10001,"a()", "call to b() failed", Ex)
		Set newEx = e.preRaise( New ErrWrap.initExM(10001,"a()", "call to b() failed", Ex) )
		Err.Raise newEx.number, newEx.source, newEx.description
	End If
End Function

Function b()
	WScript.echo "Doing b"
	dim intA
	On Error Resume Next
		c()
	e.Catch()
	On Error GoTo 0
	If ( e.isException() ) Then
		Dim Ex
		Set Ex = e.getException()
		log()
		Dim newEx
		WScript.echo "caught exception from c()"
		Set newEx = e.preRaise( New ErrWrap.initExM(10002,"b()", "call to c() failed", Ex) )
		Err.Raise newEx.number, newEx.source, newEx.description
	End If
End Function

Function log()
	WScript.echo "start log"
	On Error Resume Next
		fail()
	e.Catch()
	On Error GoTo 0
	If ( e.isException() ) Then
		Dim Ex
		Set Ex = e.getException()
		Dim newEx
		WScript.echo "caught exception from fail()"
		Set newEx = e.preRaise( New ErrWrap.initExM(10002,"log()", "call to fail() failed", Ex) )
		Err.Raise newEx.number, newEx.source, newEx.description
	End If
	WScript.echo "endlog"
End Function