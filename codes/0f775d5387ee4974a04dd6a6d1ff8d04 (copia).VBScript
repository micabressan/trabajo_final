Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile("C:\Windows Scripts\INPUT\VinmakeModel.csv", 1)

URLPath_PREFIX = "<a href=""http://www.vinlink.com/secured/report.action?requestor.vin="
URLPath_BODY = "&requestor.type=recall&doRequest=Request+report"">"
URLPath_SUFFIX = "</a><br>"

Set objExplorer = CreateObject("InternetExplorer.Application")
objExplorer.Navigate "about:blank" 
objExplorer.ToolBar = 0 
objExplorer.StatusBar = 0 
objExplorer.Width = 800 
objExplorer.Height = 570 
objExplorer.Left = 0 
objExplorer.Top = 0 
objExplorer.Visible = 1 

Do While (objExplorer.Busy) 
Loop 

Set objDocument = objExplorer.Document 
objDocument.Open 
objDocument.Writeln "<html><head><title>Service Status</title></head>" 
objDocument.Writeln "<body bgcolor='white'>" 
objDocument.Writeln "<table width='100%'><pre>" 
objDocument.Writeln "<tr><pre>" 
objDocument.Writeln "<td width='50%'><b>VIN Number</b></td><pre>" 
objDocument.Writeln "<td width='50%'><b>Validation Link</b></td><pre>" 
objDocument.Writeln "</tr><pre>"

Do Until objFile.AtEndOfStream 
    strLine = objFile.ReadLine
	arrVINRecord = split(strLine, ",")
	vinPREFIX = arrVINRecord(0)
    vinFULLDESIGNATION = arrVINRecord(1)

    objDocument.Writeln "<tr><pre>" 
    objDocument.Writeln "<td width='50%'>" & vinFULLDESIGNATION & "</td><pre>" 
    objDocument.writeln "<td width='50%'>" & URLPath_PREFIX & vinFULLDESIGNATION & URLPath_BODY & vinFULLDESIGNATION & URLPath_SUFFIX & "</td><pre>" 
    objDocument.Writeln "</tr><pre>" 
Loop

objFile.Close

objDocument.Writeln "</table>" 
objDocument.Writeln "</body></html>" 
objDocument.Write() 
objDocument.Close 

