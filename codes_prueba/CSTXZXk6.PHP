stock MysqlConnect(sqlhost[], sqluser[], sqlpass[], sqldb[])
{
	new MySQL:tmpHandle = mysql_connect(sqlhost, sqluser, sqlpass, sqldb);
	for(new i = 1; i <= 3; i++)
	{
	    if(mysql_errno() == -1)
	    {
	        printf("Connection to mysql failed...Reconnecting...");
	        tmpHandle = mysql_connect(sqlhost, sqluser, sqlpass, sqldb);
		}
		else
		{
		    printf("Successfuly connected to mysql server!");
		    return tmpHandle;
		}
	}
	printf("Connection to mysql failed...");
	SendRconCommand("Exit");
	return 0;
}