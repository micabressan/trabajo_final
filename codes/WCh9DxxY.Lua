
mysql = {}

function mysql.init()
	if Settings.debug == true then outputDebugString( "FUNCTION: mysql.init FROM server/mysql/mysql.core.lua" ) end

	mysql.connect = dbConnect( tostring( Settings.dbConnection.type ), "dbname=" .. tostring(Settings.dbConnection.name) .. ";host=" .. tostring(Settings.dbConnection.ip), tostring(Settings.dbConnection.user), 
		tostring(Settings.dbConnection.pw))	

	if mysql.connect then
        if Settings.debug == true then outputDebugString( "MySQL connection ready!") end
    else
        outputDebugString( "MySQL connection failed:" )
        outputDebugString( "MySQL type: " .. tostring( Settings.dbConnection.type ) )
        outputDebugString( "MySQL name: " .. tostring( Settings.dbConnection.name ) )
        outputDebugString( "MySQL ip: " .. tostring( Settings.dbConnection.ip ) )
        outputDebugString( "MySQL user: " .. tostring( Settings.dbConnection.user ) )
    end
end	

function mysql.query(str,...) 
	if mysql.connect then
		local query = dbQuery(mysql.connect, str,...)
		local result, numrows, insert_id = dbPoll(query, -1)
		if (result and numrows > 0) then return result, numrows, insert_id
		else return false; end
	else
		return false;
	end
end

function mysql.singleQuery(str,...)
	if mysql.connect then
		local query = dbQuery(mysql.connect,str,...)
		local result = dbPoll(query,-1)
		if (type(result == "table")) then return result[1] 
		else return result end
	else return false end
end	

function mysql.exec(str,...)
	if mysql.connect then
		local query = dbExec(mysql.connect,str,...)
		return query
	else return false end
end

function mysql.exit()
	if Settings.debug == true then outputDebugString( "mysql delete" ) end

	if mysql.connect then destroyElement( mysql.connect ) end
end