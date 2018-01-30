Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

''''------------------------------------------ Declarations Section --------------------------------------------------''''
Set objFSO1 = CreateObject("Scripting.FileSystemObject")
INPUT_FOLDER = "C:\Users\mjohnson\Desktop\Capita DEV Reference\VBScripts\INPUT\"
OUTPUT_FOLDER = "C:\Users\mjohnson\Desktop\Capita DEV Reference\VBScripts\OUTPUT\Stripped\"

'''' System FileObjects To Recursively Traverse System Folders
Set objFSO_0 = CreateObject("Scripting.FileSystemObject")
Set objFSO_1 = CreateObject("Scripting.FileSystemObject")
Set objFSO_2 = CreateObject("Scripting.FileSystemObject")
Set objFSO_3 = CreateObject("Scripting.FileSystemObject")

''''------------------------------------------ Function\Subroutine Section ----------------------------------------------''''
Sub stripALLHTMLTags(strHTML)
  Set objRegExp = New Regexp
  objRegExp.IgnoreCase = True
  objRegExp.Global = True
  objRegExp.Pattern = "<(.|\n)+?>"

  'Replace all HTML tag matches with the empty string
  strOutput = objRegExp.Replace(strHTML, "")
  
  'Replace all < and > with &lt; and &gt;
  strOutput = Replace(strOutput, "<", "&lt;")
  strOutput = Replace(strOutput, ">", "&gt;")
  
  stripALLHTMLTags = strOutput    'Return the value of strOutput

  Set objRegExp = Nothing
End Sub

Function stripLine(strHTMLLine, objFile2)
	strippedString = ""
	
	foundP_INLINE = False
   	foundSPAN_INLINE = False
	foundSTYLE_INLINE = False
	
	'''' Strip out <p class=... In-line class Style ''''
	If InStr(strHTMLLine, "<p class=") > 0 Then
		foundP_INLINE = True
		  
		'''' Strip out <p class= ...''''  
		Set myRegExp_PClass = New RegExp
		myRegExp_PClass.IgnoreCase = True
		myRegExp_PClass.Global = True
		myRegExp_PClass.Pattern = "<p class=(.|\n)+?>"
		strippedString = myRegExp_PClass.Replace(strHTMLLine, "<p>")
		
		''WScript.Echo "HTML Line contained a <p class= ... Stripped HTML String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a <p class= ... Stripped HTML String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)

		If Not foundP_INLINE Then 
		Else 		
			strHTMLLine = strippedString
			foundP_INLINE = False
			strippedString = ""
		End If
	End If
	
	'''' Strip out <span class= ... In-line class Style ''''
	If InStr(strHTMLLine, "<span class=") > 0 Then
		foundSPAN_INLINE = True
	  
		'''' Strip out <span class= ... ''''  
		Set myRegExp_SpanClass = New RegExp
		myRegExp_SpanClass.IgnoreCase = True
		myRegExp_SpanClass.Global = True
		myRegExp_SpanClass.Pattern = "<span class=(.|\n)+?>"
		strippedString = myRegExp_SpanClass.Replace(strHTMLLine, "<span>")
		
		''WScript.Echo "HTML Line contained a <span class= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a <span class= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSPAN_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSPAN_INLINE = False
			strippedString = ""
		End If
	End If

	'''' Strip out <span style= ... In-line class Style ''''
	If InStr(strHTMLLine, "<span style=") > 0 Then
		foundSPAN_INLINE = True
	  
		'''' Strip out <span style= ...''''  
		Set myRegExp_SpanStyle = New RegExp
		myRegExp_SpanStyle.IgnoreCase = True
		myRegExp_SpanStyle.Global = True
		myRegExp_SpanStyle.Pattern = "<span style=(.|\n)+?>"
		strippedString = myRegExp_SpanStyle.Replace(strHTMLLine, "<span>")
		
		''WScript.Echo "HTML Line contained a <span style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a <span style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
	
		If Not foundSPAN_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSPAN_INLINE = False
			strippedString = ""
		End If
	End If
	
	'''' Strip out ...span style= ... In-line class Style ''''
	If InStr(strHTMLLine, "span style=") > 0 Then
		foundSPAN_INLINE = True
		
		'''' Strip out ...span style= ...''''  
		Set myRegExp_SpanStyle01 = New RegExp
		myRegExp_SpanStyle01.IgnoreCase = True
		myRegExp_SpanStyle01.Global = True
		myRegExp_SpanStyle01.Pattern = "span style=.+"
		strippedString = myRegExp_SpanStyle01.Replace(strHTMLLine, "span")
		
		''WScript.Echo "HTML Line contained a .+<span style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a .+<span style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSPAN_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSPAN_INLINE = False
			strippedString = ""
		End If
	End If
		
	'''' Strip out style= ... In-line class Style ''''
	If InStr(strHTMLLine, "style=") > 0 Then
		foundSTYLE_INLINE = True
	  
		'''' Strip out <span class= ... ''''  
		Set myRegExp_Style = New RegExp
		myRegExp_Style.IgnoreCase = True
		myRegExp_Style.Global = True
		myRegExp_Style.Pattern = "style=(.|\n)+?>"
		strippedString = myRegExp_Style.Replace(strHTMLLine, ">")
		
		''WScript.Echo "HTML Line contained a style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSTYLE_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSTYLE_INLINE = False
			strippedString = ""
		End If
	End If

	'''' Strip out style= ... In-line class Style ''''
	If InStr(strHTMLLine, "style=") > 0 Then
		foundSTYLE_INLINE = True
	  
		'''' Strip out <span class= ... ''''  
		Set myRegExp_Style_01 = New RegExp
		myRegExp_Style_01.IgnoreCase = True
		myRegExp_Style_01.Global = True
		myRegExp_Style_01.Pattern = "style=.*"
		strippedString = myRegExp_Style_01.Replace(strHTMLLine, "")
		
		''WScript.Echo "HTML Line contained a style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a style= ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSTYLE_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSTYLE_INLINE = False
			strippedString = ""
		End If
	End If
	
	'''' Strip out ...color:windowtext;text-decoration:none... In-line class Style ''''
	If InStr(strHTMLLine, "color:windowtext;text-decoration:none") > 0 Then
		foundSTYLE_INLINE = True
	  
		'''' Strip out <span class= ... ''''  
		Set myRegExp_Style_02 = New RegExp
		myRegExp_Style_02.IgnoreCase = True
		myRegExp_Style_02.Global = True
		myRegExp_Style_02.Pattern = "color:windowtext;text-decoration:none\'>(.|\n)+?"
		strippedString = myRegExp_Style_02.Replace(strHTMLLine, ">")
		
		''WScript.Echo "HTML Line contained a ...color:windowtext;text-decoration:none ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a ...color:windowtext;text-decoration:none ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSTYLE_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSTYLE_INLINE = False
			strippedString = ""
		End If
	End If	
		
	'''' Strip out ...display:none;text-decoration:none... In-line class Style ''''
	If InStr(strHTMLLine, "display:none;text-decoration:none") > 0 Then
		foundSTYLE_INLINE = True
	  
		'''' Strip out <span class= ... ''''  
		Set myRegExp_Style_03 = New RegExp
		myRegExp_Style_03.IgnoreCase = True
		myRegExp_Style_03.Global = True
		myRegExp_Style_03.Pattern = "display:none;text-decoration:none\'>(.|\n)+?"
		strippedString = myRegExp_Style_03.Replace(strHTMLLine, ">. ")
		
		''WScript.Echo "HTML Line contained a ...display:none;text-decoration:none ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a ...display:none;text-decoration:none ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSTYLE_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSTYLE_INLINE = False
			strippedString = ""
		End If
	End If	

	'''' Strip out ...text-decoration:none... In-line class Style ''''
	If InStr(strHTMLLine, "text-decoration:none") > 0 Then
		foundSTYLE_INLINE = True
	  
		'''' Strip out <span class= ... ''''  
		Set myRegExp_Style_04 = New RegExp
		myRegExp_Style_04.IgnoreCase = True
		myRegExp_Style_04.Global = True
		myRegExp_Style_04.Pattern = "text-decoration:none\'>(.|\n)+?"
		strippedString = myRegExp_Style_04.Replace(strHTMLLine, ">")
		
		''WScript.Echo "HTML Line contained a ...text-decoration:none ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf
		''objFile2.Write("HTML Line contained a ...text-decoration:none ... Stripped String Now: " & vbCrLf & strippedString & vbCrLf & vbCrLf)
		
		If Not foundSTYLE_INLINE Then 
		Else 
			strHTMLLine = strippedString
			foundSTYLE_INLINE = False
			strippedString = ""
		End If
	End If
	
	objFile2.Write(strHTMLLine & vbCrLf)
End Function

Sub StripNChomp(myFile)
	' Check if the Word document exists
	If objFSO_0.FileExists( myFile ) Then
        Set objFile = objFSO_0.GetFile( myFile )
        strFile = objFile.Path
		
		''''------------------------------------------ Create Output Files Section --------------------------------------------''''
		OUTPUT_FILE = OUTPUT_FOLDER & objFile.Name
		
		If objFSO_2.FileExists(OUTPUT_FILE) Then
			Set objFile2 = objFSO_3.OpenTextFile(OUTPUT_FILE, ForAppending)
		Else
			Set objFile2 = objFSO_3.CreateTextFile(OUTPUT_FILE, ForWriting, True)
		End If
	
		''objFile2.Write("------------------------------ " & objFile.Name & " ------------------------------" & vbCrLf)
    Else
        WScript.Echo "FILE OPEN ERROR: The file does not exist: " & strFile & vbCrLf & vbCrLf
       Exit Sub
    End If
	
	Set objTextFile = objFSO_1.OpenTextFile(strFile, ForReading)

	Do While objTextFile.AtEndOfStream <> True
		line = objtextFile.Readline

		''WScript.Echo "Original HTML Line: " & vbCrLf & line & vbCrLf & vbCrLf
		''objFile2.Write("Original HTML Line: " & vbCrLf & line & vbCrLf & vbCrLf)
		stripLine line,objFile2
	Loop

End Sub

Sub StripInLineStyle(folderPath)
	WScript.Echo "----- Initiate In-line Style Stripping from *.html files ---" & vbCrLf & folderPath & vbCrLf & vbCrLf
	'''' go thru each file in the folder ''''
	For Each file In objFSO_1.GetFolder(folderPath).Files

		'''' Retrieve the Word Document Folder-File Path ''''
		documentPath = file.Path 

		StripNChomp documentPath
	Next
end sub

''''------------------------------------------ Main Section ----------------------------------------------------------''''	
  StripInLineStyle INPUT_FOLDER

 ' Echo the job is completed
  WScript.Echo "Strip HTML File In-line Styles Successfully Completed!!!" & vbCrLf & vbCrLf
