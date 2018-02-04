func example() (err error) {
    var f *os.File
    f, err = os.Create("myfile.txt")
    if err != nil {
         return
    }

    defer func() {
        f.Close()
  
        err2 := os.Remove("myfile.txt")
        if err == nil && err2 != nil {
            err = err2
        } 
    }() 

    err = f.write([]byte{"somedata"}) 

    // Do more work
}