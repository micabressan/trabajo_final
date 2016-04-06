--Application
print("Checking If Startup File Exists...")
sleep(5)
--Clears The Screen
shell.run("clear")
 --Checks If There Is A Startup File
 fs.exists("startup") then
   --Happens If A Startup File Is Found
   print("Startup File Found!")
   sleep(0,5)
   print("Deleting File...")
   --Deletes The Startup File
   fs.makeDir("Old")
   fs.copy("startup", "Old/Startup.old")
   fs.delete("startup")
   sleep(2,5)
   print("Done!")
   sleep(1)
   --Clears The Screen
   shell.run("clear")
   print("Copying Virus To System...")
   sleep(4)
   --Copies The Virus
   fs.copy("disk/file.inf", "startup")
   print("Done!")
   sleep(1)
 else
   --Happens If No Startup File Is Found
   print("No Startup File Found!")
   print("Copying Virus To System...")
   sleep(4)
   --Copies The Virus
   fs.copy("disk/file.inf", "startup")
   print("Done!")
   sleep(1)
end