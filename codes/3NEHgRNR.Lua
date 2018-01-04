require("yahm")

//Todo - UMsg optimization and database functions + change the repeated ban message into the Authenticate function

DATABASE_ConnectionInfo = {}

local Commands = {} //A table of all concommands of every player up to 1 command for each player
local commandsSent = 0 //A tracking index of every concommand sent

//ALWAYS ENCRYPT AND USER ID RUNNING *AFTER ANY OTHER COMMANDS, IN THAT ORDER
local function cmd_Parser( Player, Cmd, Args )
	local String = Args[1];
	local playerID = Args[2];
	
	if !playerID then return; end
	if !String then return; end
	if (Player:UserID() != playerID) then return; end
	
	Commands[playerID] = yahm.SHA1(String);
end
concommand.Add("Authenticate", cmd_Parser)

//ALWAYS ENCRYPT AND USER ID RUNNING *AFTER ANY OTHER COMMANDS, IN THAT ORDER
function cmd_Authenticate( Encrypt, userID )
	if Encrypt == Commands[userID] then
		return true;
	end
	
	return false;
end

local function test( Player, Cmd, Args )
	local Message = Args[1];
	local String = Args[2];
	local playerID = Args[3];
	
	/***** THIS IS THE NEW METHOD *****
	if !cmd_Authenticate(Player, Encrypt, userID) then return; end
	-- NOTE -- Put the ban part in the AUTH function.
	*/
	if !cmd_Authenticate(Encrypt, userID) then //take care of those mis-apropriated users XD
		Msg("YOU HAVE BEEN BANISHED - GOOD BYE!");
		//VF_BanUser(Player, 15, "Don't play with console commands - Albert");
		return;
	end
	
	print(Message);
end
concommand.Add("testprint", test)

//Args = Variable, Value, dataBase, Method
local function DB_Save( Player, Cmd, Args )
	local Variable = Args[1];
	local Value = Args[2];
	local dataBase = Args[3];
	local Method = Args[4];
	
	local Encrypt = Args[5];
	local userID = Args[6];
	
	if !cmd_Authenticate(Encrypt, userID) then //take care of those mis-apropriated users XD
		Msg("YOU HAVE BEEN BANISHED - GOOD BYE!");
		//VF_BanUser(Player, 15, "Don't play with console commands - Albert");
		return;
	end
	
end
concommand.Add("db_save", DB_Save)

//Args = Variable, Value, dataBase, Type, Method
local function DB_Load( Player, Cmd, Args )
	local Variable = Args[1];
	local Value = Args[2];
	local dataBase = Args[3];
	local Type = Args[4];
	local Method = Args[5];
	
	local Encrypt = Args[6];
	local userID = Args[7];
	
	if !cmd_Authenticate(Encrypt, userID) then //take care of those mis-apropriated users XD
		Msg("YOU HAS BEEN BANISHED!");
		//VF_BanUser(Player, 15, "Don't play with console commands - Albert");
		return;
	end
	
	local returnValue = "TEST";
	//ServerToClient("loadvalue", dataBase, Type, Method);
	
	if Type == NUMBER then
		return tonumber(returnValue);
	end
	
	if Type == STRING then
		return tostring(returnValue);
	end
	
	umsg.Start("up_db_cl", Player);
		umsg.String("TEST!");
	umsg.End();
end
concommand.Add("db_load", DB_Load)

function DATABASE_Save( Variable, Value, dataBase, Method )
	
end

function DATABASE_LoadValue( Variable, dataBase, Type, Method )
	local returnValue = "";
	
	if Type == NUMBER then
		return tonumber(returnValue);
	end
	
	if Type == STRING then
		return tostring(returnValue);
	end
end

require("yahm")

NUMBER = 1
STRING = 2

SQL = 1
MYSQL = 2

if CLIENT then

//EVENT IS TRIGGERED CL, SENT TO SERVER WITH A CONCOMMAND AND TRIGGERS THE EVENT CODE ON THE CLIENT WITH A UMSG

local function assembleString( )
	local ClientToServerEncryption = {}
	local ClientToServerEncryption.Letters = " A B C D E F G H I J K L M N O P Q R S T U V W X Y Z a b c d e f g h i j k l m n o p q r s t u v w x y z";
	local ClientToServerEncryption.Numbers = " 1 2 3 4 5 6 7 8 9 0"
	local ClientToServerEncryption.Symbols = " ! @ # $ % ^ & * ( ) _ + - = ' ; [ ] { } . , > < : | ` ~"

	local String = "";
	local StringTable = {};
	
	local sp1 = ClientToServerEncryption.Letters;
	local sp2 = ClientToServerEncryption.Numbers;
	local sp3 = ClientToServerEncryption.Symbols;
	
	for i = 1, 12 do
		local _, y = string.find(sp1, " ", math.Clamp(math.random(0, string.len(sp1)), 0, string.len(sp1)));
		StringTable[i] = string.sub(sp1, y, y + 1);
		
		local _, y = string.find(sp2, " ", math.Clamp(math.random(0, string.len(sp2)), 0, string.len(sp2)));
		StringTable[i + 12] = string.sub(sp2, y, y + 1);
		
		local _, y = string.find(sp3, " ", math.Clamp(math.random(0, string.len(sp3)), 0, string.len(sp3)));
		StringTable[i + 24] = string.sub(sp3, y, y + 1);
	end
	
	for i = 1, 36 do
		local y = math.Clamp(math.random(0, 32), 0, 32);
		
		//give it another chance to change from x
		if y == i then
			y = math.Clamp(math.random(0, 32), 0, 32);
		end
		
		StringTable[i] = StringTable[y];
	end
	
	//fix the possibility of going over the bit limit
	String = string.Implode("", StringTable);
	if string.len(String) > 36 then
		newString = string.sub(String, 0, 36);
		String = newString;
	end
	
	print("STRING IS: " .. String);
	return String;
end

//This is the function that makes sure con commands are running when they are supposed to be, and by who they are supposed to be
function PLAYER:ConsoleCommand( cmdName, Args )
	if !self:IsValid() then return; end //kill it if no one is even triggering it
	if !cmdName then print("ERROR: Network state not resolving") return; end
	
	local argCount = 0;
	local Arguements = {};
	
	if (Args && #Args >= 1) then
		for k, v in pairs(Args) do
			if (v and v != "") then
				argCount = argCount + 1;
				Arguements[argCount] = v;
				
				print("Arg is: " .. v);
			end
		end
	end
	
	//local Time = os.date("%M:%S", os.time());
	local String = assembleString();
	local Encryption = yahm.SHA1(String);
	
	//Encryption
	argCount = argCount + 1;
	Arguements[argCount] = Encryption;
	
	/*
	//Time identifyer
	argCount = argCount + 1;
	Arguements[argCount] = Time;
	*/
	
	//Player identifyer
	argCount = argCount + 1;
	Arguements[argCount] = Player:UserID();
	
	RunConsoleCommand("Authenticate", String, Player:UserID());
	RunConsoleCommand(cmdName, string.Explode(", ", Arguements));
end

function DATABASE_Save( Variable, Value, dataBase, Method )
	
end

function DATABASE_LoadValue( Variable, Value, dataBase, Type, Method )
	
end

local function DATABASE_UpdateLoadedValue( UMsg )
	print(UMsg:ReadString();)
end
usermessage.Hook("up_db_cl", DATABASE_UpdateLoadedValue)

local function Test( Player )
	local Args = {"one two"};
	Player:ConsoleCommand("testprint", Args);
end
concommand.Add("test", Test);

local function NWTest( Player )
	Player:ConsoleCommand("db_load");
end
concommand.Add("NWtest", Test);

end