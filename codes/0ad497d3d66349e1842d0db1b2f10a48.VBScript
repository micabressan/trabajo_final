'修正.
'include に該当 Vector クラス
Dim fso : Set fso = CreateObject("Scripting.FileSystemObject")
ExecuteGlobal fso.OpenTextFile("./17.Vector.vbs").ReadAll

' Test ------------------

'1.数値を詰める
Dim data : Set data = New Vector
Dim i
For i = 10 to 15
	data.Add(i)
Next
WScript.Echo data.ToString() ' => 10 11 12 13 14 15
WScript.Echo data.Item(0) ' => 10
WScript.Echo data(3) ' => 13

'2.オブジェクトを詰める
'多次元 Vector
Dim data1 : Set data1 = New Vector
Dim data_sub1 : Set data_sub1 = New Vector
Dim data_sub2 : Set data_sub2 = New Vector
data1.Add(data_sub1)
data1.Add(data_sub2)
data1(0).Add(3)
data1(0).Add(4)
data1(1).Add(1)
data1(1).Add(2)
WScript.Echo data1.ToString() '=> Vector Vector
WScript.Echo data1(0).ToString() '=> 3 4
WScript.Echo data1(1).ToString() '=> 1 2
WScript.Echo data1(0)(0) ' => 3
WScript.Echo data1(1)(1) ' => 2

'3.イテレータでまわす
Dim ite : Set ite = data.Iterator()
Do While ite.HasNext()
	WScript.Echo ite.GetNext()
Loop
'=> 10
'   11
'   12
'   13
'   14
'   15
