'Option Explicit
' vbsProcaine:Util v0.01
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

'---------------------------------------------------------------------------------
' Warning, this implementation is very slow due to the & concatenation which
' is remarkably inefficient in vbs. Do not use for arrays larger than 100 items
' @TODO: change string concat to push-join
'---------------------------------------------------------------------------------
Function cStrR(varTarget)
	Dim strRetval
	strRetval = ""


	If (IsEmpty(varTarget)) Then
		strRetval = "@E"
	ElseIf (IsNull(varTarget)) Then
		strRetval = "@N"
	ElseIf (VarType(varTarget) <= 7) Then
		strRetval = Cstr(varTarget) 
	ElseIf (VarType(varTarget) = 8) Then
		strRetval = """" & varTarget & """"
	ElseIf (VarType(varTarget) <= 10) Then
		strRetval = "@Object"
	ElseIf (VarType(varTarget) = 11) Then
		strRetval = Cstr(varTarget)
	ElseIf (VarType(varTarget) <= 13) Then
		strRetval = "@Object"
	ElseIf (VarType(varTarget) <= 17) Then
		strRetval = Cstr(varTarget)
	ElseIf (VarType(varTarget) >= 8192) Then 'Array
		Dim varInner
		strRetval = strRetval & "["
		For Each varInner in varTarget
			strRetval = strRetval & cStrR(varInner) & " " 'Recursive call
		Next
		strRetval = strRetval & "]" 
	Else
		strRetval = "@?"
	End If

	cStrR = strRetval
End Function

'---------------------------------------------------------------------------------
Function typeNameR(varTarget)
	Dim strRetval
	strRetval = ""

	If (IsEmpty(varTarget)) Then
		strRetval = "#E"
	ElseIf (IsNull(varTarget)) Then
		strRetval = "#N"
	ElseIf (VarType(varTarget) <= 17) Then
		strRetval = TypeName(varTarget)
	ElseIf (VarType(varTarget) >= 8192) Then ' If Array
		Dim varInner
		strRetval = strRetval & "Array["
		For Each varInner in varTarget
			strRetval = strRetval & typeNameR(varInner) & " " 'Recursive call
		Next
		strRetval = strRetval & "]" 
	Else
		strRetval = "#?"
	End If

	typeNameR = strRetval
End Function

'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'test()

Function test()
	Dim foo , bar
	Dim thing1, thing2
	
	Set thing1 = WScript.CreateObject("Scripting.Dictionary")
	Set thing2 = CreateObject("Microsoft.Update.Session")
	
	foo = Array("f","o","o",thing1)
	bar = Array("b","a","r",thing2)
	
	ReDim Preserve bar(5)
	
	foo(0) = bar
	bar(0) = foo
	
	WScript.echo cStrR(foo)
	WScript.echo typeNameR(foo)
	Wscript.echo VbCrLf
	WScript.echo cStrR(bar)
	WScript.echo typeNameR(bar)
End Function