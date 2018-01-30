Option Explicit
Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")

Dim strTargetDirPath : strTargetDirPath = InputBox("検索ディレクトリを指定してください")
'Dim strTargetDirPath : strTargetDirPath = fso.GetParentFolderName(WScript.ScriptFullName)

If fso.FolderExists(strTargetDirPath) = False Then
	MsgBox "ディレクトリが存在しません"
	WScript.Quit
End If
Dim objTargetDir : Set objTargetDir = fso.GetFolder(strTargetDirPath)

'最新のファイル
Dim objRecentFile : Set objRecentFile = Nothing
'最新のファイルの更新日時
Dim dtmMostRecentFile
'比較対象となった全ファイル名
Dim allFileList
'検索対象ファイル数
Dim fileListSize : fileListSize = 0
'検索対象ファイル最大数
Dim maxFileListSize : maxFileListSize = 10

'main
findMostRecentFile(objTargetDir)
Msgbox "FileList : " & vbCr & _
allFileList & vbCr & vbCr & _
"Most Recent Modified File : " & vbCrLf &_
objRecentFile.Path & " " & objRecentFile.DateLastModified

'ディレクトリ内でもっとも更新日付の新しい File オブジェクトを返す関数
Sub findMostRecentFile(targetDir)

	'txt 拡張子ファイルを取得
	Dim file
	For Each file In targetDir.Files
		If LCase(fso.GetExtensionName(file.Name)) = "txt" Then
			allFileList = allFileList & file.Name & " " & file.DateLastModified & vbCrLf
			If file.DateLastModified > dtmMostRecentFile Then
				Set objRecentFile = file
				dtmMostRecentFile = file.DateLastModified
			End If
			fileListSize = fileListSize + 1
			If fileListSize >= maxFileListSize Then
				Exit Sub
			End If
		End If
	Next
	
	Dim folder
	For Each folder IN targetDir.SubFolders
		findMostRecentFile(folder)
		If fileListSize >= maxFileListSize Then
			Exit Sub
		End If
	Next
	
End Sub
