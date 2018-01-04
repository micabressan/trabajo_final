os.pullEvent = os.pullEventRaw
InsertMainPassword = passwordmain
InsertSecondaryPassword = passwordsecondary
InsertTertiaryPassword = passwordtertiary
InsertQuarternaryPassword = passwordquarternary
InsertQuinaryPassword = passwordquinary
while true do
        term.clear()
        term.setCursorPos(1,1)
        term.write("Password:")
        local password = read()
        
        if password == "passwordmain" then
                shell.run("ID")
        elseif password == "passwordsecondary" then
                shell.run("ID")
        elseif password == "passwordtertiary" then
                shell.run("ID")
        elseif password == "passwordquarternary" then
                shell.run("ID")
        elseif password == "passwordquinary" then
                shell.run("ID")
        else
                term.write("Incorrect.Rebooting")
                sleep(5)
                os.reboot()
        end
end