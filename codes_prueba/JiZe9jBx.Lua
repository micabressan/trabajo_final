programName = "reactor"
programCode = "LHUvUFaR"
index = "EnterPersonnalIndexHere" -- replace this with the name of the file you want to create (needs to be unique)

shell.run("rm " .. programName)
shell.run("pastebin get " .. programCode .. " " .. programName)
shell.run(programName .. " " .. index)