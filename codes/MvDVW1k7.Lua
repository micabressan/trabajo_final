pass='A000'
print("Please enter password")
input=read('*')

if input==pass then
rs.setOutput('right',true)
sleep(2)
rs.setOutput('right',false)
end

os.reboot()