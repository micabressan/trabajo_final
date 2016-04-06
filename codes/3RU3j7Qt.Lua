local jsonTable = false;
local HC2 = Net.FHttp("127.0.0.1",80);

-- get harmonogram
local response ,status, errorCode = HC2:GET("/api/panels/heating/"..zoneID);
if status == "200" then
    jsonTable = json.decode(response)
end

local target = tonumber(jsonTable.properties.handTemperature);