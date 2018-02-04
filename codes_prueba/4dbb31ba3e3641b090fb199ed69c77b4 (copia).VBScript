Const ForReading = 1
Const ForWriting = 2

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile("C:\Windows Scripts\INPUT\VinmakeModel.csv", ForReading)

Set objFSO1 = CreateObject("Scripting.FileSystemObject")
Set objFile1 = objFSO1.OpenTextFile("C:\Windows Scripts\OUTPUT\VinMakeModelValidate.htm", ForWriting, TRUE)

URLPath_PREFIX = "<a href=""http://www.vinlink.com/secured/report.action?requestor.vin="
URLPath_BODY = "&requestor.type=recall&doRequest=Request+report"">"
URLPath_SUFFIX = "</a><br>"

objFile1.Write "<html><head><title>VIN Validation</title></head>" 
objFile1.Write "<body bgcolor='white'>" 
objFile1.Write "<table width='100%'><pre>" 
objFile1.Write "<tr><pre>" 
objFile1.Write "<td width='50%'><b>VIN Number</b></td><pre>" 
objFile1.Write "<td width='50%'><b>Validation Link</b></td><pre>" 
objFile1.Write "</tr><pre>"

Do Until objFile.AtEndOfStream 
    strLine = objFile.ReadLine
	arrVINRecord = split(strLine, ",")
	vinPREFIX = arrVINRecord(0)
    vinFULLDESIGNATION = arrVINRecord(1)

    objFile1.Write "<tr><pre>" 
    objFile1.Write "<td width='50%'>" & vinFULLDESIGNATION & "</td><pre>" 
    objFile1.Write "<td width='50%'>" & URLPath_PREFIX & vinFULLDESIGNATION & URLPath_BODY & vinFULLDESIGNATION & URLPath_SUFFIX & "</td><pre>" 
    objFile1.Write "</tr><pre>" 
Loop

objFile1.Write "</table>" 
objFile1.Write "</body></html>" 

objFile.Close
objFile1.Close 

