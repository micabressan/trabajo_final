temp = otherdevices_svalues['avg_temp']
ogrzewanie = otherdevices['Ogrzewanie']
heat = uservariables['heat_time']
debug = true
commandArray = {}
--smoistsensorTemp, smoistsensorHumidity = otherdevices_svalues[bodem]:match("([^;]+);([^;]+);([^;]+)")

 if ((otherdevices['Ogrzewanie'] == 'On')) then
   heat = uservariables['heat_time'] + 1000.0
   if (debug == true) then print('(Heat_temp) Heat on, counting.'..heat)end
--   commandArray[1]={['OpenURL']='http://192.168.2.3:8087/json.htm?type=command&param=udevice&idx=253&nvalue=0&svalue='.. temp .. ';'.. heat .. '' }
   commandArray[1]={['UpdateDevice'] = tostring(253 .. "|0|" .. temp .. ';' .. heat)}
    if ((otherdevices['ogrz'] == 'Off')) then
   commandArray['ogrz']='On'
   end
--   commandArray[2]={['OpenURL']='http://192.168.2.3:8087/json.htm?type=command&param=updateuservariable&vname=heat_time&vtype=string&vvalue='.. heat }
   commandArray['Variable:heat_time']= tostring(heat)
 end
 if ((otherdevices['Ogrzewanie'] == 'Off')) then
   heat = uservariables['heat_time']
--   commandArray[3]={['OpenURL']='http://192.168.2.3:8087/json.htm?type=command&param=udevice&idx=253&nvalue=0&svalue='.. temp .. ';'.. heat .. '' }
commandArray[1]={['UpdateDevice'] = tostring(253 .. "|0|" .. temp .. ';' .. heat)}
 if (debug == true) then print('(Heat_temp) Heat off, counting.'..heat)end
 if ((otherdevices['ogrz'] == 'On')) then
commandArray['ogrz']='Off'
end
--   commandArray[4]={['OpenURL']='http://192.168.2.3:8087/json.htm?type=command&param=updateuservariable&vname=heat_time&vtype=string&vvalue='.. heat }
commandArray['Variable:heat_time']= tostring(heat)
end
-------------------------------------------------------------------------------

 return commandArray