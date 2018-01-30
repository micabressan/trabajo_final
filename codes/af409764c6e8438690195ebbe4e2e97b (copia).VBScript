Const ForReading = 1
Const ForWriting = 2
Const ForAppending = 8

''''------------------------------------------ Declarations Section --------------------------------------------------''''
Set objFSO1 = CreateObject("Scripting.FileSystemObject")
INPUT_FOLDER = "C:\Documentation\Technology\Technology - Scripts\VBScripts\INPUT\"
OUTPUT_FOLDER = "C:\Documentation\Technology\Technology - Scripts\VBScripts\OUTPUT\"

INPUT_FILE_01 = "List for Indiana.docx"
OUTPUT_FILE_01 = "StrippedDocument.txt"

'''' System FileObjects To Recursively Traverse System Folders
Set objFSO_0 = CreateObject("Scripting.FileSystemObject")
Set objFSO_1 = CreateObject("Scripting.FileSystemObject")
Set objFSO_2 = CreateObject("Scripting.FileSystemObject")
Set objFSO_3 = CreateObject("Scripting.FileSystemObject")

'''' Create an invisible version of Microsoft Word
Set objWord = CreateObject("Word.Application") 

'''' Don't display any messages about documents needing to be converted
objWord.DisplayAlerts = 0

''''------------------------------------------ Create Output Logfiles Section --------------------------------------------''''
''''------------------------------------------ Create Output Logfiles Section --------------------------------------------''''
If objFSO_2.FileExists(OUTPUT_FILE_01) Then
	Set objFile2 = objFSO_3.OpenTextFile(OUTPUT_FILE_01, ForAppending)
Else
	Set objFile2 = objFSO_3.CreateTextFile(OUTPUT_FILE_01, ForWriting, True)
End If

''''------------------------------------------ Function\Subroutine Section ----------------------------------------------''''
Sub RecurseFolders(sPath, funcName)
	WScript.Echo "----- Initiate system folder recursion ---" & vbCrLf & sPath & vbCrLf & vbCrLf
	With objFSO_0.GetFolder(sPath)
		If .SubFolders.Count > 0 Then
			For Each folder in .SubFolders
				' Perform function's operation
				Execute funcName & " " & chr(34) & folder.Path & chr(34)
				
				' Recurse to check for further subfolders
				RecurseFolders folder.Path, funcName
			Next
		Else
		End If
	End With
End Sub

Sub Doc2HTML( myFile )
' This subroutine opens a Word document,
' then saves it as HTML, and closes Word.
' If the HTML file exists, it is overwritten.
' If Word was already active, the subroutine
' will leave the other document(s) alone and
' close only its "own" document.
'
' Written by Rob van der Woude
' http://www.robvanderwoude.com
    ' Standard housekeeping
    Dim objDoc, objFile, objFSO, objWord, strFile, strHTML

    Const wdFormatDocument                    =  0
    Const wdFormatDocument97                  =  0
    Const wdFormatDocumentDefault             = 16
    Const wdFormatDOSText                     =  4
    Const wdFormatDOSTextLineBreaks           =  5
    Const wdFormatEncodedText                 =  7
    Const wdFormatFilteredHTML                = 10
    Const wdFormatFlatXML                     = 19
    Const wdFormatFlatXMLMacroEnabled         = 20
    Const wdFormatFlatXMLTemplate             = 21
    Const wdFormatFlatXMLTemplateMacroEnabled = 22
    Const wdFormatHTML                        =  8
    Const wdFormatPDF                         = 17
    Const wdFormatRTF                         =  6
    Const wdFormatTemplate                    =  1
    Const wdFormatTemplate97                  =  1
    Const wdFormatText                        =  2
    Const wdFormatTextLineBreaks              =  3
    Const wdFormatUnicodeText                 =  7
    Const wdFormatWebArchive                  =  9
    Const wdFormatXML                         = 11
    Const wdFormatXMLDocument                 = 12
    Const wdFormatXMLDocumentMacroEnabled     = 13
    Const wdFormatXMLTemplate                 = 14
    Const wdFormatXMLTemplateMacroEnabled     = 15
    Const wdFormatXPS                         = 18
    Const wdFormatOfficeDocumentTemplate      = 23
    Const wdFormatMediaWiki                   = 24

    ' Create a File System object
    Set objFSO = CreateObject( "Scripting.FileSystemObject" )

    ' Create a Word object
    Set objWord = CreateObject( "Word.Application" )

    With objWord
        ' True: make Word visible; False: invisible
        .Visible = True

        ' Check if the Word document exists
        If objFSO.FileExists( myFile ) Then
            Set objFile = objFSO.GetFile( myFile )
            strFile = objFile.Path
        Else
            WScript.Echo "FILE OPEN ERROR: The file does not exist" & vbCrLf & vbCrLf
            ' Close Word
            .Quit
            Exit Sub
        End If
        ' Build the fully qualified HTML file name
        strHTML = objFSO.BuildPath( objFile.ParentFolder, _
                  objFSO.GetBaseName( objFile ) & ".html" )

        ' Open the Word document
        .Documents.Open strFile

        ' Make the opened file the active document
        Set objDoc = .ActiveDocument

        ' Save as HTML
        objDoc.SaveAs strHTML, wdFormatFilteredHTML

        ' Close the active document
        objDoc.Close

        ' Close Word
        .Quit
    End With
End Sub

Sub Doc2PDF( myFile )
' This subroutine opens a Word document, then saves it as PDF, and closes Word.
' If the PDF file exists, it is overwritten.
' If Word was already active, the subroutine will leave the other document(s)
' alone and close only its "own" document.
'
' Requirements:
' This script requires the "Microsoft Save as PDF or XPS Add-in for 2007
' Microsoft Office programs", available at:
' http://www.microsoft.com/downloads/details.aspx?
'        familyid=4D951911-3E7E-4AE6-B059-A2E79ED87041&displaylang=en
'
' Written by Rob van der Woude
' http://www.robvanderwoude.com

    ' Standard housekeeping
    Dim objDoc, objFile, objFSO, objWord, strFile, strPDF

    Const wdFormatDocument                    =  0
    Const wdFormatDocument97                  =  0
    Const wdFormatDocumentDefault             = 16
    Const wdFormatDOSText                     =  4
    Const wdFormatDOSTextLineBreaks           =  5
    Const wdFormatEncodedText                 =  7
    Const wdFormatFilteredHTML                = 10
    Const wdFormatFlatXML                     = 19
    Const wdFormatFlatXMLMacroEnabled         = 20
    Const wdFormatFlatXMLTemplate             = 21
    Const wdFormatFlatXMLTemplateMacroEnabled = 22
    Const wdFormatHTML                        =  8
    Const wdFormatPDF                         = 17
    Const wdFormatRTF                         =  6
    Const wdFormatTemplate                    =  1
    Const wdFormatTemplate97                  =  1
    Const wdFormatText                        =  2
    Const wdFormatTextLineBreaks              =  3
    Const wdFormatUnicodeText                 =  7
    Const wdFormatWebArchive                  =  9
    Const wdFormatXML                         = 11
    Const wdFormatXMLDocument                 = 12
    Const wdFormatXMLDocumentMacroEnabled     = 13
    Const wdFormatXMLTemplate                 = 14
    Const wdFormatXMLTemplateMacroEnabled     = 15
    Const wdFormatXPS                         = 18
    Const wdFormatOfficeDocumentTemplate      = 23
    Const wdFormatMediaWiki                   = 24

    ' Create a File System object
    Set objFSO = CreateObject( "Scripting.FileSystemObject" )

    ' Create a Word object
    Set objWord = CreateObject( "Word.Application" )

    With objWord
        ' True: make Word visible; False: invisible
        .Visible = True

        ' Check if the Word document exists
        If objFSO.FileExists( myFile ) Then
            Set objFile = objFSO.GetFile( myFile )
            strFile = objFile.Path
        Else
            WScript.Echo "FILE OPEN ERROR: The file does not exist" & vbCrLf & vbCrLf
            ' Close Word
            .Quit
            Exit Sub
        End If

        ' Build the fully qualified HTML file name
        strPDF = objFSO.BuildPath( objFile.ParentFolder, _
                 objFSO.GetBaseName( objFile ) & ".pdf" )

        ' Open the Word document
        .Documents.Open strFile

        ' Make the opened file the active document
        Set objDoc = .ActiveDocument

        ' Save as HTML
        objDoc.SaveAs strPDF, wdFormatPDF

        ' Close the active document
        objDoc.Close

        ' Close Word
        .Quit
    End With
End Sub

Sub ConvertWordDoc(folderPath)
	WScript.Echo "----- Initiate text extraction from Microsoft Word Document ---" & vbCrLf & folderPath & vbCrLf & vbCrLf
	'''' go thru each file in the folder ''''
	For Each file In objFSO_1.GetFolder(folderPath).Files

		'''' Retrieve the Word Document Folder-File Path ''''
		documentPath = file.Path 
		
		WScript.Echo "Extract and convert Data from document: " & documentPath & vbCrLf & vbCrLf

		Doc2HTML documentPath
	Next
end sub

''''------------------------------------------ Main Section ----------------------------------------------------------''''	
' Call the RecurseFolders routine with name of function to be performed
' RecurseFolders INPUT_FOLDER, "ConvertWordDoc"

  ConvertWordDoc INPUT_FOLDER

 ' Echo the job is completed
  WScript.Echo "Conversion Successfully Completed!!!" & vbCrLf & vbCrLf
