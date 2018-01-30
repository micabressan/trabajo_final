Option Explicit
Dim wsh : Set wsh = CreateObject("WScript.Shell")

'環境変数の取得（プロセスのみ）
Dim envs
Set envs = wsh.Environment("PROCESS")

Dim list
Dim env
For Each env In envs
	list = list & env & vbCrLf
Next

'PATH 環境変数の一覧の表示
Dim pathes
pathes = Split(envs("PATH"),";")

'ソートのための構造体
Class EnvItem
	Public path
	Public length
End Class

Dim envItems()
Redim envItems(0)

Dim path
For Each path In pathes
	Redim Preserve envItems(UBound(envItems) + 1)
	Dim newEnvItem : Set newEnvItem = New EnvItem
	newEnvItem.path = path
	newEnvItem.length = Len(path)
	Set envItems(UBound(envItems)-1) = newEnvItem
Next
Redim Preserve envItems(Ubound(envItems) -1)

'Quick ソート
showEnvItems(envItems)
qsort(envItems)
showEnvItems(envItems)

Sub qsort(alist)
	
	Call qsort_sub(alist, LBound(alist), UBound(alist))

End Sub

Function getValue(env)
	getValue = env.length
End Function

Sub swapItem(first, second)
	Dim tempPath : tempPath = first.path
	Dim tempLength : tempLength = first.length
	first.path = second.path
	first.length = second.length
	second.path = tempPath
	second.length = tempLength
End Sub

Sub qsort_sub(targetlist, startpos, endpos)

	'WScript.Echo "qsort start" & startpos & " " & endpos
	
	'要素一個の場合はソート終了
	If startpos = endpos Then
		'WScript.Echo "要素1"
		Exit Sub
	End If
	
	'全て同じ値の場合はソート終了
	Dim grouped : grouped = true
	Dim firstValue : firstValue = getValue(targetlist(startpos))
	Dim secondValue : secondValue = getValue(targetlist(startpos + 1))
	Dim i 
	For i = (startpos + 1) to endpos
		If getValue(targetlist(i)) <> firstValue Then
			grouped = false
		End If
	Next
	If grouped = true Then
		Exit Sub
	End If
	
	'基準点は最初と次の要素のうち大きいほう
	Dim pivot
	If firstValue > secondValue Then
		pivot = firstValue
	Else
		pivot = secondValue
	End If
	
	Dim l : l = startpos
	Dim r : r = endpos
	Do While l < r
	
		'基準点以上の値を見つける
		Do While l <= endpos
			If (getValue(targetlist(l)) < pivot) Then
				l = l + 1
			Else
				Exit Do
			End If
		Loop
		
		'基準点未満の値を見つける
		Do While r >= startpos
			If (getValue(targetlist(r)) >= pivot) Then 
				r = r - 1
			Else
				Exit Do
			End If
		Loop

		If l >= r Then
			Exit Do
		End If
		
		'値の入れ替え
		Call swapItem(targetlist(l), targetlist(r))
		
		l = l + 1
		r = r - 1
		
	Loop
	
'WScript.Echo "l:" & l & " r:" & r
'showList(alist2)
	
	Call qsort_sub(targetlist, l, endpos)
	Call qsort_sub(targetlist, startpos , l-1)
	
End Sub

Sub showEnvItems(envItems)
	
	Dim result
	Dim i 
	For i = LBound(envItems) to UBound(envItems)
		result = result & envItems(i).path & " " & envItems(i).length & vbCrLf
	Next
	WScript.Echo result
End Sub

