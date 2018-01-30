Option Explicit
'ディレクトリをまるごと別の場所にコピーする
'（コピー元とコピー先はInputBoxで指定）
'# FileSysetmObject の CopyFolder 使わない"

Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")
Dim objCurDir : Set objCurDir = fso.GetFile(WScript.ScriptFullName)

'コピー元ディレクトリ
Dim srcDirPath : srcDirPath = InputBox("コピー元ディレクトリ（絶対パス）を指定してください")
If fso.FolderExists(srcDirPath) = False Then 
	MsgBox "コピー元ディレクトリが存在しません" & srcDirPath
	WScript.Quit
End If

'コピー先ディレクトリ
Dim srcDestPath : srcDestPath = InputBox("コピー先ディレクトリ（絶対パス）を指定してください")
If fso.FolderExists(srcDestPath) = False Then
	MsgBox "フォルダが存在しないので作成します " & vbCrLf & srcDestPath
	fso.CreateFolder(srcDestPath)
End If

copyDirectory fso.GetFolder(srcDirPath), fso.GetFolder(srcDestPath)

' objSrcDir の内容を objDestDir に再帰的にコピーする
' 引数は Folder オブジェクト
Sub copyDirectory(objSrcDir, objDestDir)

	'サブディレクトリに対する処理
	Dim subdir
	For Each subdir In objSrcDir.SubFolders
	
		'コピー先フォルダの作成
		Dim newDirPath : newDirPath= fso.BuildPath(objDestDir.Path, subdir.Name)
		'MsgBox newDirPath
		If fso.FolderExists(newDirPath) = True Then
			'存在しない場合はなにもしない
		Else
			'存在しない場合はフォルダ作成する
			fso.CreateFolder(newDirPath)
		End If
		
		'再帰呼び出し
		copyDirectory subdir, fso.GetFolder(newDirPath)
		
	Next
	
	'ディレクトリ内のファイルに対する処理
	Dim file
	For Each file In objSrcDir.Files
		file.Copy(objDestDir.Path & "\")
	Next
	
End Sub
WScript.Quit
