Graphics 600, 600

Local myImage : TImage = LoadImage("Content/ball.png")
	
Repeat
	Cls

	For i : Int = 1 To 3000
		DrawImage myImage, 0, 0

	Next
	
	FPS.DrawFPS()
	
	Flip 0
	
Until AppTerminate()

Type FPS
	Global Counter : Int
	Global Time : Int
	Global TFPS : Int
	Function Calc : Int()
		Counter = Counter + 1
		If Time < MilliSecs()
			TFPS = Counter ' <-Frames/Sec
			Time = MilliSecs() + 1000 'Update
			Counter = 0
		EndIf
		Return TFPS
	EndFunction
	
	Function DrawFPS()
		DrawText "FPS = " + FPS.Calc(), 0, 0
	EndFunction
EndType