Option Explicit
Class Vector
	
	'データ(動的配列)
	Private m_data()
	'データ数
	Private m_dataCount
	
'Public
	
	' 要素追加
	Public Sub Add(value)
		If Ubound(m_data) < m_dataCount + 1 Then
			Call ExpandData()
		End If
		Call Bind(m_data(m_dataCount), value)
		m_dataCount = m_dataCount + 1
	End Sub
	
	' 要素取得
	' Default にすることで、"オブジェクト名(要素番号)"でアクセスできる
	Public Default Property Get Item(num)
		Call Bind(Item, m_data(num))
	End Property

	' 要素数取得
	Public Property Get Count
		Count = m_dataCount
	End Property
	
	' イテレータ取得
	Public Function Iterator()
		Dim ite : Set ite = New VectorIterator
		Set ite.Taget = Me
		Set Iterator = ite
	End Function
	
	' デバッグ用 文字列化メソッド
	Public Function ToString()
		Dim result
		Dim data
		For Each data in m_data
			If Not IsObject(data) Then
				result = result & data & " "
			Else
				'オブジェクトの場合は型表示のみ.
				result = result & TypeName(data) & " "
			End If
		Next
		ToString = result
	End Function
	
'Private

	'サイズ拡大
	Private Sub ExpandData
		Redim Preserve m_data(Ubound(m_data)*2 + 1)
	End Sub
	
	'コンストラクタ
	Private Sub Class_Initialize
		m_dataCount = 0
		Redim m_data(0)
	End Sub
	
	'オブジェクト設定用
	Private Sub Bind(var, val)
		If IsObject(val) = True then
			Set var = val
		Else
			var = val
		End If
	End Sub
End Class

'イテレータ
Class VectorIterator

	'参照するVector
	Private m_vector

	'Next で返す値のインデックス
	Private m_NextIndex
	
'Public

	'取得できる要素あるか
	Public Function HasNext()
		hasNext = (m_NextIndex < m_vector.Count)
	End Function
	
	'要素取得
	'Next は予約語だからかコンパイルエラーになるので GetNext
	Public Function GetNext()
		Call Bind(GetNext, m_vector(m_NextIndex))
		m_NextIndex = m_NextIndex + 1
	End Function
	
	' m_vector のプロパティ設定
	' コンストラクタ引数ないので..
	Public Property Set Taget(vector)
		Set m_vector = vector
	End Property
	
'Private	
	'コンストラクタ
	Private Sub VectorIterator_Initialize
		m_NextIndex = 0
	End Sub
	
	'オブジェクト設定用
	Private Sub Bind(var, val)
		If IsObject(val) = True then
			Set var = val
		Else
			var = val
		End If
	End Sub
End Class
