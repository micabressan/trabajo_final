function checkLvCity(UserName, NumberBase,LevelUpgrade,callback) 
{	
	var query = pool.query("SELECT LvCity FROM `userbase` WHERE UserName = '"+UserName
		+"' AND numberBase = '"+NumberBase+"'",function (error, rows,field)
	{
		if (error) 
		{
			console.log("Error in the query UpgradeDatabase: "+UserName);
			callback(err,null);
		}else 
		{
			callback(null,rows[0].LvCity);			
		}
	});
	
}

checkLvCity(UserName, NumberBase, LevelUpgrade, function(err,data)
	{
        if (err) {
            // error handling code goes here
            console.log("ERROR ======: ",err);            
        } else {            
            // code to execute on data retrieval
            console.log("result from db is =====: ",data);   
        }    

	});