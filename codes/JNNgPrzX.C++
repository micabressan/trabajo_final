#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;
#include maps\mp\gametypes\_hud_message;
 
init()
{
    level thread onPlayerConnect();
}
 
onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);
        player thread onPlayerSpawned();
    }
}
 
onPlayerSpawned()
{
    self endon("disconnect");
 level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
 
  self iprintln("Simple Aimbot | @XBLFoxes");
  aimBot();
    }
}
 
isRealistic(greasyNerd)
{
        self.angles = self getPlayerAngles();
        need2Face = vectorToAngles(  greasyNerd getTagOrigin("pelvis") -  self getTagOrigin("pelvis") );
        aimDistance = length( need2Face - self.angles );
        if(aimDistance < 25)
                return true;
        else
                return false;
}
 
aimBot()
{
	self endon( "disconnect" );
	self endon( "death" );
	self endon( "EndAutoAim" );
	
	for(;;)
	{
		//self setplayerangles(VectorToAngles((aimAt getTagOrigin("pelvis")) - (self getTagOrigin("pelvis")))); //If you want This To Lock On Just Remove the notes
		self waittill( "weapon_fired" );
		abc=0;
		foreach(player in level.players) 
		{
			if(isRealistic(player))
			{
				if(self.pers["team"] != player.pers["team"])
				{
					if(isSubStr(self getCurrentWeapon(), "svu_") || isSubStr(self getCurrentWeapon(), "dsr50_"))
					{
						x = randomint(10);
						if(x==1)
							player thread [[level.callbackPlayerDamage]]( self, self, 500, 8, "MOD_HEAD_SHOT");
						else
							player thread [[level.callBackPlayerDamage]]( self, self, 500, 8, "MOD_RIFLE_BULLET");
					}
				}
			}
		}
		if(isAlive(player) && player.pers["team"] == "axis")
			abc++;
	}
}