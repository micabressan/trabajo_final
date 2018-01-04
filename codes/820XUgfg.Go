func Login(c *gin.Context){
		//read inputan user
		email := c.PostForm("email")
		pass := c.PostForm("pass")
		
		if (email != "") && (pass != "") {
			//cek email di database
			db, err := sql.Open("mysql","root:@/musikami")
			if err != nil{
				panic(err.Error())
			}
			defer db.Close()
			var name string
			readDB, err := db.Prepare("SELECT name FROM user WHERE email = ?")
			_, err = readDB.Exec(email)
			if err != nil {
				c.JSON(http.StatusOK,gin.H{
					"status" : "gagal login",
					"email" : email,
				})
				panic(err.Error())
			}else{
				c.JSON(http.StatusOK, gin.H{
					"status" : "berhasil login",
					"name" : name,
					"email" : email,
					"pass" : pass,
				})
			}
			defer readDB.Close()			
		}else{
			c.JSON(403, gin.H{ 
				"status" : "username / pass still empty",
			})
		}
}