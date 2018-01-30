'Option Explicit
' vbsProcaine:Array v0.01
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

'-------------------------------------------------------------------
'FlipArray(arrSource)
' Reverses the order of an array, returns a reversed array
'-------------------------------------------------------------------
Function FlipArray(byRef arrSource)
	Dim arrFlipped 
	Dim sourceBound
	
	sourceBound = UBound(arrSource)
	
	ReDim arrFlipped(sourceBound)
	
	Dim i
	For i = sourceBound To 0 Step -1
		Dim varCell
		If (isObject(arrSource(i))) Then
			Set arrFlipped(sourceBound-i) = arrSource(i)
		Else
			arrFlipped(sourceBound-i) = arrSource(i)
		End If
	Next
	
	FlipArray = arrFlipped
End Function

' ------------------------------------------------------------------
' Push a value on the end of an array
' httpwww.vbforums.comarchiveindex.phpt-280636.html
' ------------------------------------------------------------------
Function Push(ByRef arrTarget, ByVal varValue)
	Dim intCounter
	Dim intElementCount

	ReDim Preserve arrTarget(UBound(arrTarget) + 1)
	
	If (isObject(varValue)) Then
		Set arrTarget(UBound(arrTarget)) = varValue
	Else
		arrTarget(UBound(arrTarget)) = varValue
	End If

	Push = arrTarget
End Function

' ------------------------------------------------------------------
Function Merge( ByRef arrHead, ByVal arrTail)
	Dim intHeadCount
	
	' Set ubound value once only
	intHeadCount = UBound(arrHead)
	ReDim Preserve arrHead(intHeadCount + UBound(arrTail) + 1)

	' Using for...next is more efficient & quicker than for..each
	Dim i
	For i = 0 to UBound(arrTail)
		If (isObject(arrTail(i))) Then
			Set arrHead(intHeadCount + i + 1) = arrTail(i)
		Else
			arrHead(intHeadCount + i + 1) = arrTail(i)
		End If
	Next
	
	Merge = arrHead
End Function

'---------------------------------------------------------------------
'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'Tests

'test()

' ------------------------------------------------------------------
Function test()
	testFlipArraySimple()
	testFlipArrayObject()
	testMergeSimple()
	testMergeObject()
	testPushSimple()
	testPushObject()
	'testFlipArrayNull()
End Function

' ------------------------------------------------------------------
Function testPushSimple()
	
	WScript.echo "testPushSimple"

	Dim arrTarget,varVal,arrFinish
	Dim item
	
	arrTarget = Array(1,2)
	varVal = 3
	
	For Each item in arrTarget
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
	
	WScript.echo varVal
	
	WScript.echo VbCrLf
	
	arrFinish = Push(arrTarget,varVal)
	
	For Each item in arrFinish
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
End Function

' ------------------------------------------------------------------
Function testPushObject()
	
	WScript.echo "testPushObject"

	Dim arrTarget,varVal,arrFinish
	Dim thing1,thing2,thing3
	Dim item
	
	Set thing1 = WScript.CreateObject("Scripting.Dictionary")
	Set thing2 = WScript.CreateObject("Scripting.Dictionary")
	Set thing3 = WScript.CreateObject("Scripting.Dictionary")
	
	arrTarget = Array(thing1,thing2)
	Set varVal = thing3
	
	For Each item in arrTarget
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
	
	WScript.echo varVal.count
	
	WScript.echo VbCrLf
	
	arrFinish = Push(arrTarget,varVal)
	
	For Each item in arrFinish
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
End Function

' ------------------------------------------------------------------
Function testMergeSimple()

	WScript.echo "testMergeSimple"

	Dim arrHead,arrTail,arrFinish
	Dim item
	
	arrHead = Array(1,2)
	arrTail = Array(3,4)
	
	For Each item in arrHead
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
	
	For Each item in arrTail
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
	
	arrFinish = Merge(arrHead,arrTail)
	
	For Each item in arrFinish
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
End Function

' ------------------------------------------------------------------
Function testMergeObject()

	WScript.echo "testMergeObject"

	Dim thing1,thing2,thing3,thing4
	Dim arrHead,arrTail,arrFinish
	Dim item
	
	Set thing1 = WScript.CreateObject("Scripting.Dictionary")
	Set thing2 = WScript.CreateObject("Scripting.Dictionary")
	Set thing3 = WScript.CreateObject("Scripting.Dictionary")
	Set thing4 = WScript.CreateObject("Scripting.Dictionary")
	
	arrHead = Array(thing1,thing2)
	arrTail = Array(thing3,thing4)
	
	For Each item in arrHead
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
	
	For Each item in arrTail
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
	
	arrFinish = Merge(arrHead,arrTail)
	
	For Each item in arrFinish
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
End Function

' ------------------------------------------------------------------
Function testFlipArrayNull()

	WScript.echo "testFlipArrayNull"

	Dim arrStart,arrFinish
	Dim item
	
	arrStart = null
	
	arrFinish = FlipArray(arrStart)
	
	For Each item in arrStart
		WScript.echo item
	Next
	
	For Each item in arrFinish
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
End Function

' ------------------------------------------------------------------
Function testFlipArraySimple()

	WScript.echo "testFlipArraySimple"

	Dim arrStart,arrFinish
	Dim item
	
	arrStart = array(1,2,3,4)
	
	arrFinish = FlipArray(arrStart)
	
	For Each item in arrStart
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
	
	For Each item in arrFinish
		WScript.echo item
	Next
	
	WScript.echo VbCrLf
End Function

' ------------------------------------------------------------------
Function testFlipArrayObject()

	WScript.echo "testFlipArrayObject"

	Dim arrStart,arrFinish
	Dim thing1,thing2,thing3
	Dim item
	
	Set thing1 = WScript.CreateObject("Scripting.Dictionary")
	Set thing2 = WScript.CreateObject("Scripting.Dictionary")
	Set thing3 = WScript.CreateObject("Scripting.Dictionary")
	
	arrStart = array(thing1,thing2,thing3)
	
	arrFinish = FlipArray(arrStart)

	
	For Each item in arrStart
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
	
	For Each item in arrFinish
		WScript.echo item.count
	Next
	
	WScript.echo VbCrLf
End Function