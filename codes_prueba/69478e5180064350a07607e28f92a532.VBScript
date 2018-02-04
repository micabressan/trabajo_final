'Option Explicit
' vbsProcaine:concurrent v0.01
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
Class Lock
	Dim strLockFileLocation
	Dim objLockFile
	Dim fso
	
	Function init(strLockFileLocation)
		Me.strLockFileLocation = strLockFileLocation
		Set fso = CreateObject("Scripting.FileSystemObject")
		Set init = Me
	End Function
	
	Function unlock()
		
		If (isObject(objLockFile)) Then
			objLockFile.close()
			If (isLocked()) Then
				fso.DeleteFile(strLockFileLocation)
			End If
		End If
		
	End Function
	
	Function tryLock()
		If (isLocked()) Then
			tryLock = false
		Else
			Set objLockFile = fso.createTextFile( strLockFileLocation, False )
			tryLock = true
		End If
	End Function
	
	Function lock()

		While not tryLock()
			WScript.Sleep 100
		Wend

	End Function
	
	Private Function isLocked()
		isLocked = fso.FileExists(strLockFileLocation)
	End Function
	
	Sub Class_Terminate()
		If (isObject(objLockFile)) Then
			objLockFile.close()
		End If
	End Sub
	
End Class

'!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
'Tests

test()

Function test()

	Dim myLock
	Set myLock= new Lock.init("mine.lck")
	myLock.lock()
	WScript.echo "woo"
	WScript.sleep 5000
	myLock.unlock()
	
End Function