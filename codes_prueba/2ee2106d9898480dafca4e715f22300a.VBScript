Option Explicit

Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")
Dim wsh : Set wsh = CreateObject("WScript.Shell")
Dim reg : Set reg = New RegExp

'tasklist の実行
Dim objExec :Set objExec = wsh.Exec("tasklist")

'結果格納先
Dim memoryList()
Redim memoryList(0)
Dim processList()
Redim processlist(0)

'正規表現による必要な情報の切り出し
'smss.exe                    1260 Console                 0        464 K

reg.Pattern = "([\w\s]+.exe)\s+[0-9]+\s\w+\s+[0-9]+\s+([0-9,]+)\sK"
reg.IgnoreCase = true

Do Until objExec.Stdout.AtEndOfStream
	Dim line : line = objExec.StdOut.ReadLine()
	If reg.Test(line) = true Then
		
		' プロセス名の保存
		Redim Preserve processList(Ubound(processList) + 1)
		processList(Ubound(processList)) = reg.Replace(line,"$1")
		
		' メモリ使用量の保存
		Redim Preserve memoryList(Ubound(memoryList) + 1)
		memoryList(Ubound(memoryList)) = reg.Replace(line,"$2")
		
	End If
Loop

'最大使用量のインデックスを求める
Dim maxIndex : maxIndex = 1
Dim maxMemory : maxMemory = 0

Dim i
For i = 1 To Ubound(memoryList)
	
	If IsNumeric(memoryList(i)) <> true Then
		WSCript.Echo "数値ではありません" & memoryList(i)
		WScript.Quit
	End If
	
	Dim checkValue : checkValue = CLng(memoryList(i))
	If checkValue > maxMemory Then
		maxMemory = checkValue
		maxIndex = i
	End If
Next

WScript.Echo "最もメモリ使用量が大きいプロセスは " &  processList(maxIndex) & " (" & memoryList(maxIndex) & "K使用)です。"

