print("Please enter password to enter")
password=read()
if password=='132963' then
rs.setOutput("left",true)
print("Access granted, welcome epicmono70")
sleep(2)
rs.setOutput("left",false)
end

if password=='147142' then
rs.setOutput("left",true)
print("Access granted, welcome Jimmy_Rustlers")
sleep(2)
rs.setOutput("left",false)
end
sleep(.1)
os.reboot()