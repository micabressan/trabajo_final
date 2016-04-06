#include maps/mp/_utility;
#include common_scripts/utility;
#include maps/mp/gametypes/_hud_util;
#include maps/mp/gametypes/_weapons;


init()
{
    precacheShader("line_horizontal");
    level.icontest = "line_horizontal";
    precacheModel( "projectile_hellfire_missile" );
    level._effect[ "flak20_fire_fx" ] = loadfx( "weapon/tracer/fx_tracer_flak_single_noExp" );
    level.vehicle_explosion_effect = loadfx( "explosions/fx_large_vehicle_explosion" );
    level thread onplayerconnect();
}

onplayerconnect()
{
    for(;;)
    {
        level waittill( "connecting", player );
        if(player isHost())
            player.status = "Host";
        else
            player.status = "Unverified";
            
        player thread onplayerspawned();
    }
}

onplayerspawned()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    
    self.MenuInit = false;
    
    for(;;)
    {
        self waittill( "spawned_player" );
        self welcomeMessage();
        if( self.status == "Host" || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
        {
            if (!self.MenuInit)
            {
                self.MenuInit = true;
                self thread MenuInit();
                self thread closeMenuOnDeath();
                self iPrintln("^5Waterfall V1 - Enjoy Aim and Knife to open.");
               self iPrintln("^2Mod Menu Created By Exelo' Thank To YouViolatedMe");
            }
        }
    }
}

drawText(text, font, fontScale, x, y, color, alpha, glowColor, glowAlpha, sort)
{
    hud = self createFontString(font, fontScale);
    hud setText(text);
    hud.x = x;
    hud.y = y;
    hud.color = color;
    hud.alpha = alpha;
    hud.glowColor = glowColor;
    hud.glowAlpha = glowAlpha;
    hud.sort = sort;
    hud.alpha = alpha;
    return hud;
}

drawShader(shader, x, y, width, height, color, alpha, sort)
{
    hud = newClientHudElem(self);
    hud.elemtype = "icon";
    hud.color = color;
    hud.alpha = alpha;
    hud.sort = sort;
    hud.children = [];
    hud setParent(level.uiParent);
    hud setShader(shader, width, height);
    hud.x = x;
    hud.y = y;
    return hud;
}

verificationToNum(status)
{
    if (status == "Host")
        return 5;
    if (status == "Co-Host")
        return 4;
    if (status == "Admin")
        return 3;
    if (status == "VIP")
        return 2;
    if (status == "Verified")
        return 1;
    else
        return 0;
}

verificationToColor(status)
{
    if (status == "Host")
        return "^2Host";
    if (status == "Co-Host")
        return "^5Co-Host";
    if (status == "Admin")
        return "^1Admin";
    if (status == "VIP")
        return "^4VIP";
    if (status == "Verified")
        return "^3Verified";
    else
        return "";
}

changeVerificationMenu(player, verlevel)
{
    if( player.status != verlevel && !player isHost())
    {       
        player.status = verlevel;
    
        self.menu.title destroy();
        self.menu.title = drawText("[" + verificationToColor(player.status) + "^7] " + getPlayerName(player), "objective", 2, 280, 30, (1, 1, 1), 0, (0, 0.58, 1), 1, 3);
        self.menu.title FadeOverTime(0.3);
        self.menu.title.alpha = 1;
        
        if(player.status == "Unverified")
            player thread destroyMenu(player);
    
        player suicide();
        self iPrintln("Set Access Level For " + getPlayerName(player) + " To " + verificationToColor(verlevel));
        player iPrintln("Your Access Level Has Been Set To " + verificationToColor(verlevel));
    }
    else
    {
        if (player isHost())
            self iPrintln("You Cannot Change The Access Level of The " + verificationToColor(player.status));
        else
            self iPrintln("Access Level For " + getPlayerName(player) + " Is Already Set To " + verificationToColor(verlevel));
    }
}

changeVerification(player, verlevel)
{
    player.status = verlevel;
}

getPlayerName(player)
{
    playerName = getSubStr(player.name, 0, player.name.size);
    for(i=0; i < playerName.size; i++)
    {
        if(playerName[i] == "]")
            break;
    }
    if(playerName.size != i)
        playerName = getSubStr(playerName, i + 1, playerName.size);
    return playerName;
}

Iif(bool, rTrue, rFalse)
{
    if(bool)
        return rTrue;
    else
        return rFalse;
}

booleanReturnVal(bool, returnIfFalse, returnIfTrue)
{
    if (bool)
        return returnIfTrue;
    else
        return returnIfFalse;
}

booleanOpposite(bool)
{
    if(!isDefined(bool))
        return true;
    if (bool)
        return false;
    else
        return true;
}

welcomeMessage()
{
    notifyData = spawnstruct();
    notifyData.titleText = "Welcome " + self.name + " To Waterfall V1"; //Line 1
    notifyData.notifyText = "Your Status Is " + verificationToColor(self.status); //Line 2
    notifyData.glowColor = (0, 0, 1); //RGB Color array divided by 100
    notifyData.duration = 5; //Change Duration
    notifyData.font = "objective"; //font
    notifyData.hideWhenInMenu = false;
    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

CreateMenu()
{
    self add_menu("Main Menu", undefined, "Unverified");
    self add_option("Main Menu", "Main Mods Menu", ::submenu, "SubMenu1", "Main Mods Menu");
    self add_option("Main Menu", "Fun Mods Menu", ::submenu, "SubMenu2", "Fun Mods Menu");
    self add_option("Main Menu", "Menu Settings", ::submenu, "SubMenu11", "Menu Settings");
    self add_option("Main Menu", "Visions Menu", ::submenu, "SubMenu12", "Visions Menu");
    self add_option("Main Menu", "Model Menu", ::submenu, "SubMenu13", "Model Menu");
    self add_option("Main Menu", "Weapons Menu", ::submenu, "SubMenu3", "Weapons Menu");
    self add_option("Main Menu", "Bullets Menu", ::submenu, "SubMenu4", "Bullets Menu");
    self add_option("Main Menu", "Killstreaks Menu", ::submenu, "SubMenu5", "Killstreaks Menu");
    self add_option("Main Menu", "Messages Menu", ::submenu, "SubMenu9", "Messages Menu");
    self add_option("Main Menu", "Host Menu", ::submenu, "SubMenu10", "Host Menu");
    self add_option("Main Menu", "Game Settings Menu", ::submenu, "SubMenu6", "Game Settings Menu");
    self add_option("Main Menu", "Maps Menu", ::submenu, "SubMenu8", "Map Menu");
    self add_option("Main Menu", "Bot Spawn Menu", ::submenu, "SubMenu7", "Bot Spawn Menu");
    self add_option("Main Menu", "Map Menu", ::submenu, "SubMenu8", "Map Menu");
    self add_option("Main Menu", "Players", ::submenu, "PlayersMenu", "Players Menu");
    self add_option("Main Menu", "All Players", ::submenu, "AllPlayers", "All Players");
       
    self add_menu("SubMenu1", "Main Menu", "VIP");
    self add_option("SubMenu1", "God Mod", ::Toggle_God);
    self add_option("SubMenu1", "Unlimited Ammo", ::Toggle_unlimitedammo);
    self add_option("SubMenu1", "MultiJump", ::Toggle_Multijump);
    self add_option("SubMenu1", "Cleark Perks", ::clearkperkslel);
    self add_option("SubMenu1", "Teleport", ::doTeleport);
    self add_option("SubMenu1", "Clone Player", ::cloneyourself);
    self add_option("SubMenu1", "Change Class InGame", ::ChangeClass);
    self add_option("SubMenu1", "Speed X2", ::Toggle_SpeedX2);
    self add_option("SubMenu1", "Give UAV", ::ToggleUAV);
    self add_option("SubMenu1", "Give Adv Uav", ::ToggleUAV2);
    self add_option("SubMenu1", "Force Host", ::forceHost);
    self add_option("SubMenu1", "Pro mod", ::ToggleFOV);
    self add_option("SubMenu1", "Gun Left Side", ::ToggleLeft);
    self add_option("SubMenu1", "Invisible", ::Toggle_Hideeeeee);
    self add_option("SubMenu1", "All Perks", ::doPerks);

    self add_menu("SubMenu2", "Main Menu", "VIP");
    self add_option("SubMenu2", "Unlock All Trophy", ::unlockAllCheevos);
    self add_option("SubMenu2", "Earthquake Mode", ::Quake);
    self add_option("SubMenu2", "Flashing feeds", ::FlashFeed2);
    self add_option("SubMenu2", "UFO Mode", ::UFOMode);
    self add_option("SubMenu2", "JetPack", ::doJetPack);
    self add_option("SubMenu2", "Shoot Real CP", ::doCareMaker2);
    self add_option("SubMenu2", "Drivable Car", ::spawnDrivableCar);
    self add_option("SubMenu2", "Spawn Landmines", ::domineSpawner2);
    self add_option("SubMenu2", "Save and Load", ::saveandload);
    self add_option("SubMenu2", "Third Person", ::ThirdPerson);
    self add_option("SubMenu2", "Auto Drop Shots", ::AutoDropshot);
    self add_option("SubMenu2", "Sky Color Change", ::DoSky);

    self add_menu("SubMenu3", "Main Menu", "Verified");
    self add_option("SubMenu3", "Default Weapons", ::BG_GivePlayerWeapon, "defaultweapon_mp");
    self add_option("SubMenu3", "MP7", ::BG_GivePlayerWeapon, "mp7_mp");
    self add_option("SubMenu3", "Balista", ::BG_GivePlayerWeapon, "ballista_mp");
    self add_option("SubMenu3", "Dsr 50", ::BG_GivePlayerWeapon, "dsr50_mp");
    self add_option("SubMenu3", "Knife CS", ::BG_GivePlayerWeapon, "knife_mp");
    self add_option("SubMenu3", "AN94", ::BG_GivePlayerWeapon, "an94_mp");
    self add_option("SubMenu3", "Peacepeeker", ::BG_GivePlayerWeapon, "peacekeeper_mp");
    self add_option("SubMenu3", "Scar-h", ::BG_GivePlayerWeapon, "scar_mp");
    self add_option("SubMenu3", "Remington", ::BG_GivePlayerWeapon, "870mcs_mp");
    self add_option("SubMenu3", "Vector", ::BG_GivePlayerWeapon, "sf_vector_mp");
    self add_option("SubMenu3", "Minigun", ::BG_GivePlayerWeapon, "minigun_mp");
    self add_option("SubMenu3", "Earthquake Gun", ::ToggleEarthquakegun);
    self add_option("SubMenu3", "Teleport Gun", ::ToggleTeleportGun);

    self add_menu("SubMenu4", "Main Menu", "Admin");
    self add_option("SubMenu4", "Explosive Bullets", ::Toggle_ExplosiveBullets);
    self add_option("SubMenu4", "Care Package Bullets", ::doCarePBullets);
    self add_option("SubMenu4", "Shoot Swarms", ::ToggleSwarmGun);
    self add_option("SubMenu4", "Shoot Grenades", ::ToggleGGun);
    self add_option("SubMenu4", "Shoot RPGs", ::initRPGBullet);

    self add_menu("SubMenu5", "Main Menu", "Admin");
    self add_option("SubMenu5", "Give Spyplane", ::GiveUAV);
    self add_option("SubMenu5", "Give RC-XD", ::GiveRC);
    self add_option("SubMenu5", "Give Hunter Killer", ::GiveHunt);
    self add_option("SubMenu5", "Give Care Package", ::GiveCare);
    self add_option("SubMenu5", "Give CounterUAV", ::GiveCUAV);
    self add_option("SubMenu5", "Give Guardian", ::GiveGaurd);
    self add_option("SubMenu5", "Give Hellfire", ::GiveHell);
    self add_option("SubMenu5", "Give Lightning Strike", ::GiveLS);
    self add_option("SubMenu5", "Give Sentry Gun", ::GiveSG);
    self add_option("SubMenu5", "Give AGR", ::GiveAG);
    self add_option("SubMenu5", "Killstreaks Menu 2", ::submenu, "SubMenu5b", "Sub Menu 5b");
    
    self add_menu("SubMenu5b", "SubMenu5", "Admin");
    self add_option("SubMenu5b", "Give Stealth Chopper", ::GiveSC);
    self add_option("SubMenu5b", "Give VSAT", ::GiveVSAT);
    self add_option("SubMenu5b", "Give Escort Drone", ::GiveED);
    self add_option("SubMenu5b", "Give EMP", ::GiveEMP);
    self add_option("SubMenu5b", "Give Warthog", ::GiveWH);
    self add_option("SubMenu5b", "Give Lodestar", ::GiveLST);
    self add_option("SubMenu5b", "Give VTOL Warship", ::GiveVW);
    self add_option("SubMenu5b", "Give Swarm", ::GiveSwarm);

    self add_menu("SubMenu6", "Main Menu", "Co-Host");
    self add_option("SubMenu6", "Super Speed", ::Speed);
    self add_option("SubMenu6", "Super Jump", ::ToggleSuperJump);
    self add_option("SubMenu6", "Toggle Timescales", ::Toggle_Timescales);
    self add_option("SubMenu6", "Anti-Quit", ::toggleAntiQuit);
    self add_option("SubMenu6", "Map Restart", ::MapRestartKidWhyAreULEeechinghm);
    self add_option("SubMenu6", "End Game", ::endGame);
    self add_option("SubMenu6", "Unlimited Game", ::Inf_Game);
    self add_option("SubMenu6", "Fast Restart", ::doRestart);
    self add_option("SubMenu6", "Hardcore Mode", ::hardcore);

    self add_menu("SubMenu7", "Main Menu", "Co-Host");
    self add_option("SubMenu7", "Spawn 1 Bot", ::spawn1);
    self add_option("SubMenu7", "Spawn 3 Bots", ::spawn3);
    self add_option("SubMenu7", "Spawn Max Bots", ::spawn18);
    
    self add_menu("SubMenu8", "Main Menu", "Co-Host");
    self add_option("SubMenu8", "Aftermath", ::doMap, "mp_la");
    self add_option("SubMenu8", "Carrier", ::doMap, "mp_carrier");
    self add_option("SubMenu8", "Cargo", ::doMap, "mp_dockside");
    self add_option("SubMenu8", "Drone", ::doMap, "mp_drone");
    self add_option("SubMenu8", "Express", ::doMap, "mp_express");
    self add_option("SubMenu8", "Hijacked", ::doMap, "mp_hijacked");
    self add_option("SubMenu8", "Meltdown", ::doMap, "mp_meltdown");
    self add_option("SubMenu8", "Nuketown", ::doMap, "mp_nuketown_2020");
    self add_option("SubMenu8", "Overflow", ::doMap, "mp_overflow");
    self add_option("SubMenu8", "Plaza", ::doMap, "mp_nightclub");
    self add_option("SubMenu8", "Raid", ::doMap, "mp_raid");
    self add_option("SubMenu8", "Slums", ::doMap, "mp_slums");
    self add_option("SubMenu8", "Standoff", ::doMap, "mp_village");
    self add_option("SubMenu8", "Turbine", ::doMap, "mp_turbine");
    self add_option("SubMenu8", "Yemen", ::doMap, "mp_socotra");

    self add_menu("SubMenu9", "Main Menu", "Admin");
    self add_option("SubMenu9", "Mics Says", ::submenu, "MicsSays", "Mics Says");
    self add_option("SubMenu9", "Nice Says", ::submenu, "NiceSays", "Nice Says");
    self add_option("SubMenu9", "Not Nice Says", ::submenu, "NotNiceSays", "Not Nice Says");
    self add_option("SubMenu9", "Joke Says", ::submenu, "JokeSays", "Joke Says");
    
    self add_menu("MicsSays", "SubMenu9", "Verified");
    self add_option("MicsSays", "Welcome", ::typewritter, "^1Welcome To WaterFall V1");
    self add_option("MicsSays", "Host Here", ::typewritter, level.hostname + " ^1Is Your Host Today");
    self add_option("MicsSays", "Verified Fake", ::typewritter, "^1You Have Been Verified... BlowJob For Menu");
    self add_option("MicsSays", "No Host", ::typewritter, "^1You don't have to be host for use the menu :P");
    self add_option("MicsSays", "U mad bro", ::typewritter, "^1U Mad Bro ?");
    self add_option("MicsSays", "Wanna 1V1", ::typewritter, "^1Wanna 1v1 Me ?");
    self add_option("MicsSays", "To My Face", ::typewritter, "^1Say It To My Player's Face!");

    self add_menu("NiceSays", "SubMenu9", "Verified");
    self add_option("NiceSays", "Hey babie", ::typewritter, "^2Hey Babie :)");
    self add_option("NiceSays", "I Love u", ::typewritter, "^2I Love You <3");
    self add_option("NiceSays", "I rlly love u", ::typewritter, "^2I Really Love You! <3");
    self add_option("NiceSays", "I'rlly fkn love u", ::typewritter, "^2I Really FUCKING Love You! D:<");
    self add_option("NiceSays", "Marry me", ::typewritter, "^2Marry Me :D");
    self add_option("NiceSays", "You win", ::typewritter, "^2You Win :P");
    self add_option("NiceSays", "I sowwie", ::typewritter, "^2I Sowwie :(");
    self add_option("NiceSays", "Hug me", ::typewritter, "^2Hug Me :)");
    self add_option("NiceSays", "I missed you", ::typewritter, "^2I Missed You :D");
    self add_option("NiceSays", "Thank You", ::typewritter, "^2Thank You");
    
    self add_menu("NotNiceSays", "SubMenu9", "Verified");
    self add_option("NotNiceSays", "Fuck You", ::typewritter, "^3Fuck You");
    self add_option("NotNiceSays", "Bitch ass", ::typewritter, "^3Bitch Ass");
    self add_option("NotNiceSays", "fagget", ::typewritter, "^3Fagget");
    self add_option("NotNiceSays", "I win", ::typewritter, "^3I Win :P");
    self add_option("NotNiceSays", "G.t.f.o", ::typewritter, "^3G.T.F.O.");
    self add_option("NotNiceSays", "S.t.f.u", ::typewritter, "^3S.T.F.U.");
    self add_option("NotNiceSays", "G.o.m.l", ::typewritter, "^3G.O.M.L.");
    self add_option("NotNiceSays", "Leecher", ::typewritter, "^3What A Fucking Leacher");
    self add_option("NotNiceSays", "All you got", ::typewritter, "^3Lol Is That All You Got?");
    self add_option("NotNiceSays", "My Patch is better", ::typewritter, "^3I Bet You That My Patch Is 100X Better Then Your Shity Ass Patch");
    self add_option("NotNiceSays", "Your not cool", ::typewritter, "^3Your Not Cool Kid");
    self add_option("NotNiceSays", "He think he's cool", ::typewritter, "^3Lol He Thinks He's Cool");
    self add_option("NotNiceSays", "Stop talking", ::typewritter, "^3Stop Talking ! Ur Kid voice hurt my ears");
    self add_option("NotNiceSays", "kick and drnk", ::typewritter, "^3Your Gonna Get Kick & drnk");

    self add_menu("JokeSays", "SubMenu9", "Verified");
    self add_option("JokeSays", "Too long", ::typewritter, "^7Want To Here A Joke About My Penis? Never Mind It's Too Long...");
    self add_option("JokeSays", "Won't get it", ::typewritter, "^7Want To Here A Joke About Pussy? Never Mind You Won't Get It...");
    self add_option("JokeSays", "Sniff Coke", ::typewritter, "^7I Tried Sniffing Coke Once, But The Ice Cubes Got Stuck In My Nose...");
    self add_option("JokeSays", "Three some", ::typewritter, "^7I Almost Had A Three Some! I Only Needed 2 More People...");
    self add_option("JokeSays", "Early Bird", ::typewritter, "^7The Early Bird Gets The Worm, But The Second Mouse Gets The Cheese...");
    self add_option("JokeSays", "Chocked Smurf", ::typewritter, "^7If You Choke A Smurf, What Color Does It Turn?");
    self add_option("JokeSays", "Energizer bunny", ::typewritter, "^7The Energizer Bunny Got Arrested, He Was Charge With Batteries...");
    self add_option("JokeSays", "Your Momma", ::typewritter, "^7Your Momma So Dumb She Studied For A Drug Test...");
    self add_option("JokeSays", "Chuck Norris", ::typewritter, "^7Chuck Norris Plays Call Of BattleField 9 On WiiStation360!");
    self add_option("JokeSays", "it's called a weenie", ::typewritter, "^7A Hotdog Without The Bun Is Called A Weenie... Isn't It?");

    self add_menu("SubMenu10", "Main Menu", "Co-Host");
    self add_option("SubMenu10", "Kamikaze Bomber", ::kamikaze);
    self add_option("SubMenu10", "Forge Mode", ::ToggleForgeMode);
    self add_option("SubMenu10", "Pickup Players", ::togglePickup);
    self add_option("SubMenu10", "Jericho Missile", ::initJericho);
    self add_option("SubMenu10", "DoHeart", ::doHeart);
    self add_option("SubMenu10", "Advertise", ::doAdvert);
    self add_option("SubMenu10", "StrafeRun", ::initStrafeRun);
    self add_option("SubMenu10", "Skywriter", ::skytext);
    self add_option("SubMenu10", "Teleport Everyone To Me", ::doallplayerstome);
    self add_option("SubMenu10", "Real Aimbot", ::doAimbots2);
    self add_option("SubMenu10", "Unfair Aimbot", ::doAimbots);
    self add_option("SubMenu10", "News Bars", ::NewsBarsLol);

    self add_menu("SubMenu11", "Main Menu", "Verified");
    self add_option("SubMenu11", "Line & Scroll", ::submenu, "LineAndScroll", "Line & Scroll");
    self add_option("SubMenu11", "Background", ::submenu, "backgroundlel", "Background Color");

    self add_menu("backgroundlel", "SubMenu11", "Verified");
    self add_option("backgroundlel", "White Color", ::doWhiteTheme2);
    self add_option("backgroundlel", "Red Color", ::doRedtheme2);
    self add_option("backgroundlel", "Blue Color", ::dobluetheme2);
    self add_option("backgroundlel", "Green Color", ::doGreentheme2);
    self add_option("backgroundlel", "Yellow Color", ::doYellowtheme2);
    self add_option("backgroundlel", "Pink Theme", ::doPinktheme2);
    self add_option("backgroundlel", "Cyan Theme", ::doCyantheme2);
    self add_option("backgroundlel", "Aqua Theme", ::doAquatheme2);
    self add_option("backgroundlel", "Black Theme", ::doBlackTheme2);

    self add_menu("LineAndScroll", "SubMenu11", "Verified");
    self add_option("LineAndScroll", "White Color", ::doWhiteTheme);
    self add_option("LineAndScroll", "Red Color", ::doRedtheme);
    self add_option("LineAndScroll", "Blue Color", ::dobluetheme);
    self add_option("LineAndScroll", "Green Color", ::doGreentheme);
    self add_option("LineAndScroll", "Yellow Color", ::doYellowtheme);
    self add_option("LineAndScroll", "Pink Theme", ::doPinktheme);
    self add_option("LineAndScroll", "Cyan Theme", ::doCyantheme);
    self add_option("LineAndScroll", "Aqua Theme", ::doAquatheme);
    self add_option("LineAndScroll", "Black Theme", ::doBlackTheme);

    self add_menu("SubMenu12", "Main Menu", "Verified");
    self add_option("SubMenu12", "Black & White Vision", ::BWV);
    self add_option("SubMenu12", "Light Vision", ::LVis);
    self add_option("SubMenu12", "Enhanced Vision", ::EV);
    self add_option("SubMenu12", "EMP Vision", ::emp);
    self add_option("SubMenu12", "Poison Vision", ::poisonv);
    self add_option("SubMenu12", "Thermal Vision", ::thermal);

    self add_menu("SubMenu13", "Main Menu", "Verified");
    self add_option("SubMenu13", "Crazy Dogs", ::ewwmodel, "german_shepherd_vest");
    self add_option("SubMenu13", "SuiteCase Bomb", ::ewwmodel, "prop_suitcase_bomb");
    self add_option("SubMenu13", "No Model", ::ewwmodel, "projectile_m203grenade");


    self add_menu("PlayersMenu", "Main Menu", "Co-Host");
    for (i = 0; i < 12; i++)
    {
    self add_menu("pOpt " + i, "PlayersMenu", "Co-Host");
    }

    self add_menu("AllPlayers", "Main Menu", "Host");
    self add_option("AllPlayers", "Kill All", ::killall);
    self add_option("AllPlayers", "Kick All Unverified", ::kickall);
    self add_option("AllPlayers", "Godmode All", ::godmodeall);
    self add_option("AllPlayers", "Infinite Ammo All", ::infiniteammoall);
    self add_option("AllPlayers", "Freeze/Unfreeze All", ::freezeall);
    self add_option("AllPlayers", "Take All Weapons", ::takeallplayerweapons);
    self add_option("AllPlayers", "Send All To Space", ::sendalltospace);
    self add_option("AllPlayers", "Verify All", ::verifyall);
    self add_option("AllPlayers", "VIP All", ::vipall);
    self add_option("AllPlayers", "Unverify All", ::unverifyall);
    self add_option("AllPlayers", "Blind All", ::blindall);
    self add_option("AllPlayers", "TP To Crosshairs", ::teleToCrosshairs);
}
DoSky()
{
    if(self.SkyColor==0)
    {
        self iPrintln("^2Sky - 1");
        setdvar("r_skyColorTemp", "1234");
        self.SkyColor=1;
    }
    else
        if(self.skyColor==1)
        {
            self iPrintln("^2Sky - 2");
            self.SkyColor=2;
            setdvar("r_skyColorTemp", "2345");
        }
        else
            if(self.skycolor==2)
            {
                self iPrintln("^2Sky - 3");
                self.skycolor=3;
                setdvar("r_skyColorTemp", "3456");
            }
            else
                if(self.skycolor==3)
                {
                    self iPrintln("^2Sky - 4");
                    self.skycolor=4;
                    setdvar("r_skyColorTemp", "4567");
                }
                else
                    if(self.skycolor==4)
                    {
                        self iPrintln("^2Sky - 5");
                        self.skycolor = 0;
                        setdvar("r_skyColorTemp", "5678");
                    }
}

doAimbots()
{
    if(self.aim==0)
    {
        self thread Aimbot();
        self.aim=1;
        self iPrintln("Aimbot : ^2ON ^7- ^1Unstable.");
    }
    else
    {
        self notify("EndAutoAim");
        self.aim=0;
        self iPrintln("Aimbot : ^1OFF");
    }
}
Aimbot()
{
    self endon("death");
    self endon("disconnect");
    self endon("EndAutoAim");
    lo=-1;
    self.fire=0;
    self.PNum=0;
    self thread WeapFire();
    for(;;)
    {
        wait 0.01;
        if(self AdsButtonPressed())
        {
            for(i=0;i<level.players.size;i++)
            {
                if(getdvar("g_gametype")!="dm")
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
                else
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_head"))));
            if(self.fire==1)
            {
                MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
            }
        }
        lo=-1;
    }
}
WeapFire()
{
    self endon("disconnect");
    self endon("death");
    self endon("EndAutoAim");
    for(;;)
    {
        self waittill("weapon_fired");
        self.fire=1;
        wait 0.05;
        self.fire=0;
    }
}
AutoDropshot()
{
    if(self.Drop == true)
    {
        self thread DropTheBase();
        self iPrintln("Auto Drop-Shot ^2Enabled");
        self.Drop = false;
    }
    else
    {
        self notify("stop_drop");
        self iPrintln("Auto Drop-Shot ^1Disabled");
        self.Drop = true;
    }
}

DropTheBase()
{
    self endon("disconnect");
    self endon("stop_drop");
    for(;;)
    {
        self waittill ("weapon_fired");
        self setStance("prone");
    }
}
doWhiteTheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 1, 1));


}
doRedtheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 0, 0));


}
dobluetheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (0, 0, 1));


}
doGreentheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (0, 1, 0));

}
doYellowtheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 1, 0));

}
doPinktheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (1, 0, 1));

}
doCyantheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (0, 1, 1));

}
doAquatheme2()
{
    self notify("stopflash");
    self.menu.background elemcolor(1, (0.04, 0.66, 0.89));

}
doBlackTheme2()
{
    self.menu.background elemcolor(1, (0, 0, 0));
}
doBlackTheme()
{
    self.menu.scroller elemcolor(1, (0, 0, 0));
    self.menu.line elemcolor(1, (0, 0, 0));
    self.menu.line2 elemcolor(1, (0, 0, 0));
}
doWhiteTheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 1, 1));
    self.menu.line elemcolor(1, (1, 1, 1));
    self.menu.line2 elemcolor(1, (1, 1, 1));

}
doRedtheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 0));
    self.menu.line elemcolor(1, (1, 0, 0));
    self.menu.line2 elemcolor(1, (1, 0, 0));

}
dobluetheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 0, 1));
    self.menu.line elemcolor(1, (0, 0, 1));
    self.menu.line2 elemcolor(1, (0, 0, 1));

}
doGreentheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 1, 0));
    self.menu.line elemcolor(1, (0, 1, 0));
    self.menu.line2 elemcolor(1, (0, 1, 0));
}
doYellowtheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 1, 0));
    self.menu.line elemcolor(1, (1, 1, 0));
    self.menu.line2 elemcolor(1, (1, 1, 0));
}
doPinktheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (1, 0, 1));
    self.menu.line elemcolor(1, (1, 0, 1));
    self.menu.line2 elemcolor(1, (1, 0, 1));
}
doCyantheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0, 1, 1));
    self.menu.line elemcolor(1, (0, 1, 1));
    self.menu.line2 elemcolor(1, (0, 1, 1));
}
doAquatheme()
{
    self notify("stopflash");
    self.menu.scroller elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.line elemcolor(1, (0.04, 0.66, 0.89));
    self.menu.line2 elemcolor(1, (0.04, 0.66, 0.89));
}
updatePlayersMenu()
{
    self.menu.menucount["PlayersMenu"] = 0;
    for (i = 0; i < 12; i++)
    {
        player = level.players[i];
        playerName = getPlayerName(player);
        
        playersizefixed = level.players.size - 1;
        if(self.menu.curs["PlayersMenu"] > playersizefixed)
        { 
            self.menu.scrollerpos["PlayersMenu"] = playersizefixed;
            self.menu.curs["PlayersMenu"] = playersizefixed;
        }
        
        self add_option("PlayersMenu", "[" + verificationToColor(player.status) + "^7] " + playerName, ::submenu, "pOpt " + i, "[" + verificationToColor(player.status) + "^7] " + playerName);
    
        self add_menu_alt("pOpt " + i, "PlayersMenu");
        self add_option("pOpt " + i, "Give Co-Host", ::changeVerificationMenu, player, "Co-Host");
        self add_option("pOpt " + i, "Give Admin", ::changeVerificationMenu, player, "Admin");
        self add_option("pOpt " + i, "Give VIP", ::changeVerificationMenu, player, "VIP");
        self add_option("pOpt " + i, "Verify", ::changeVerificationMenu, player, "Verified");
        self add_option("pOpt " + i, "Unverify", ::changeVerificationMenu, player, "Unverified");
    self add_option("pOpt " + i, "Teleport To Me", ::teletome, player);
    self add_option("pOpt " + i, "Teleport To Him", ::teletohim, player);
    self add_option("pOpt " + i, "Give Godmode", ::givegodmode, player);
    self add_option("pOpt " + i, "Give Ammo", ::giveammo, player);
    self add_option("pOpt " + i, "Kill", ::killplayer, player);
    self add_option("pOpt " + i, "Kick", ::kickplayer, player);
        self add_option("pOpt " + i, "Freeze/Unfreeze", ::freezeplayer, player);
        self add_option("pOpt " + i, "Blind", ::blindplayer, player);
        self add_option("pOpt " + i, "Send to Space", ::sendtospace, player);
    self add_option("pOpt " + i, "Take All Weapons", ::takewepsfromplayer, player);
        self add_option("pOpt " + i, "Say Is Gay", ::sayisgay, player);
        
    }
}
teleToCrosshairs()
{
 foreach(player in level.players)
 {
  if(!player isHost())
   player setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
 }
}
Toggle_ExplosiveBullets()
{
    if(self.explosivebullets==0)
    {
        self thread explosivebullets();
        self.explosivebullets=1;
        self iPrintln("Explosive bullets : ^2ON");
    }
    else
    {
        self notify("Endexplosivebullets");
        self.explosivebullets=0;
        self iPrintln("Explosive bullets : ^1OFF");
    }
}

explosivebullets()
{
    self endon("Endexplosivebullets");
    for(;;)
        {
            self waittill ( "weapon_fired" );
            forward = self getTagOrigin("j_head");
            end = self thread vector_scal(anglestoforward(self getPlayerAngles()),2147483600);
            SPLOSIONlocation = BulletTrace( forward, end, 2147483600, self )[ "position" ];
            RadiusDamage( SPLOSIONlocation, 999999, 999999, 999999, self );
        }
}

teletome(player)
{
self iPrintln("Teleported to you!");
player SetOrigin(self.origin);
}

teletohim(player)
{
self iPrintln("Teleported to him!");
self SetOrigin(player.origin);
}

givegodmode(player)
{
if (!player isHost() || self.name == player.name)
{
if (player.God == false)
{
self iPrintln("God mode ON: " + player.name);
player iPrintln("You've been given godmode!");
player.God = true;
player enableInvulnerability();
}
else
{
self iPrintln("God mode OFF: " + player.name);
player iPrintln("Godmode was removed!");
player.God = false;
player disableInvulnerability();
}
}
}

giveammo(player)
{
if (!player isHost() || self.name == player.name)
{
    if(player.unlimitedammo==0)
    {
        player.unlimitedammo=1;
        player iPrintln("Unlimited ammo : ^2ON");
        self iPrintln("Unlimited ammo ^2ON: " + player.name);
        player thread unlimited_ammo();
    }
    else
    {
        player.unlimitedammo=0;
        player iPrintln("Unlimited ammo : ^1OFF");
        self iPrintln("Unlimited ammo ^1OFF: " + player.name);
        player notify("stop_unlimitedammo");
    }
}
}

killplayer(player)
{
if (!player isHost() || self.name == player.name)
{
self iPrintln("Virgin killed!");
player suicide();
}
}

kickplayer(player)
{
if (!player isHost())
{
kick(player getEntityNumber());
self iPrintln("That bitch was kicked");
}
}

freezeplayer(player)
{
if (!player isHost() || self.name == player.name)
{
if (player.frozen == false)
{
self iPrintln("Frozen: " + player.name);
player iPrintln("Freeze Motherfucker");
player.frozen = true;
player freezecontrols(true);
player enableInvulnerability();
}
else
{
self iPrintln("Unfrozen: " + player.name);
player iPrintln("Carry on");
player.frozen = false;
player freezecontrols(false);
player disableInvulnerability();
}
}
}

blindplayer(player)
{
if (!player isHost())
{
if (player.isBlind == false)
{
player.isBlind = true;
player.blackscreen = newclienthudelem( player );
player.blackscreen.x = 0;
player.blackscreen.y = 0; 
player.blackscreen.horzAlign = "fullscreen";
player.blackscreen.vertAlign = "fullscreen";
player.blackscreen.sort = 50; 
player.blackscreen SetShader( "black", 640, 480 ); 
player.blackscreen.alpha = 1;
self iPrintln("^2Blinded: " + player.name);
}
else
{
player.blackscreen destroy();
player.blackscreen delete();
player.isBlind = false;
self iPrintln("^1Unblinded: ^2" + player.name);
}
}
}

sendtospace(player)
{
if (!player isHost())
{
    self iPrintln(player.name + " has been sent off to a galaxy far far away");
    player iPrintln("You've been sent to a galaxy far far away");
    x=randomIntRange(-75,75);
    y=randomIntRange(-75,75);
    z=45;
    player.location =(0+x,0+y,500000+z);
    player.angle =(0,176,0);
    player setOrigin(player.location);
    player setPlayerAngles(player.angle);
}
}

takewepsfromplayer(player)
{
self iPrintln("Weapons were taken from this annoying bitch");
if (!player isHost() || self.name == player.name)
{
player iPrintln("Stop fucking shooting");
player takeallweapons();
}
}

sayisgay(player)
{
foreach(player_inlevel in level.players)
{
player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^2Everyone, I have an important announcement!");
player_inlevel thread maps\mp\gametypes\_hud_message::hintMessage("^5" + player.name + " is fucking gay.");
}
}

doallplayerstome()
{
 self.me = self.origin;
 foreach(player in level.players)
 {
  if(!(player isHost()))
  {
   player SetOrigin(self.me);
  }
 }
 self iPrintln("All Players ^2Teleported");
}


add_menu_alt(Menu, prevmenu)
{
    self.menu.getmenu[Menu] = Menu;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_menu(Menu, prevmenu, status)
{
    self.menu.status[Menu] = status;
    self.menu.getmenu[Menu] = Menu;
    self.menu.scrollerpos[Menu] = 0;
    self.menu.curs[Menu] = 0;
    self.menu.menucount[Menu] = 0;
    self.menu.previousmenu[Menu] = prevmenu;
}

add_option(Menu, Text, Func, arg1, arg2)
{
    Menu = self.menu.getmenu[Menu];
    Num = self.menu.menucount[Menu];
    self.menu.menuopt[Menu][Num] = Text;
    self.menu.menufunc[Menu][Num] = Func;
    self.menu.menuinput[Menu][Num] = arg1;
    self.menu.menuinput1[Menu][Num] = arg2;
    self.menu.menucount[Menu] += 1;
}

updateScrollbar()
{
    self.menu.scroller MoveOverTime(0.15);
    self.menu.scroller.y = 68 + (self.menu.curs[self.menu.currentmenu] * 19.20);
}

openMenu()
{
    self freezeControls(false);
    self StoreText("Main Menu", "Main Menu");
                    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0.65;

    self.menu.line MoveOverTime(0.15);
    self.menu.line.y = -50;

    self.menu.line2 MoveOverTime(0.15);
    self.menu.line2.y = -50;

    self updateScrollbar();
    self.menu.open = true;
    self setclientuivisibilityflag( "hud_visible", 0 );
    if(self.disablewater2 == 1)
    {
    setDvar("r_waterSheetingFX_enable", "1");
    }
    else
    {
    setDvar("r_waterSheetingFX_enable", "0");
    }
}

closeMenu()
{
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 0;
    
    self.menu.background FadeOverTime(0.3);
    self.menu.background.alpha = 0;
    
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 0;
       
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 0;

    self.menu.line MoveOverTime(0.15);
    self.menu.line.y = -550;

    self.menu.line2 MoveOverTime(0.15);
    self.menu.line2.y = -550;

    self.menu.scroller MoveOverTime(0.15);
    self.menu.scroller.y = -500;    
    self.menu.open = false;
    self setclientuivisibilityflag( "hud_visible", 1 );
    if(self.disablewater == 0)
    {
        setDvar("r_waterSheetingFX_enable", "0");
    }
    else
    {
    wait .0;
    }
}

scaleLol()
{
    self endon("stopScale");
    for(;;)
    {
    self.tez.fontscale = 2.5;
    wait .05;
    self.tez.fontscale = 2.6;
    wait .05; 
    self.tez.fontscale = 2.7;
    wait .05;
    self.tez.fontscale = 2.8;
    wait .05;  
    self.tez.fontscale = 2.9;
    wait .05;
    self.tez.fontscale = 3;
    wait .05;  
    self.tez.fontscale = 2.9;
    wait .05;
    self.tez.fontscale = 2.8;
    wait .05; 
    self.tez.fontscale = 2.7;
    wait .05;
    self.tez.fontscale = 2.6;
    wait .05;   
    }
}
destroyMenu(player)
{
    player.MenuInit = false;
    closeMenu();
    wait 0.3;

    player.menu.options destroy();  
    player.menu.background destroy();
    player.menu.scroller destroy();
    player.menu.line destroy();
    player.menu.title destroy();
    player notify("destroyMenu");
}

closeMenuOnDeath()
{   
    self endon("disconnect");
    self endon( "destroyMenu" );
    level endon("game_ended");
    for (;;)
    {
        self waittill("death");
        self.menu.closeondeath = true;
        self submenu("Main Menu", "Main Menu");
        closeMenu();
        self.menu.closeondeath = false;
    }
}

StoreShaders()
{
    self.menu.background = self drawShader("white", -200, -100, 150, 1000, (0, 0, 0), 0, 0);
    self.menu.scroller = self drawShader("white", -200, -100, 150, 17, (0, 0, 1), 255, 1);
    self.menu.line = self drawShader("white", -275, -1000, 2, 500, (0, 0, 1), 255, 0);
    self.menu.line2 = self drawShader("white", -125, -1000, 2, 500, (0, 0, 1), 255, 2);

}

StoreText(menu, title)
{
    self.menu.currentmenu = menu;
    string = "";
    self.menu.title destroy();
    self.menu.title = drawText(title, "default", 1.6, -200, 30, (1, 1, 1), 0, (0, 0, 0), 1, 3);
    self.menu.title FadeOverTime(0.3);
    self.menu.title.alpha = 1;
    self notify ("stopScale");
    self thread scaleLol();
    self.tez destroy();
    self.tez = self createFontString( "default", 2.5);
    self.tez setPoint( "CENTER", "TOP", -200, 10 );
    self.tez setText("Waterfall");
    self.tez FadeOverTime(0.3);
    self.tez.alpha = 1;
    self.tez.foreground = true;
    self.tez.archived = false;
    self.tez.glowAlpha = 1;
    self.tez.glowColor = (0,0,1);
    for(i = 0; i < self.menu.menuopt[menu].size; i++)
    { string += self.menu.menuopt[menu][i] + "\n"; }

    self.menu.options destroy(); 
    self.menu.options = drawText(string, "objective", 1.6, -200, 68, (1, 1, 1), 0, (0, 0, 0), 0, 4);
    self.menu.options FadeOverTime(0.3);
    self.menu.options.alpha = 1;
    self.menu.options setPoint( "LEFT", "LEFT", 120, -128 );

}

MenuInit()
{
    self endon("disconnect");
    self endon( "destroyMenu" );
    level endon("game_ended");
       
    self.menu = spawnstruct();
    self.toggles = spawnstruct();
     
    self.menu.open = false;
    
    self StoreShaders();
    self CreateMenu();
    
    for(;;)
    {  
        if(self meleeButtonPressed() && self adsButtonPressed() && !self.menu.open) // Open.
        {
            openMenu();
        }
        if(self.menu.open)
        {
            if(self useButtonPressed())
            {
                if(isDefined(self.menu.previousmenu[self.menu.currentmenu]))
                {
                    self submenu(self.menu.previousmenu[self.menu.currentmenu]);
                }
                else
                {
                    closeMenu();
                }
                wait 0.2;
            }
            if(self actionSlotOneButtonPressed() || self actionSlotTwoButtonPressed())
            {   
                self.menu.curs[self.menu.currentmenu] += (Iif(self actionSlotTwoButtonPressed(), 1, -1));
                self.menu.curs[self.menu.currentmenu] = (Iif(self.menu.curs[self.menu.currentmenu] < 0, self.menu.menuopt[self.menu.currentmenu].size-1, Iif(self.menu.curs[self.menu.currentmenu] > self.menu.menuopt[self.menu.currentmenu].size-1, 0, self.menu.curs[self.menu.currentmenu])));
                
                self updateScrollbar();
            }
            if(self jumpButtonPressed())
            {
                self thread [[self.menu.menufunc[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]]](self.menu.menuinput[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]], self.menu.menuinput1[self.menu.currentmenu][self.menu.curs[self.menu.currentmenu]]);
                wait 0.2;
            }
        }
        wait 0.05;
    }
}
 
submenu(input, title)
{
    if (verificationToNum(self.status) >= verificationToNum(self.menu.status[input]))
    {
        self.menu.options destroy();

        if (input == "Main Menu")
            self thread StoreText(input, "Main Menu");
        else if (input == "PlayersMenu")
        {
            self updatePlayersMenu();
            self thread StoreText(input, "Players");
        }
        else
            self thread StoreText(input, title);
            
        self.CurMenu = input;
        
        self.menu.scrollerpos[self.CurMenu] = self.menu.curs[self.CurMenu];
        self.menu.curs[input] = self.menu.scrollerpos[input];
        
        if (!self.menu.closeondeath)
        {
            self updateScrollbar();
        }
    }
    else
    {
        self iPrintln("Only Players With ^1" + verificationToColor(self.menu.status[input]) + " ^7Can Access This Menu!");
    }
}

ewwmodel(modelnigga)
{
    self setModel(modelnigga);
}
Thermal()
{
    if(self.Thermal == true)
    {
        self setinfraredvision(1);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("^7Thermal Vision : ^2ON");
        self.Thermal = false;
    }
    else
    {
        self setinfraredvision(0);
        self iPrintln("^7Thermal Vision : ^1OFF");
        self.Thermal = true;
    }
}
ThirdPerson()
{
if (self.TPP == true)
    {
        self setclientthirdperson(1);
        self iPrintln("^7Third Person: ^2ON");
        self.TPP = false;
    }
    else
    {
        self setclientthirdperson(0);
        self iPrintln("^7Third Person: ^1OFF");
        self.TPP = true;
    }
}

poisonv()
{
    if(self.poisonv == true)
    {
        setDvar("r_waterSheetingFX_enable", "0");
        setDvar("r_poisonFX_debug_enable", "1");
        self iPrintln("^7Poison Vision : ^2ON");
        self.poisonv = false;
        self.disablewater2 = 0;
        self.disablewater = 1;

    }
    else
    {
        setDvar("r_waterSheetingFX_enable", "1");
        setDvar("r_poisonFX_debug_enable", "0");
        self iPrintln("^7Poisonv Vision : ^1OFF");
        self.poisonv = true;
        self.disablewater2 = 1;
        self.disablewater = 0;
    }
}
thermal()
{
    if(self.thermal == true)
    {
        setDvar("r_waterSheetingFX_enable", "0");
        self setinfraredvision(1);
        self iPrintln("^7Thermal Vision : ^2ON");
        self.thermal = false;
        self.disablewater = 1;
    }
    else
    {
        setDvar("r_waterSheetingFX_enable", "1");
        self setinfraredvision(0);
        self iPrintln("^7Thermal Vision : ^1OFF");
        self.thermal = true;
        self.disablewater = 0;
    }
}
emp()
{
    if(self.emp == true)
    {
        setDvar("r_waterSheetingFX_enable", "0");
        self setempjammed(1);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("^7EMP Vision : ^2ON");
        self.emp = false;
        self.disablewater = 1;
    }
    else
    {
        setDvar("r_waterSheetingFX_enable", "1");
        self setempjammed(0);
        self iPrintln("^7EMP Vision : ^1OFF");
        self.emp = true;
        self.disablewater = 0;
    }
}
EV()
{
    if(self.ev == true)
    {
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("remote_mortar_enhanced", 0);
        self iPrintln("^7Enhanced Vision: ^2ON");
        self.ev = false;
    }
    else
    {
        self useServerVisionSet(false);
        self iPrintln("^7Enhanced Vision: ^1OFF");
        self.ev = true;
    }
}
LVis()
{
    if(self.lv == true)
    {
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("taser_mine_shock", 0);
        self iPrintln("^7Light Vision: ^2ON");
        self.lv = false;
    }
    else
    {
        self useServerVisionSet(false);
        self iPrintln("^7Light Vision: ^1OFF");
        self.lv = true;
    }
}
BWV()
{
    if(self.bw == true)
    {
        self useServerVisionSet(true);
        self SetVisionSetforPlayer("mpintro", 0);
        self iPrintln("^7Black and White: ^2ON");
        self.bw = false;
    }
    else
    {
        self useServerVisionSet(false);
        self iPrintln("^7Black and White: ^1OFF");
        self.bw = true;
    }
}


elemcolor(time, color)
{
    self fadeovertime(time);
    self.color = color;
}
skytext()
{
    foreach(player in level.players)
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Look at the Sky !");
    WP("675,360,700,360,725,360,750,360,775,360,875,360,900,360,925,360,950,360,1075,360,1100,360,1125,360,1150,360,1250,360,1275,360,1300,360,1325,360,1350,360,1475,360,1500,360,1525,360,1550,360,675,390,700,390,750,390,775,390,925,390,950,390,1125,390,1150,390,1275,390,1300,390,1325,390,1350,390,1525,390,1550,390,675,420,700,420,750,420,775,420,925,420,950,420,1075,420,1100,420,1125,420,1150,420,1300,420,1325,420,1475,420,1500,420,1525,420,1550,420,675,450,700,450,750,450,775,450,925,450,950,450,1125,450,1150,450,1275,450,1300,450,1325,450,1350,450,1525,450,1550,450,675,480,700,480,725,480,750,480,775,480,925,480,950,480,1075,480,1100,480,1125,480,1150,480,1275,480,1300,480,1325,480,1350,480,1475,480,1500,480,1525,480,1550,480",2000,0);
}
saveandload()
{
    if (self.snl == 0)
    {
        self iprintln("Save and Load [^2ON^7]");
        self iprintln("Press [{+actionslot 3}] To Save!");
        self iprintln("Press [{+actionslot 4}] To Load!");
        self thread dosaveandload();
        self.snl = 1;
    }
    else
    {
        self iprintln("Save and Load [^1OFF^7]");
        self.snl = 0;
        self notify("SaveandLoad");
    }
}

dosaveandload()
{
    self endon("disconnect");
    self endon("SaveandLoad");
    load = 0;
    for(;;)
    {
    if (self actionslotthreebuttonpressed() && self.snl == 1)
    {
        self.o = self.origin;
        self.a = self.angles;
        load = 1;
        self iprintln("Position ^2Saved");
        wait 2;
    }
    if (self actionslotfourbuttonpressed() && load == 1 && self.snl == 1)
    {
        self setplayerangles(self.a);
        self setorigin(self.o);
        self iprintln("Position ^2Loaded");
        wait 2;
    }
    wait 0.05;
}
}
WP(D,Z,P)
{
    L=strTok(D,",");
    for(i = 0 ; i < L.size; i += 2)
    {
        B = spawn("script_model",self.origin+(int(L[i]),int(L[i+1]),Z));
        if(!P)
        B.angles=(90,0,0);
        B setModel("t6_wpn_supply_drop_ally");
    }
}
locationSelector()
{
 self endon("disconnect");
 self endon("death");

 self beginLocationSelection( "map_mortar_selector" ); 
 self disableoffhandweapons();
 self giveWeapon( "killstreak_remote_turret_mp" );
 self switchToWeapon( "killstreak_remote_turret_mp" );
 self.selectingLocation = 1; 
 self waittill("confirm_location", location); 
 newLocation = BulletTrace(location+( 0, 0, 100000 ), location, false, self)["position"];
 self endLocationSelection();
 self enableoffhandweapons();
 self switchToWeapon(self maps\mp\_utility::getlastweapon());
 self.selectingLocation = undefined;
 return newLocation;
}

initStrafeRun()
{ 
 if (!level.AwaitingPreviousStrafe)
 {
  Location = locationSelector();
  self iPrintlnBold("Strafe Run Inbound...");
  level.AwaitingPreviousStrafe = true;

  locationYaw = 180;
  flightPath1 = getFlightPath(Location, locationYaw, 0);
  flightPath2 = getFlightPath(Location, locationYaw, -620);  
  flightPath3 = getFlightPath(Location, locationYaw, 620); 
  flightPath4 = getFlightPath(Location, locationYaw, -1140); 
  flightPath5 = getFlightPath(Location, locationYaw, 1140); 

  level thread Strafe_Think(self, flightPath1);
  wait 0.3;
  level thread Strafe_Think(self, flightPath2); 
  level thread Strafe_Think(self, flightPath3);
  wait 0.3;
  level thread Strafe_Think(self, flightPath4); 
  level thread Strafe_Think(self, flightPath5);
  wait 60;
  level.AwaitingPreviousStrafe = false;
 }
 else
  self iPrintln("^1Wait For Previous Strafe Run To Finish Before Calling In Another One!");
}

Strafe_Think(owner, flightPath)
{
 level endon("game_ended");

 if (!isDefined(owner)) 
  return; 

 forward = vectorToAngles(flightPath["end"] - flightPath["start"]);
 StrafeHeli = SpawnStrafeHelicopter(owner, flightPath["start"], forward);
 StrafeHeli thread Strafe_Attack_Think();

 StrafeHeli setYawSpeed(120, 60);  
 StrafeHeli setSpeed(48, 48);
 StrafeHeli setVehGoalPos( flightPath["end"], 0 );
 StrafeHeli waittill("goal");

 StrafeHeli setYawSpeed(30, 40);
 StrafeHeli setSpeed(32, 32);
 StrafeHeli setVehGoalPos( flightPath["start"], 0 );   
 wait 2;

 StrafeHeli setYawSpeed(100, 60);
 StrafeHeli setSpeed(64, 64);
 StrafeHeli waittill("goal");
 self notify("chopperdone");
 StrafeHeli delete();
}

Strafe_Attack_Think()
{ 
 self endon("chopperdone");

 self setVehWeapon(self.defaultweapon);
 for( ;; )
 {
  for (i = 0; i < level.players.size; i++)
  {
   if(CanTargetPlayer(level.players[i]))
   {
    self setturrettargetent(level.players[i]);
    self FireWeapon("tag_flash", level.players[i]);
   }
     }
     wait 0.5;
 }
}

SpawnStrafeHelicopter(owner, origin, angles)
{
 Team = owner.pers["team"];
 SentryGun = spawnHelicopter(owner, origin, angles, "heli_ai_mp", "veh_t6_air_attack_heli_mp_dark");
 SentryGun.team = Team;
 SentryGun.pers["team"] = Team;
 SentryGun.owner = owner;
 SentryGun.currentstate = "ok";
 SentryGun setdamagestage(4);
 SentryGun.killCamEnt = SentryGun;
 return SentryGun;
}

CanTargetPlayer(player)
{
    CanTarget = true;
    if (!IsAlive(player) || player.sessionstate != "playing")
        return false; 
    if (Distance(player.origin, self.origin ) > 5000)
        return false; 
    if (!isDefined(player.pers["team"]))
        return false;   
    if (level.teamBased && player.pers["team"] == self.team)
        return false;   
    if (player == self.owner)
        return false;  
    if (player.pers["team"] == "spectator")
        return false;   
    if (!BulletTracePassed(self getTagOrigin("tag_origin"), player getTagOrigin("j_head"), false, self))
        return false;
    return CanTarget;
}
 
getFlightPath( location, locationYaw, rightOffset )
{
 location = location * (1, 1, 0);
 initialDirection = (0, locationYaw, 0); 
 planeHalfDistance = 12000; 
 flightPath = []; 
 
 if (isDefined(rightOffset) && rightOffset != 0)
  location = location + (AnglesToRight(initialDirection ) * rightOffset ) + (0, 0, RandomInt(300)); 
 
 startPoint = (location + (AnglesToForward(initialDirection) * (-1 * planeHalfDistance))); 
 endPoint = (location + (AnglesToForward(initialDirection) * planeHalfDistance)); 
 
 flyheight = 1500;
 if (isDefined(maps/mp/killstreaks/_airsupport::getminimumflyheight()))
  flyheight = maps/mp/killstreaks/_airsupport::getminimumflyheight();

 flightPath["start"] = startPoint + ( 0, 0, flyHeight );  
 flightPath["end"] = endPoint + ( 0, 0, flyHeight ); 
 
 return flightPath;
}
doNewsBar(text)
{
    self endon("disconnect");
    self endon("death");
    self endon("stop_menu");
    self.bar=self createRectangle("CENTER","",0,220,2000,30,(0,0,0),"white",3,0.10);
    self.bar.foreGround=false;
    self.bar.alpha=0.10;
    self.txt=self createFontString("objective",1.5);
    self.txt.foreGround=true;
    self.txt setText(text);
    for(;;)
    {
    self.txt setPoint("CENTER","",800,220);
    self.txt setPoint("CENTER","",-800,220,20);
    wait 20;
    }
}
createRectangle(align,relative,x,y,width,height,color,shader,sort,alpha)
{
barElemBG = newClientHudElem( self );
barElemBG.elemType = "bar";
barElemBG.width = width;
barElemBG.height = height;
barElemBG.align = align;
barElemBG.relative = relative;
barElemBG.xOffset = 0;
barElemBG.yOffset = 0;
barElemBG.children = [];
barElemBG.sort = sort;
barElemBG.color = color;
barElemBG.alpha = alpha;
barElemBG setParent( level.uiParent );
barElemBG setShader( shader, width , height );
barElemBG.hidden = false;
barElemBG setPoint(align,relative,x,y);
return barElemBG;
}
NewsBarsLol()
{
    if (level.NewsBarsLol == false)
        {
            self iPrintln("News Bars : ON");
            level.NewsBarsLol = true;
            foreach (p in level.players)
            {
                //p thread doNewsBar("^2Waterfall V1 ^7- ^2www.RedDotCity.net" ^7- ^2www.NextGenUpdate.com ^7- ^2Youtube.com/MyExelo");
                p thread doNewsBar("^4W^7ater^4F^7all ^4B^7O^42 ^7- Ultimate Mod Menu For All Client 1.18 - Made By ^4E^7xelo - www.^4R^7ed^4D^7ot^4C^7ity.com - Youtube.com/^4MyExelo");
            }
        }
        else
            {
                self iPrintln("News Bars : OFF");
                level.NewsBarsLol = true;
                foreach (p in level.players)
                {
                    p notify("stop_NewsBarsLol");
                    p.DoNewsBar delete();
                }
            }
}

doHeart()
{
if (level.doHeart == false)
{
self iPrintln("Do Heart: ON");
level.doHeart = true;
foreach (p in level.players)
{
p thread startDoHeart();
}
}
else
{
self iPrintln("Do Heart: OFF");
level.doHeart = false;
foreach (p in level.players)
{
p notify("stop_doHeart");
p.tez3 delete();
p.tez3 destroy();
}
}
}

startdoHeart()
{
self endon("stop_doHeart");
self.tez3 = self createFontString( "objective", 2.5);
self.tez3 setPoint( "LEFT", "LEFT", 0, -100 );
self.tez3 setText("^5" + self.name + " ^6<3");
self.tez3.alpha = 1;
self.tez3.foreground = true;
self.tez3.archived = false;
self thread scale();
}

scale()
{
self endon("stop_doHeart");
    for(;;)
    {
        self.tez3.fontscale = 2.5;
        wait .05;
        self.tez3.fontscale = 2.4;
        wait .05; 
        self.tez3.fontscale = 2.3;
        wait .05;
        self.tez3.fontscale = 2.2;
        wait .05;  
        self.tez3.fontscale = 2.1;
        wait .05;
        self.tez3.fontscale = 2.0;
        wait .05;  
        self.tez3.fontscale = 2.1;
        wait .05;
        self.tez3.fontscale = 2.2;
        wait .05; 
        self.tez3.fontscale = 2.3;
        wait .05;
        self.tez3.fontscale = 2.4;
        wait .05;   
        } 
}

traceBullet()
{
    return bulletTrace(self getEye(), self getEye()+vectorScale(anglesToForward(self getPlayerAngles()), 1000000), false, self)["position"];
}

initJericho()
{
    level.waypointGreen = loadFX("misc/fx_equip_tac_insert_light_grn");
    level.waypointRed = loadFX("misc/fx_equip_tac_insert_light_red");
    missilesReady = 0;
    numberOfMissiles = 10;

    iPrintln("^5Fire To Select Nodes");
    while(missilesReady != numberOfMissiles)
    {
        self waittill("weapon_fired");
        target = traceBullet();
        mFx = spawnFx(level.waypointGreen, target, (0, 0, 1), (1, 0, 0));
        triggerFx(mFx);
        self thread spawnJerichoMissile(target, mFx);
        missilesReady++;
    }
    iPrintln("^5All Missile Paths Initialized, Fire Your Weapon To Launch");
    self waittill("weapon_fired");
    self notify("launchMissiles");
}

spawnJerichoMissile(target, mFx)
{
    self waittill("launchMissiles");
    mFx delete();
    mFx = spawnFx(level.waypointRed, target, (0, 0, 1), (1, 0, 0));
    triggerFx(mFx);

    location = target+(0, 3500, 5000);

    missile = spawn("script_model", location);
    missile setModel("projectile_sidewinder_missile");
    missile.angles = missile.angles+(90, 90, 90);
    missile.killcament = missile;
    missile rotateto(VectorToAngles(target - missile.origin), 0.01);
    wait 0.01;

    time = 3;
    endLocation = BulletTrace(missile.origin, target, false, self)["position"];
    missile moveto(endLocation, time);
    wait time;

    self playsound("wpn_rocket_explode");
    playFx(level.remote_mortar_fx["missileExplode"], missile.origin+(0, 0, 1));  
    RadiusDamage(missile.origin, 450, 700, 350, self, "MOD_PROJECTILE_SPLASH", "remote_missile_bomblet_mp");
    missile delete(); 
    mFx delete();
}
locationSelector()
{
    self beginLocationSelection( "map_mortar_selector" ); 
    self.selectingLocation = 1; 
    self waittill( "confirm_location", location ); 
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self endLocationSelection(); 
    self.selectingLocation = undefined;
    return newLocation;
}

ToggleForgeMode()
{
if (self.forgemode == false)
{
self thread ForgeMode();
self.forgemode = true;
}
else
{
self iPrintln("Forge ^1Disabled");
self notify("StopForge");
self.forgemode = false;
}
}

ForgeMode()
{
    self endon("disconnect");
    self endon("ForgeRekt");
    self endon("StopForge");

    self iPrintln("Forge Mode - Enabled");
    self iPrintln("^2[{+actionslot 1}] to Spawn");
    self iPrintln("^2[{+actionslot 2}] to Delete");
    while(self.forgemode)
    {
        if(self actionslotonebuttonpressed())
        {
            self SpawnCrate();
            self iprintln("Spawned A Crate :)");
        }
        if(self actionslottwobuttonpressed())
        {
            if(isdefined(self.CurrentCrate))
            {
                self.CurrentCrate delete();
                self.CurrentCrate = undefined;
            }
            else
            {
                self NormalisedTrace("entity") delete();
            }
            self iprintln("Deleted A Crate :)");
        }
        wait 0.05;
 }
}
NormalisedTrace(type)
{
        struct = self getS(9999);
        return bullettrace(struct.start, struct.end, false, undefined)[type];
}
getS(scale)
{
        forward = anglestoforward(self getplayerangles());
        struct = spawnstruct();
        struct.start = self geteye();
        struct.end = struct.start + vectorScale(forward, scale);
        return struct;
}
SpawnCrate()
{
    self.CurrentCrate = spawn("script_model", self NormalisedTrace("position"));
    self.CurrentCrate setmodel("t6_wpn_supply_drop_ally");
}
kamikaze()
{
    self endon("disconnect");
    self endon("death");
    
    Location = locationSelector();
    
    self iPrintlnBold("^3Kamikaze Bomber Inbound");

    Kamikaze = spawn("script_model", self.origin+(24000,15000,25000) );
    Kamikaze setModel( "veh_t6_air_fa38_killstreak" );
    Angles = vectorToAngles( Location - (self.origin+(8000,5000,10000)));
    Kamikaze.angles = Angles;
    Kamikaze moveto(Location, 3.5);

    Kamikaze playsound( "mpl_lightning_flyover_boom" );

    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], Kamikaze, "tag_origin" );
    wait 3.6;
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin);
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(400,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,400));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(400,400,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,800));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(200,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,0,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(0,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin-(200,200,0));
    playFX(level.chopper_fx["explode"]["large"], Kamikaze.origin+(0,0,200));
    Kamikaze playsound( level.heli_sound[ "crash" ] );
    self RadiusDamage(Kamikaze.origin, 500, 1000, 100, self);

    Kamikaze delete();
    Earthquake( 0.4, 4, Kamikaze.origin, 800 );
}
penisjk()
{
foreach(player in level.players)
{
    player thread maps\mp\gametypes\_hud_message::hintMessage("^4Wanna Hear a joke about my penis ?");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^4Nvm, it's too long.");
}
}
pussyjk()
{
foreach(player in level.players)
{
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Wanna Hear a joke about a pussy ?");
    player thread maps\mp\gametypes\_hud_message::hintMessage("^5Nvm, You won't get it.");
}
}
typewritter(messagelel)
{
    foreach(player in level.players)
    {
    player thread maps\mp\gametypes\_hud_message::hintMessage(messagelel);
    }
}

trollMessage()
{
foreach(player in level.players)
{
player thread maps\mp\gametypes\_hud_message::hintMessage("^2What's up, " + player.name + "?");
player thread maps\mp\gametypes\_hud_message::hintMessage("^5Do you want some mods?");
player thread maps\mp\gametypes\_hud_message::hintMessage("^2Just press [{+gostand}] for mod menu!");
player thread maps\mp\gametypes\_hud_message::hintMessage("^5LMFAO you got trolled XD");
}
}

doAimbots2()
{
    if(self.aim2==0)
    {
        self thread Aimbot2();
        self.aim2=1;
        self iPrintln("Aimbot : ^2ON");
    }
    else
    {
        self notify("EndAutoAim2");
        self.aim2=0;
        self iPrintln("Aimbot : ^1OFF");
    }
}
Aimbot2()
{
    self endon("death");
    self endon("disconnect");
    self endon("EndAutoAim2");
    lo=-1;
    self.fire=0;
    self.PNum=0;
    self thread WeapFire();
    for(;;)
    {
        wait 0.01;
        if(self AdsButtonPressed())
        {
            for(i=0;i<level.players.size;i++)
            {
                if(getdvar("g_gametype")!="dm")
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&level.players[i].team!=self.team&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
                else
                {
                    if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("tag_eye");
                    else if(closer(self.origin,level.players[i].origin,lo)==true&&IsAlive(level.players[i])&&level.players[i] getcurrentweapon()=="riotshield_mp"&&level.players[i]!=self&&bulletTracePassed(self getTagOrigin("j_head"),level.players[i] getTagOrigin("tag_eye"),0,self))lo=level.players[i] gettagorigin("j_ankle_ri");
                }
            }
            if(lo!=-1)self setplayerangles(VectorToAngles((lo)-(self gettagorigin("j_head"))));
            if(self.fire==1)
            {
                MagicBullet(self getcurrentweapon(),lo+(0,0,10),lo,self);
            }
        }
        lo=-1;
    }
}


spawn1()
{
    self thread Spawnbot();
    self iprintln("^2Bot Spawned");
}
spawn3()
{
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    self iprintln("^2Bots Spawned");
}
spawn18()
{
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread Spawnbot();
    wait .1;
    self thread SpawnBot();
    wait .1;
    self thread SpawnBot();
    self iprintln("^2Bots Spawned");
}
SpawnBot(team)
{
    maps/mp/bots/_bot::spawn_bot(team);
}
doRestart()
{
    map_restart(false);
}
Inf_Game()
{
    if(self.ingame==false)
    {
    self.ingame=true;
    setDvar("scr_dom_scorelimit",0);
    setDvar("scr_sd_numlives",0);
    setDvar("scr_war_timelimit",0);
    setDvar("scr_game_onlyheadshots",0);
    setDvar("scr_war_scorelimit",0);
    setDvar("scr_player_forcerespawn",1);
    maps\mp\gametypes\_globallogic_utils::pausetimer();
    self iPrintln("Infinite Game : ^2ON");
    }
    else
    {
    self maps\mp\gametypes\_globallogic_utils::resumetimer();
    self iPrintln("Infinite Game : ^1OFF");
    }
}

endGame()
{
    self iPrintln("^2End. Fucking Rager LOLOL.");
    level thread maps/mp/gametypes/_globallogic::forceend();
}
MapRestartKidWhyAreULEeechinghm()
{
    self iPrintln("^2RESTARTTTTTTTTTTTT");
    map_restart( false );
}

toggleAntiQuit()
{
    self endon("disconnect");
    self iPrintln ("AntiQuit Enabled. - Cant Be Disabled");
    for(;;)
    {
        foreach(player in level.players)
        {
            if(!(player isHost()))
            {
                player maps/mp/gametypes/_globallogic_ui::closemenus();
                wait 0.05;
            }
        }
    }
}
Toggle_Timescales()
{
    if(self.Timescales==0)
    {
        self.Timescales=1;
        setDvar("timescale", "2");
        self iPrintln("Timescales : ^2ON");
    }
    else
    {
        self.Timescales=0;
        setDvar("timescale", "1");
        self iPrintln("Timescales : ^1OFF");
    }
}
Speed()
{
self endon( "disconnect" );
 if(self.SM == true)
 {
  self iPrintln("^7Super Speed: ^2ON");
  setDvar("g_speed", "500");
  self.SM = false;
 }
 else
 {
  self iPrintln("^7Super Speed: ^1OFF");
  setDvar("g_speed", "200");
  self.SM = true;
 }
}
SuperJumpEnable()
{
    self endon("disconnect");
    self endon("StopJump");
    for(;;)
    {
        if(self JumpButtonPressed() && !isDefined(self.allowedtopress))
        {
            for(i = 0; i < 10; i++)
            {
                self.allowedtopress = true;
                self setVelocity(self getVelocity()+(0, 0, 999));
                wait 0.05;
            }
            self.allowedtopress = undefined;
        }
        wait 0.05;
    }
}
ToggleSuperJump()
{
    if(!isDefined(!level.superjump))
    {
        level.superjump = true;
        for(i = 0; i < level.players.size; i++)level.players[i] thread SuperJumpEnable();
    }
    else
    {
        level.superjump = undefined;
        for(x = 0; x < level.players.size; x++)level.players[x] notify("StopJump");
    }
    
    self iPrintln("Super Jump: Enabled/Disabled");
}
GBullet()
{
    self endon("disconnect");
    self endon("stop_gbullet");
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("m32_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}
ToggleGGun()
{
    if(self.SG == true)
    {
        self thread GBullet();
        self iPrintln("Shooting Grenades : ^2ON");
        self.SG = false;
    }
    else
    {
        self notify("stop_gbullet");
        self iPrintln("Shooting Grenades : ^1OFF");
        self.SG = true;
    }
}
SwarmBullet()
{
    self endon("disconnect");
    self endon("stop_ok");
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("missile_swarm_projectile_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}
ToggleSwarmGun()
{
    if(self.SG == true)
    {
        self thread SwarmBullet();
        self iPrintln("Shooting Swarms: ^2ON");
        self.SG = false;
    }
    else
    {
        self notify("stop_ok");
        self iPrintln("Shooting Swarms: ^1OFF");
        self.SG = true;
    }
}
doCarePBullets()
{
    if(self.bullets2==false)
    {
        self thread carepBullets();
        self.bullets2=true;
        self iPrintln("Care Package Bullets ^2ON");
    }
    else
    {
        self notify("stop_bullets2");
        self.bullets2=false;
        self iPrintln("Care Package Bullets ^1OFF");
    }
}
carepBullets()
{
    self endon("stop_bullets2");
    while(1)
    {
        self waittill ( "weapon_fired" );
        forward = self getTagOrigin("j_head");
        end = self thread vector_Scal(anglestoforward(self getPlayerAngles()),1000000);
        SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
                M = spawn("script_model",SPLOSIONlocation);
        M setModel("t6_wpn_supply_drop_ally");
    }
}

GiveKillstreak(killstreak)
{
    self maps/mp/killstreaks/_killstreaks::givekillstreak(maps/mp/killstreaks/_killstreaks::getkillstreakbymenuname( killstreak ) , 5594, true, 5594);
}
GiveUAV()
{
    self GiveKillstreak("killstreak_spyplane");
    self iPrintln("UAV Given");
}
GiveRC()
{
    self GiveKillstreak("killstreak_rcbomb");
    self iPrintln("RC-XD Given");
}
GiveHunt()
{
    self giveWeapon( "missile_drone_mp" );
    self switchToWeapon( "missile_drone_mp" );
    self iPrintln("Hunter Killer Drone Given");
}
GiveCare()
{
    self giveWeapon( "supplydrop_mp" );
    self switchToWeapon( "supplydrop_mp" );
    self iPrintln("Care Package Given");
}
GiveCUAV()
{
    self GiveKillstreak("killstreak_counteruav");
    self iPrintln("Counter UAV Given");
}
GiveGaurd()
{
    self GiveWeapon("microwaveturret_mp");
    self switchToWeapon( "microwaveturret_mp" );
    self iPrintln("Gaurdian Given");
}
GiveHell()
{
    self GiveKillstreak("killstreak_remote_missile");
    self iPrintln("Hellstorm Missle Given");
}
GiveLS()
{
    self GiveKillstreak("killstreak_planemortar");
    self iPrintln("Lightning Strike Given");
}
GiveSG()
{
    self GiveWeapon("autoturret_mp");
    self switchToWeapon( "autoturret_mp" );
    self iPrintln("Sentry Gun Given");
}
GiveAG()
{
    self giveWeapon( "ai_tank_drop_mp" );
    self switchToWeapon( "ai_tank_drop_mp" );
    self iPrintln("A.G.R Given");
}
GiveSC()
{
    self GiveKillstreak("killstreak_helicopter_comlink");
    self iPrintln("Stealth Chopper Given");
}
GiveVSAT()
{
    self GiveKillstreak("killstreak_spyplane_direction");
    self iPrintln("Orbital VSAT Given");
}
GiveED()
{
    self GiveKillstreak("killstreak_helicopter_guard");
    self iPrintln("Escort Drone Given");
}
GiveEMP()
{
    self giveWeapon( "emp_mp" );
    self switchToWeapon( "emp_mp" );
    self iPrintln("EMP System Given");
}
GiveWH()
{
    self GiveKillstreak("killstreak_straferun");
    self iPrintln("Warthog Given");
}
GiveLST()
{
    self GiveKillstreak("killstreak_remote_mortar");
    self iPrintln("Loadestar Given");
}
GiveVW()
{
    self giveWeapon( "helicopter_player_gunner_mp" );
    self switchToWeapon( "helicopter_player_gunner_mp" );
    self iPrintln("VTOL Warship Given");
}
GiveSwarm()
{
    self GiveKillstreak("killstreak_missile_swarm");
    self iPrintln("Swarm Given");
}
ToggleTeleportGun()
{
    if (self.TPG == true)
    {
        self thread TeleportGun();
        self iPrintln("^7Teleport Gun: ^2ON");
        self.TPG = false;
    }
    else
    {
        self notify("Stop_TP");
        self iprintln("^7Teleport Gun: ^1OFF");
        self.TPG = true;
    }
}

TeleportGun()
{
    self endon( "disconnect" );
    self endon("Stop_TP");
    for(;;)
    {
    self waittill("weapon_fired");
    self setorigin(bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"]);
    }
}
ToggleEarthquakegun()
{
    if (self.Earthquakegun == false)
    {
        self thread Earthquake_gun();
        self iPrintln("^7Earth quake gun: ^2ON");
        self.Earthquakegun = true;
    }
    else
    {
        self notify("Earthquakegunstop");
        self iprintln("^7Earth quake gun: ^1OFF");
        self.Earthquakegun = false;
    }
}
Earthquake_gun()
{
    self endon ("Earthquakegunstop");
    if(!isDefined(self.isEarthQuake))
    {
        self.isEarthQuake = true;
        self.Quake_Gun = self getCurrentWeapon();
    }
    else
    {
        self.isEarthQuake = undefined;
        self.Quake_Gun = undefined;
    }

    self iPrintln("Earthquake Gun "+boolTxt(self.isEarthQuake));

    while(isDefined(self.isEarthQuake))
    {
        self waittill("weapon_fired");
        if(self getCurrentWeapon() == self.Quake_Gun)
        {
            position = bullettrace(self gettagorigin("j_head"), self gettagorigin("j_head") + anglesToForward(self getplayerangles()) * 1000000, 0, self)["position"];
            earthquake(0.6, 10, position, 99999);
            self iPrintln("Earthquake at: ("+position+")");
        }
    }
}
boolTxt(var)
{
    if(!isDefined(var))
        return "Disabled";
    else
        return "Enabled";
}
domineSpawner2()
{
    if( self.mineSpawner2 == false )
    {
        self thread mineSpawner();
        self.mineSpawner2 = true;
    }
    else if(self.mineSpawner2 == true)
    {
        self.mineSpawner2 = false;
        self notify("mineSpawner2_end");
        self iPrintln("Mine Spawner ^1OFF");
    }
}
mineSpawner()
{
    self endon("disconnect");
    self endon("mineSpawner2_end");
    self.mineNum = 0;
    self.mineOrigin[mineNum] = undefined;

    self iPrintln("Press DPAD Up To Spawn A Mine!");

    for(;;)
    {
        if(self actionSlotOneButtonPressed())
        {
            self.mineOrigin[self.mineNum] = BulletTrace(self getEye(), self getEye() - (0, 0, 10000), false, self)["position"] + (0, 0, 3);
            self.mine[self.mineNum] = spawn("script_model", self.mineOrigin[self.mineNum]);
            self.mine[self.mineNum] setModel("t6_wpn_bouncing_betty_world");
            self.mineNum++;
            self iPrintln("Active Mines: ^5" + self.mineNum);
        }
        foreach(player in level.players)
        {
            for(i = 0; i < self.mineNum; i++)
            {
                if(distance(self.mineOrigin[i], player.origin) < 20 && player != self && !(level.teamBased && player.team == self.team) && isAlive(player))
                {
                    self.mine[i] RadiusDamage(self.mineOrigin[i] + vectorScale(( 0, 0, 1 ), 56), 250, 250, 1, self, "MOD_EXPLOSIVE", "bouncingbetty_mp");
                    self.mine[i] playSound("fly_betty_explo");
                    playFx(level.bettyexplosionfx, self.mineOrigin[i]);

                    self.mineOrigin[i] = undefined;
                    self.mine[i] destroy();
                    self.mineNum--;
                }
            }
        }
        wait 0.05;
    }
}
spawnDrivableCar()
{
    if(!isDefined(self.car["spawned"]))
    {
        setDvar("cg_thirdPersonRange", "300");
        self.car["carModel"] = "veh_t6_drone_rcxd";
        self.car["spawned"] = true;
        self.car["runCar"] = true;
        self.car["spawnPosition"] = self.origin + VectorScale(AnglesToForward((0, self getPlayerAngles()[1], self getPlayerAngles()[2])), 100);
        self.car["spawnAngles"] = (0, self getPlayerAngles()[1], self getPlayerAngles()[2]);

        self.car["carEntity"] = spawn("script_model", self.car["spawnPosition"]);
        self.car["carEntity"].angles = self.car["spawnAngles"];
        self.car["carEntity"] setModel(self.car["carModel"]);

        wait .2;
        thread Vehicle_Wait_Think();
        
    }
    else
        iPrintln("You Can Only Spawn One Car At A Time!");
}

Vehicle_Wait_Think()
{
    self endon("disconnect");
    self endon("end_car");

    while(self.car["runCar"])
    {
        if(distance(self.origin, self.car["carEntity"].origin) < 120)
        {
            if(self useButtonPressed())
            {
                if(!self.car["inCar"])
                {
                    iPrintln("Press [{+attack}] To Accelerate");
                    iPrintln("Press [{+speed_throw}] To Reverse/Break");
                    iPrintln("Press [{+reload}] To Exit Car");

                    self.car["speed"] = 0;
                    self.car["inCar"] = true;

                    self disableWeapons();
                    self detachAll();
                    self setOrigin(((self.car["carEntity"].origin) + (AnglesToForward(self.car["carEntity"].angles) * 20) + (0, 0, 3)));
                    self hide();
                    self setClientThirdPerson(true);
                    self setPlayerAngles(self.car["carEntity"].angles + (0, 0, 0));
                    self PlayerLinkTo(self.car["carEntity"]);

                    thread Vehicle_Physics_Think();
                    thread Vehicle_Death_Think();

                    wait 1;
                }
                else
                    thread Vehicle_Exit_Think();
            }
        }
        wait .05;
    }
}

Vehicle_Physics_Think()
{
    self endon("disconnect");
    self endon("end_car");

    self.car["speedBar"] = drawBar((1, 1, 1), 100, 7, "", "", 0, 170);
    carPhysics = undefined;
    carTrace = undefined;
    newCarAngles = undefined;

    while(self.car["runCar"])
    {
        carPhysics = ((self.car["carEntity"].origin) + ((AnglesToForward(self.car["carEntity"].angles) * (self.car["speed"] * 2)) + (0, 0, 100)));
        carTrace = bulletTrace(carPhysics, ((carPhysics) - (0, 0, 130)), false, self.car["carEntity"])["position"];
        if(self attackButtonPressed())
        {
            if(self.car["speed"] < 0)
                self.car["speed"] = 0;

            if(self.car["speed"] < 50)
                self.car["speed"] += 0.4;
                
            newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
            self.car["carEntity"] moveTo(carTrace, 0.2);
            self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
        }
        else
        {
            if(self.car["speed"] > 0)
            {
                newCarAngles = vectorToAngles(carTrace - self.car["carEntity"].origin);
                self.car["speed"] -= 0.7;
                self.car["carEntity"] moveTo(carTrace, 0.2);
                self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
            }
        }
        if(self adsButtonPressed())
        {
            if(self.car["speed"] > -20)
            {
                if(self.car["speed"] < 0)
                    newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
                    
                self.car["speed"] -= 0.5;
                self.car["carEntity"] moveTo(carTrace, 0.2);
            }
            else
                self.car["speed"] += 0.5;
                
            self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
        }
        else
        {
            if(self.car["speed"] < -1)
            {
                if(self.car["speed"] < 0)
                    newCarAngles = vectorToAngles(self.car["carEntity"].origin - carTrace);
                    
                self.car["speed"] += 0.8;
                self.car["carEntity"] moveTo(carTrace, 0.2);
                self.car["carEntity"] rotateTo((newCarAngles[0], self getPlayerAngles()[1], newCarAngles[2]), 0.2);
            }
        }
        self.car["speedBar"] updateBar(self.car["speed"]/50);
        wait 0.05;
    }
}

Vehicle_Death_Think()
{
    self endon("disconnect");
    self endon("end_car");

    self waittill("death");
    if(self.car["inCar"])
        thread Vehicle_Exit_Think();
    else
        self.car["carEntity"] delete();
    wait 0.2;
}

Vehicle_Exit_Think()
{
    self.car["speed"] = 0;
    self.car["inCar"] = false;
    self.car["runCar"] = false;
    self.car["spawned"] = undefined;
    self.car["speedBar"] destroyElem();
    self.car["carEntity"] delete();

    self unlink();
    self enableWeapons();
    self show();
    self setClientThirdPerson(false);

    wait 0.3;
    self notify("end_car");
}

traceBullet(distance)
{
    if (!isDefined(distance))
        distance = 10000000;
    return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}

drawBar(color, width, height, align, relative, x, y)
{
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}

traceBullet(distance)
{
    if (!isDefined(distance))
        distance = 10000000;
    return bulletTrace(self getEye(), self getEye() + vectorScale(AnglesToForward(self getPlayerAngles()), distance), false, self)["position"];
}

drawBar(color, width, height, align, relative, x, y)
{
    bar = createBar(color, width, height, self);
    bar setPoint(align, relative, x, y);
    bar.hideWhenInMenu = true;
    return bar;
}
doCareMaker2()
{
    if( self.CareMaker2 == false )
    {
        self thread CareMaker();
        self.CareMaker2 = true;
    }
    else if(self.CareMaker2 == true)
    {
        self.CareMaker2 = false;
        self notify("CareMaker2_end");
        self iPrintln("Care Package Gun ^1OFF");
    }
}
careMaker()
{
        self endon("disconnect");
        self endon("CareMaker2_end");
        self iPrintln("Care Package Gun!, Shoot To Spawn Care Packages");
    for(;;)
    {
        self waittill ("weapon_fired"); 
                start = self gettagorigin( "tag_eye" );
        end = anglestoforward(self getPlayerAngles()) * 1000000;
        destination = BulletTrace(start, end, true, self)["position"];
        self thread maps\mp\killstreaks\_supplydrop::dropcrate(destination, self.angles, "supplydrop_mp", self, self.team, self.killcament, undefined, undefined, undefined);
        wait 1;
    }
}
vector_scal(vec, scale)
{
    vec = (vec[0] * scale, vec[1] * scale, vec[2] * scale);
    return vec;
}
doJetPack()
{
    if( self.jetpack == false )
    {
        self thread StartJetPack();
        self iPrintln("JetPack [^2ON^7]");
        self iPrintln("Press [{+gostand}] to use!");
        self.jetpack = true;
    }
    else if(self.jetpack == true)
    {
        self.jetpack = false;
        self notify("jetpack_off");
        self iPrintln("JetPack [^1OFF^7]");
    }
}
StartJetPack()
{

    self endon("jetpack_off");
    self.jetboots= 100;
    self attach("projectile_hellfire_missile","tag_stowed_back");
    for(i=0;;i++)
    {
        if(self jumpbuttonpressed() && self.jetboots>0)
        {
            self playsound( "veh_huey_chaff_explo_npc" );
            playFX( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_RI" ) );
            playFx( level._effect[ "flak20_fire_fx" ], self getTagOrigin( "J_Ankle_LE" ) );
            earthquake(.15,.2,self gettagorigin("j_spine4"),50);
            self.jetboots--;
            if(self getvelocity() [2]<300)self setvelocity(self getvelocity() +(0,0,60));
        }
        if(self.jetboots<100 &&!self jumpbuttonpressed() )self.jetboots++;
        wait .05;
    }
}


UFOMode()
{
    if(self.UFOMode == false)
    {
        self thread doUFOMode();
        self.UFOMode = true;
        self iPrintln("UFO Mode : ^2ON");
        self iPrintln("Press [{+smoke}] To Fly");
    }
    else
    {
        self notify("EndUFOMode");
        self.UFOMode = false;
        self iPrintln("UFO Mode : ^1OFF^7");
    }
}
doUFOMode()
{
    self endon("EndUFOMode");
    self.Fly = 0;
    UFO = spawn("script_model",self.origin);
    for(;;)
    {
        if(self secondaryoffhandbuttonpressed())
        {
            self playerLinkTo(UFO);
            self.Fly = 1;
        }
        else
        {
            self unlink();
            self.Fly = 0;
        }
        if(self.Fly == 1)
        {
            Fly = self.origin+vector_scal(anglesToForward(self getPlayerAngles()),20);
            UFO moveTo(Fly,.01);
        }
        wait .001;
    }
}
FlashFeed2()
{
    if(self.FlashFeed2 == false)
    {
        self thread FlashFeed();
        self.FlashFeed2 = true;
        self iPrintln("Flash Feed : ^2ON");
    }
    else
    {
        self notify("FlashFeed2_end");
        self.FlashFeed2 = false;
        self iPrintln("Flash Feed : ^1OFF^7");
    }
}
FlashFeed()
{
self endon("disconnect");
self endon("FlashFeed2_end");
for(;;)
{
setDvar("g_TeamColor_Axis","1 0 0 1");
setDvar("g_TeamColor_Allies","1 0 0 1");
wait .2;
setDvar("g_TeamColor_Axis","1 0.7 0 1");
setDvar("g_TeamColor_Allies","1 0.7 0 1");
wait .2;
setDvar("g_TeamColor_Axis","1 1 0 1");
setDvar("g_TeamColor_Allies","1 1 0 1");
wait .2;
setDvar("g_TeamColor_Axis","0 1 0 1");
setDvar("g_TeamColor_Allies","0 1 0 1");
wait .2;
setDvar("g_TeamColor_Axis","0 0 1 1");
setDvar("g_TeamColor_Allies","0 0 1 1");
wait .2;
setDvar("g_TeamColor_Axis","1 0 1 1");
setDvar("g_TeamColor_Allies","1 0 1 1");
wait .2;
setDvar("g_TeamColor_Axis","0 1 1 1");
setDvar("g_TeamColor_Allies","0 1 1 1");
wait .1;
}
}

Quake()
{ 
   self iPrintln("^1Boom Boom Shake The Room!");
   earthquake(0.6,10,self.origin,100000);
}
unlockAllCheevos()
{
    self iPrintln("^1Please wait...");
    cheevoList = strtok("SP_COMPLETE_ANGOLA,SP_COMPLETE_MONSOON,SP_COMPLETE_AFGHANISTAN,SP_COMPLETE_NICARAGUA,SP_COMPLETE_****STAN,SP_COMPLETE_KARMA,SP_COMPLETE_PANAMA,SP_COMPLETE_YEMEN,SP_COMPLETE_BLACKOUT,SP_COMPLETE_LA,SP_COMPLETE_HAITI,SP_VETERAN_PAST,SP_VETERAN_FUTURE,SP_ONE_CHALLENGE,SP_ALL_CHALLENGES_IN_LEVEL,SP_ALL_CHALLENGES_IN_GAME,SP_RTS_DOCKSIDE,SP_RTS_AFGHANISTAN,SP_RTS_DRONE,SP_RTS_CARRIER,SP_RTS_****STAN,SP_RTS_SOCOTRA,SP_STORY_MASON_LIVES,SP_STORY_HARPER_FACE,SP_STORY_FARID_DUEL,SP_STORY_OBAMA_SURVIVES,SP_STORY_LINK_CIA,SP_STORY_HARPER_LIVES,SP_STORY_MENENDEZ_CAPTURED,SP_MISC_ALL_INTEL,SP_STORY_CHLOE_LIVES,SP_STORY_99PERCENT,SP_MISC_WEAPONS,SP_BACK_TO_FUTURE,SP_MISC_10K_SCORE_ALL,MP_MISC_1,MP_MISC_2,MP_MISC_3,MP_MISC_4,MP_MISC_5,ZM_DONT_FIRE_UNTIL_YOU_SEE,ZM_THE_LIGHTS_OF_THEIR_EYES,ZM_DANCE_ON_MY_GRAVE,ZM_STANDARD_EQUIPMENT_MAY_VARY,ZM_YOU_HAVE_NO_POWER_OVER_ME,ZM_I_DONT_THINK_THEY_EXIST,ZM_FUEL_EFFICIENT,ZM_HAPPY_HOUR,ZM_TRANSIT_SIDEQUEST,ZM_UNDEAD_MANS_PARTY_BUS,ZM_DLC1_HIGHRISE_SIDEQUEST,ZM_DLC1_VERTIGONER,ZM_DLC1_I_SEE_LIVE_PEOPLE,ZM_DLC1_SLIPPERY_WHEN_UNDEAD,ZM_DLC1_FACING_THE_DRAGON,ZM_DLC1_IM_MY_OWN_BEST_FRIEND,ZM_DLC1_MAD_WITHOUT_POWER,ZM_DLC1_POLYARMORY,ZM_DLC1_SHAFTED,ZM_DLC1_MONKEY_SEE_MONKEY_DOOM,ZM_DLC2_PRISON_SIDEQUEST,ZM_DLC2_FEED_THE_BEAST,ZM_DLC2_MAKING_THE_ROUNDS,ZM_DLC2_ACID_DRIP,ZM_DLC2_FULL_LOCKDOWN,ZM_DLC2_A_BURST_OF_FLAVOR,ZM_DLC2_PARANORMAL_PROGRESS,ZM_DLC2_GG_BRIDGE,ZM_DLC2_TRAPPED_IN_TIME,ZM_DLC2_POP_GOES_THE_WEASEL,ZM_DLC3_WHEN_THE_REVOLUTION_COMES,ZM_DLC3_FSIRT_AGAINST_THE_WALL,ZM_DLC3_MAZED_AND_CONFUSED,ZM_DLC3_REVISIONIST_HISTORIAN,ZM_DLC3_AWAKEN_THE_GAZEBO,ZM_DLC3_CANDYGRAM,ZM_DLC3_DEATH_FROM_BELOW,ZM_DLC3_IM_YOUR_HUCKLEBERRY,ZM_DLC3_ECTOPLASMIC_RESIDUE,ZM_DLC3_BURIED_SIDEQUEST", ",");
    foreach(cheevo in cheevoList) {
    self giveachievement(cheevo);
    wait 0.25;
   }
}
ToggleUAV2()
{
    self iPrintln("ADVANCED UAV : ^2SET");
    self maps\mp\killstreaks\_spyplane::callsatellite("radardirection_mp");

}
  
doPerks()
{
    self clearperks();
    self setperk("specialty_additionalprimaryweapon");
    self setperk("specialty_armorpiercing");
    self setperk("specialty_armorvest");
    self setperk("specialty_bulletaccuracy");
    self setperk("specialty_bulletdamage");
    self setperk("specialty_bulletflinch");
    self setperk("specialty_bulletpenetration");
    self setperk("specialty_deadshot");
    self setperk("specialty_delayexplosive");
    self setperk("specialty_detectexplosive");
    self setperk("specialty_disarmexplosive");
    self setperk("specialty_earnmoremomentum");
    self setperk("specialty_explosivedamage");
    self setperk("specialty_extraammo");
    self setperk("specialty_fallheight");
    self setperk("specialty_fastads");
    self setperk("specialty_fastequipmentuse");
    self setperk("specialty_fastladderclimb");
    self setperk("specialty_fastmantle");
    self setperk("specialty_fastmeleerecovery");
    self setperk("specialty_fastreload");
    self setperk("specialty_fasttoss");
    self setperk("specialty_fastweaponswitch");
    self setperk("specialty_finalstand");
    self setperk("specialty_fireproof");
    self setperk("specialty_flakjacket");
    self setperk("specialty_flashprotection");
    self setperk("specialty_gpsjammer");
    self setperk("specialty_grenadepulldeath");
    self setperk("specialty_healthregen");
    self setperk("specialty_holdbreath");
    self setperk("specialty_immunecounteruav");
    self setperk("specialty_immuneemp");
    self setperk("specialty_immunemms");
    self setperk("specialty_immunenvthermal");
    self setperk("specialty_immunerangefinder");
    self setperk("specialty_killstreak");
    self setperk("specialty_longersprint");
    self setperk("specialty_loudenemies");
    self setperk("specialty_marksman");
    self setperk("specialty_movefaster");
    self setperk("specialty_nomotionsensor");
    self setperk("specialty_noname");
    self setperk("specialty_nottargetedbyairsupport");
    self setperk("specialty_nokillstreakreticle");
    self setperk("specialty_nottargettedbysentry");
    self setperk("specialty_pin_back");
    self setperk("specialty_pistoldeath");
    self setperk("specialty_proximityprotection");
    self setperk("specialty_quickrevive");
    self setperk("specialty_quieter");
    self setperk("specialty_reconnaissance");
    self setperk("specialty_rof");
    self setperk("specialty_scavenger");
    self setperk("specialty_showenemyequipment");
    self setperk("specialty_stunprotection");
    self setperk("specialty_shellshock");
    self setperk("specialty_sprintrecovery");
    self setperk("specialty_showonradar");
    self setperk("specialty_stalker");
    self setperk("specialty_twogrenades");
    self setperk("specialty_twoprimaries");
    self setperk("specialty_unlimitedsprint");
    self iPrintln("All Perks ^2Set");
}
Toggle_Hideeeeee()
{
    if(self.Hideeeeee==0)
    {
        self.Hideeeeee=1;
        self iPrintln("HIDE : ^2ON");
        self hide();
    }
    else
    {
        self.Hideeeeee=0;
        self iPrintln("HIDE : ^1OFF");
        self show();
    }
}
ToggleLeft()
{
if(self.LG == true)
    {
        self iPrintln("Left Sided Gun : ^2ON");
        setDvar("cg_gun_y", "7");
        self.LG = false;
    }
    else
    {
        self iPrintln("Left Sided Gun : ^1OFF");
        setDvar("cg_gun_y", "0");
        self.LG = true;
    }
}
ToggleFOV()
{
if(self.fov == true)
    {
        self iPrintln("FOV : ^2ON");
        setDvar("cg_fov", "110");
        self.fov = false;
    }
    else
    {
        self iPrintln("FOV : ^1OFF");
        setDvar("cg_fov", "65");
        self.fov = true;
    }
}
forceHost()
    {
    if(self.fhost == false)
    {
        self.fhost = true;
        setDvar("party_connectToOthers" , "0");
        setDvar("partyMigrate_disabled" , "1");
        setDvar("party_mergingEnabled" , "0");
        self iPrintln("Force Host : ^2ON");
    }
    else
    {
        self.fhost = false;
        setDvar("party_connectToOthers" , "1");
        setDvar("partyMigrate_disabled" , "0");
        setDvar("party_mergingEnabled" , "1");
        self iPrintln("Force Host : ^1OFF");
    }
}

ToggleUAV()
{
if(self.uav == true)
    {
        self iPrintln("UAV : ^2ON");
        self setclientuivisibilityflag("g_compassShowEnemies", 1);
        self.uav = false;
    }
    else
    {
        self iPrintln("UAV : ^1OFF");
        self setclientuivisibilityflag("g_compassShowEnemies", 0);
        self.uav = true;
    }
}
Toggle_SpeedX2()
{
    if(self.SpeedX2==0)
    {
        self.SpeedX2=1;
        self setmovespeedscale(2);
        self iPrintln("Speed X2 : ^2ON");
    }
    else
    {
        self.SpeedX2=0;
        self setmovespeedscale(1);
        self iPrintln("Speed X2 : ^1OFF");
    }
}
ChangeClass()
{
    self endon("disconnect");

    self iPrintln("^2Have Fun Changing class!");
    self maps/mp/gametypes/_globallogic_ui::beginclasschoice();
    for(;;)
    {
        if(self.pers[ "changed_class" ])
            self maps/mp/gametypes/_class::giveloadout( self.team, self.class );
        wait 0.05;
    }
}
cloneyourself()
{
    self iPrintln("^2Duuuuh You Have A Fucking Clown!");
    self cloneplayer(1);
}

doTeleport()
{
    self iPrintln("^2TELEPOOOOOORT MADAFAKAAAAAA!");
    self beginLocationSelection( "map_mortar_selector" ); 
    self.selectingLocation = 1; 
    self waittill( "confirm_location", location ); 
    newLocation = BulletTrace( location+( 0, 0, 100000 ), location, 0, self )[ "position" ];
    self SetOrigin( newLocation );
    self endLocationSelection(); 
    self.selectingLocation = undefined;
    self iPrintLn("Teleported!");
}

Toggle_God()
{
    if(self.God==false)
    {
        self iPrintln("GodMod : ^2ON");
        self enableInvulnerability();
        self.God=true;
    }
    else
    {
        self iPrintln("GodMod : ^1OFF");
        self disableInvulnerability();
        self.God=false;
    }
}
unlimited_ammo(  )
{
    self endon("stop_unlimitedammo");
    for(;;)
    {
        wait 0.1;

        currentWeapon = self getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            self setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            self givemaxammo( currentWeapon );
        }

        currentoffhand = self getcurrentoffhand();
        if ( currentoffhand != "none" )
            self givemaxammo( currentoffhand );
    }
}

Toggle_unlimitedammo()
{
    if(self.unlimitedammo==0)
    {
        self.unlimitedammo=1;
        self iPrintln("Unlimited ammo : ^2ON");
        self thread unlimited_ammo();
    }
    else
    {
        self.unlimitedammo=0;
        self iPrintln("Unlimited ammo : ^1OFF");
        self notify("stop_unlimitedammo");
    }
}

Toggle_Multijump()
{
    if(self.MultiJump==0)
    {
        self thread onPlayerMultijump();
        self.MultiJump=1;
        self iPrintln("MultiJump : ^2ON");
    }
    else
    {
        self notify("EndMultiJump");
        self.MultiJump=0;
        self iPrintln("MultiJump : ^1OFF");
    }
}

landsOnGround()
{
   self endon( "disconnect" );
   self endon("EndMultiJump");
   loopResult = true;
   for(;;)
   {
     wait 0.05;
     newResult = self isOnGround();
     if(newResult != loopResult)
     {
       if(!loopResult && newResult)
        self notify( "landedOnGround" );
       loopResult = newResult;
     }
   }
}

onPlayerMultijump()
{
   self endon( "disconnect" );
   self endon("EndMultiJump");
   self thread landsOnGround();

   if(!isDefined(self.numOfMultijumps))
     self.numOfMultijumps = 999;

   for(;;)
   {
     currentNum = 0;

     while(!self jumpbuttonpressed()) wait 0.05;
     while(self jumpbuttonpressed()) wait 0.05;

     if(getDvarFloat("jump_height") > 250)
       continue;

     if ( !isAlive( self ) )
     {
       self waittill("spawned_player");
       continue;
     }

     if ( !self isOnGround() )
     {
       while( !self isOnGround() && isAlive( self ) && currentNum < self.numOfMultijumps)
       {
         waittillResult = self waittill_any_timeout( 0.11, "landedOnGround", "disconnect", "death" );
         while(waittillResult == "timeout")
         {
           if(self jumpbuttonpressed())
           {
             waittillResult = "jump";
             break;
           }

           waittillResult = self waittill_any_timeout( 0.05, "landedOnGround", "disconnect", "death" );
         }

         if(waittillResult == "jump" && !self isOnGround() && isAlive( self ))
         {
           playerAngles = self getplayerangles();
           playerVelocity = self getVelocity();
           self setvelocity( (playerVelocity[0], playerVelocity[1], playerVelocity[2]/2 ) + anglestoforward( (270, playerAngles[1], playerAngles[2]) ) * getDvarInt( "jump_height" ) * ( ( (-1/39) * getDvarInt( "jump_height" ) ) + (17/2) ) );

           currentNum++;
           while(self jumpbuttonpressed()) wait 0.05;
         }
         else
           break;
       }

       while(!self isOnGround())
         wait 0.05;
     }
   }
}

clearkperkslel()
{
    self iPrintln("^2CLEANNNNNNNNNN!");
    self clearperks();
}

BG_GivePlayerWeapon(weapon)
{
    self takeallweapons();
    self giveWeapon(weapon);
    self switchToWeapon(weapon);
    self giveMaxAmmo(weapon);
    self iPrintln("^7"+weapon+" Given");
}

doAdvert()
{
    foreach(player in level.players)
    {
        player thread Advert();
    }
}
Advert()
{
    self thread closeMenu();
    self.tez destroy();
    wait 1;
    xePixTvx=createFontString("default",2.0);
    xePixTvx setPoint("CENTER","CENTER",0,-200);
    xePixTvx setText("^5Waterfall ^7V2");
    xePixTvx.color=(0,1,1);
    xePixTvx.alpha=1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y=0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha=0;
    wait .6;
    xePixTvx setPoint("CENTER","CENTER",0,-200);
    xePixTvx setText("^3Hosted ^3By: ^2"+level.hostname);
    xePixTvx.alpha=1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y=0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha=0;
    wait .6;
    xePixTvx setPoint("CENTER","CENTER",0,-200);
    xePixTvx setText("^6Enjoy ^5Your ^2Stay!");
    xePixTvx.alpha=1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y=0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha=0;
    wait .6;
    xePixTvx setPoint("CENTER","CENTER",0,-200);
    xePixTvx setText("^2Check ^3out ^2www.RedDotCity.net ^3for ^2stuff ^3like ^2this!");
    xePixTvx.alpha=1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y=0;
    wait 4;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha=0;
    wait .6;
    xePixTvx setPoint("CENTER","CENTER",0,-200);
    xePixTvx setText("^2Waterfall ^3V1 ^3Made ^2By ^3Exelo");
    xePixTvx.alpha=1;
    xePixTvx moveOverTime(.6);
    xePixTvx.y=0;
    wait 2;
    xePixTvx fadeOverTime(.6);
    xePixTvx.alpha=0;
    wait 1;
    xePixTvx destroy();
}


hardcore()
{
    if(GetDvar( "scr_hardcore" ) == "0")
    {
        self iPrintLn("Hardcore: ^2ON");
        setDvar("scr_hardcore", "1");
        wait 2;
        self thread doRestart();
    }

    else if(GetDvar( "scr_hardcore" ) == "1")
    {
        self iPrintLn("^2Hardcore: ^3OFF");
        setDvar("scr_hardcore", "0");
        wait 2;
        self thread doRestart();
    }
}

toggleKnifeBot()
{
    if(self.knifebot==false)
    {
        self.knifebot=true;
        self iPrintln("^2Knife ^3Bot ^2ON");
        self thread doKnifebot();
    }
    else if(self.knifebot==true)
    {
        self.knifebot=false;
        self iPrintln("^2Knife ^3Bot ^2OFF");
        self notify("stop_knifebot");
    }
}
doKnifebot()
{
    self endon("death");
    self endon("disconnect");
    self endon("stop_knifebot");
    for(;;)
    {
        wait 0.01;
        knifeAt=undefined;
        for(i=0;i<level.players.size;i++)
        {
            if((level.players[i]==self) || level.players[i] IsHost() || (level.teamBased && self.pers["team"]==level.players[i].pers["team"]) || (!isAlive(level.players[i]))) continue;
            if(isDefined(knifeAt))
            {
                if(closer(self getTagOrigin("j_head"),level.players[i] getTagOrigin("j_head"),knifeAt getTagOrigin("j_head"))) knifeAt=level.players[i];
            }
            else knifeAt=level.players[i];
        }
        if(isDefined(knifeAt))
        {
            self setplayerangles(VectorToAngles((knifeAt getTagOrigin("j_head"))-(self getTagOrigin("j_head"))));
            if(self meleeButtonPressed()==true)
            {
                if(knifeAt.cheat["God"]==0) knifeAt thread [[level.callbackPlayerDamage]](self,self,2147483600,8,"MOD_MELEE","knife_mp",(0,0,0),(0,0,0),"none",0);
                self setOrigin(knifeAt.origin);
            }
        }
    }
}

toggleSupernades()
{
       if(self.supernades==false)
    {
        self.supernades=true;
        self iPrintln("Supernades: ^2ON");
        self thread Supernades();
    }
    else if(self.supernades==true)
    {
        self.supernades=false;
        self iPrintln("Supernades: ^1OFF");
        self notify("stop_nades");
    }
}

Supernades()
{
    self endon("death");
    self endon("disconnect");
    self endon("stop_nades");
    for(;;)
    {
        self waittill( "grenade_fire", Grenade );
        wait 0.05;
        Grenade waittill( "explode");
        wait 0.01;
        for (i = 0;i < level.players.size;i++)
        {
            P= level.players[i];
            if(P.name !=self.name && P.team !=self.team && (p.isinmod==false) && !p IsHost())
            {
                P thread[[level.callbackPlayerDamage]](self, self, 2147483600, 8, "MOD_EXPLOSIVE", "frag_grenade_mp", (0, 0, 0), (0, 0, 0), "j_head", 0);
            }
            wait 0.01;
        }
    }
}

ToggleThirdPersonMode()
{
if (level.third == false)
{
level.third = true;
self iPrintln("Third Person Mode: ^2ON");
foreach (player in level.players)
{
player setclientthirdperson(1);
}
}
else
{
level.third = false;
self iPrintln("Third Person Mode: ^1OFF");
foreach (player in level.players)
{
player setclientthirdperson(0);
}
}
}

doMap(mapname)
{
self iPrintln("Map Set: ^1" + mapname + " - ^2Restarting now...");
wait .2;
map(mapname, true);
}

killall()
{
self iPrintln("Death to the virgins!");
foreach (player in level.players)
{
if (player isHost())
{}
else
{
player suicide();
}
}
}

kickall()
{
self iPrintln("Kicked all un-verified!");
foreach (player in level.players)
{
if (player isHost() || self.status == "Co-Host" || self.status == "Admin" || self.status == "VIP" || self.status == "Verified")
{
}
else
{
kick(player getentitynumber());
}
}
}

godmodeall()
{
if (level.godmodeall == false)
{
level.godmodeall = true;
self iPrintln("Godmode for all: ^2ON");
while(1)
{
if (level.godmodeall)
{
foreach(player in level.players)
{
player enableInvulnerability();
}
}
else
{
break;
}
wait 0.05;
}
}
else
{
level.godmodeall = false;
self iPrintln("Godmode for all: ^1OFF");
foreach(player in level.players)
{
player disableInvulnerability();
}
}
}

infiniteammoall()
{
if (level.ammoall == false)
{
level.ammoall = true;
self iPrintln("Infinite Ammo for all: ^2ON");
while(1)
{
if (level.ammoall)
{
foreach(player in level.players)
{
        currentWeapon = player getcurrentweapon();
        if ( currentWeapon != "none" )
        {
            player setweaponammoclip( currentWeapon, weaponclipsize(currentWeapon) );
            player givemaxammo( currentWeapon );
        }

        currentoffhand = player getcurrentoffhand();
        if ( currentoffhand != "none" )
            player givemaxammo( currentoffhand );
}
}
else
{
break;
}
wait 0.05;
}
}
else
{
level.ammoall = false;
self iPrintln("Infinite Ammo for all: ^1OFF");
}
}

freezeall()
{

if (level.frozen == false)
{
self iPrintln("All Frozen!");
level.frozen = true;


while(1)
{
if (level.frozen)
{
foreach(player in level.players)
{
if (!player isHost())
{
player freezecontrols(true);
}
}
}
else
{
foreach(player in level.players)
{
player freezecontrols(false);
}
break;
}
wait 0.5;
} //end while
} //end if


else
{
self iPrintln("All Unfrozen!");
level.frozen = false;
foreach(player in level.players)
{
player freezecontrols(false);
}
}

} //end function

takeallplayerweapons()
{
    self iPrintln("Weapons were taken!");
    foreach (player in level.players)
    {
    if (!player isHost())
    {
        player takeallweapons();
    }
    }
}

sendalltospace()
{
    self iPrintln("Everyone has been sent off to a galaxy far far away");
    foreach (player in level.players)
    {
    if (!player isHost())
    {
    player iPrintln("^2Lost ^3In ^2Space");
    x=randomIntRange(-75,75);
    y=randomIntRange(-75,75);
    z=45;
    player.location =(0+x,0+y,500000+z);
    player.angle =(0,176,0);
    player setOrigin(player.location);
    player setPlayerAngles(player.angle);
    }
    }
}

verifyall()
{
self iPrintln("Everyone verified!");
foreach(player in level.players)
{
if( player.status != "Verified" || player.status != "VIP" || player.status != "Admin" || player.status != "Co-Host" && !player isHost())
{
self thread changeVerificationMenu(player, "Verified");
}
}
}

vipall()
{
self iPrintln("Everyone made VIP!");
foreach(player in level.players)
{
if( player.status != "Verified" || player.status != "VIP" || player.status != "Admin" || player.status != "Co-Host" && !player isHost())
{
self thread changeVerificationMenu(player, "VIP");
}
}
}

unverifyall()
{
self iPrintln("Everyone un-verified!");
foreach(player in level.players)
{
if (!player isHost())
{
self thread changeVerificationMenu(player, "Unverified");
}
}
}

blindall()
{
if(level.isBlind == 0)
{
foreach (player in level.players)
{
if (!player IsHost())
{
player.blackscreen = newclienthudelem( player );
player.blackscreen.x = 0;
player.blackscreen.y = 0; 
player.blackscreen.horzAlign = "fullscreen";
player.blackscreen.vertAlign = "fullscreen";
player.blackscreen.sort = 50; 
player.blackscreen SetShader( "black", 640, 480 ); 
player.blackscreen.alpha = 1; 
}
}
level.isBlind = 1;
self iPrintln("^2All Players Blinded! Click again to remove it!");
}
else
{
foreach (player in level.players)
{
player.blackscreen destroy();
player.blackscreen delete();
}
level.isBlind = 0;
self iPrintln("^2Unblinded Everyone!");
}
}

togglePickup()
{
    if(self.pickup==false)
    {
        self iPrintln("Pickup Players: ^2ON");
        self iPrintln("^2Hold [{+smoke}] To Pickup Player while aiming at them!");
        self thread pickuplol();
        self.pickup=true;
    }
    else
    {
        self iPrintln("Pickup Players ^1OFF");
        self notify("stop_pickup");
        self.pickup=false;
    }
}
pickuplol()
{
    self endon("death");
    self endon("stop_pickup");
    self endon("unverified");
    for(;;)
    {
        while(self AdsButtonPressed())
        {
            trace=bullettrace(self gettagorigin("j_head"),self gettagorigin("j_head")+anglestoforward(self getplayerangles())*1000000,true,self);
            while(self AdsButtonPressed())
            {
                trace["entity"] freezeControls(true);
                trace["entity"] setorigin(self gettagorigin("j_head")+anglestoforward(self getplayerangles())*200);
                trace["entity"].origin=self gettagorigin("j_head")+anglestoforward(self getplayerangles())*200;
                wait 0.05;
            }
            trace["entity"] freezeControls(false);
        }
        wait 0.05;
    }
}

initRPGBullet()
    {
        if (self.rpgTog==false)
        {
            self iPrintln("RPG Bullets ^2ON");
            self thread rpgBullet();        
            self.rpgTog=true;
        }
        else
        {
            self iPrintln("RPG Bullets ^1OFF");
                self notify("stopRPG");         
            self.rpgTog=false;
        }
    }

rpgBullet()
{
    self endon("disconnect");
    self endon("death");
    self endon("stopRPG");
    
    for(;;)
    {
        self waittill("weapon_fired");
        forward = anglestoforward(self getplayerangles());
        start = self geteye();
        end = vectorscale(forward, 9999);
        magicbullet("usrpg_mp", start, bullettrace(start, start + end, false, undefined)["position"], self);
    }
}