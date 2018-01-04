018-3.gat,67,28,0|script|Obelisk|185,{
    if ($@Obelisk_Status != 0) goto L_Close;

    mes "A mystical aura surrounds this stone. You see a lot of money around it.";
    next;
    menu
        "Touch the stone.", -,
        "Don't touch it.", L_Close;
    if (getareausers("018-3.gat", 20, 20, 77, 37) > 1)
        set @obelisk_players$, getareausers("018-3.gat", 20, 20, 77, 37) - 1 + " player(s).";
    if (getareausers("018-3.gat", 20, 20, 77, 37) <= 1)
        set @obelisk_players$, "no one else.";
    mes "As you approach the stone, it starts to react in a strange way. It seems dangerous. You look around and see " + @obelisk_players$;
    next;
    menu
        "Touch the stone anyway.", L_Start,
        "Don't touch it.", L_Close;    

L_Start:
    if ($@Obelisk_Status != 0) goto L_Close;
    set $@Obelisk_Status, 1;
    set $@Obelisk_Level, 0;
    set $@Obelisk_Selected, 0;
    set $@Obelisk_Alive, getareausers("018-3.gat", 20, 20, 77, 37);
    set $@Obelisk_Random_Player, rand(1, $@Obelisk_Alive);
    pvpon "018-3.gat";
    startnpctimer;
    areatimer "018-3.gat", 20, 20, 77, 37, 10, "Obelisk::OnPlayerCheck";
    close;

OnPlayerCheck:
    if (isdead())
        end;
    set $@Obelisk_Level, $@Obelisk_Level + Baselevel;
    set $@Obelisk_Selected, $@Obelisk_Selected + 1;
    set Zeny, Zeny + 50 + @Obelisk_Kills;
    set @Obelisk_Kills, 0;
    if ($@Obelisk_Selected == $@Obelisk_Random_Player)
        goto L_Chosen;
    if ($@Obelisk_Selected >= $@Obelisk_Alive)
        goto L_PreSummon;
    end;

L_PreSummon:
    set $@Obelisk_Mob_Points, $@Obelisk_Level + $@Obelisk_Alive * 10;

L_Summon:
    if ($@Obelisk_Mob_Points >= 500)
        goto L_MOB1;
    if ($@Obelisk_Mob_Points >= 300)
        goto L_MOB2;
    if ($@Obelisk_Mob_Points >= 100)
        goto L_MOB3;
    if ($@Obelisk_Mob_Points >= 50)
        goto L_MOB4;
    if ($@Obelisk_Mob_Points >= 10)
        goto L_MOB5;
    if (rand(5) == 0)
        goto L_PreSummonBoss;
    end;

L_PreSummonBoss:
    setarray $@Obelisk_Random_Boss, 1036, 1045, 1022, 1072, 1062;
    areamonster "018-3.gat",$@x1,$@y1,$@x2,$@y2,"",$@Obelisk_Random_Boss[rand(5)],1,"Obelisk::OnRandomBossDeath";
    end;

L_MOB1:
    areamonster "018-3.gat",$@x1,$@y1,$@x2,$@y2,"",1034,1,"Obelisk::OnMob1Death";
    set $@Obelisk_Mob_Points, $@Obelisk_Mob_Points - 500;
    goto L_Summon;

L_MOB2:
    areamonster "018-3.gat",$@x1,$@y1,$@x2,$@y2,"",1026,1,"Obelisk::OnMob2Death";
    set $@Obelisk_Mob_Points, $@Obelisk_Mob_Points - 300;
    goto L_Summon;

L_MOB3:
    areamonster "018-3.gat",$@x1,$@y1,$@x2,$@y2,"",1012,1,"Obelisk::OnMob3Death";
    set $@Obelisk_Mob_Points, $@Obelisk_Mob_Points - 100;
    goto L_Summon;

L_MOB4:
    areamonster "018-3.gat",$@x1,$@y1,$@x2,$@y2,"",1009,1,"Obelisk::OnMob4Death";
    set $@Obelisk_Mob_Points, $@Obelisk_Mob_Points - 50;
    goto L_Summon;

L_MOB5:
    areamonster "018-3.gat",$@x1,$@y1,$@x2,$@y2,"",1008,1,"Obelisk::OnMob5Death";
    set $@Obelisk_Mob_Points, $@Obelisk_Mob_Points - 10;
    goto L_Summon;

OnMob1Death:
    set @Obelisk_Kills, @Obelisk_Kills + 40;
    end;

OnMob2Death:
    set @Obelisk_Kills, @Obelisk_Kills + 35;
    end;

OnMob3Death:
    set @Obelisk_Kills, @Obelisk_Kills + 15;
    end;

OnMob4Death:
    set @Obelisk_Kills, @Obelisk_Kills + 10;
    end;

OnMob5Death:
    set @Obelisk_Kills, @Obelisk_Kills + 5;
    end;

OnRandomBossDeath:
    set @Obelisk_Kills, @Obelisk_Kills + 100;
    end;

OnTimer5000:
    set $@Obelisk_Alive, getareausers("018-3.gat", 20, 20, 77, 37);
    set $@Obelisk_Random_Player, rand(1, $@Obelisk_Alive);
    set $@Obelisk_Timer, $@Obelisk_Timer + 5;
    if ($@Obelisk_Timer > 50)
        goto L_Clean;
    areatimer "018-3.gat", 20, 20, 77, 37, 10, "Obelisk::OnPlayerCheck";
    goto L_ContinueTimer;

L_Chosen:
    set $@x1, getx()-4;
    set $@y1, gety()-4;
    set $@x2, $@x1 + 8;
    set $@y2, $@y1 + 8;
    specialeffect2 22;
    percentheal -5, 0;
    sc_start sc_poison, 1, 20;
    if ($@Obelisk_Selected >= $@Obelisk_Alive)
        goto L_PreSummon;
    end;

L_Clean:
    npctalk "The Evil Obelisk goes back to normal. For now.";
    killmonster "018-3.gat","Obelisk::OnMob1Death";
    killmonster "018-3.gat","Obelisk::OnMob2Death";
    killmonster "018-3.gat","Obelisk::OnMob3Death";
    killmonster "018-3.gat","Obelisk::OnMob4Death";
    killmonster "018-3.gat","Obelisk::OnMob5Death";
    killmonster "018-3.gat","Obelisk::OnRandomBossDeath";
    set $@Obelisk_Status, 0;
    set $@Obelisk_Timer, 0;
    set $@Obelisk_Alive, 0;
    set $@Obelisk_Level, 0;
    set $@Obelisk_Selected, 0;
    set $@Obelisk_Mob_Points, 0;
    set $@Obelisk_Random_Boss, 0;
    set $@Obelisk_Random_Player, 0;
    set $@x1, 0;
    set $@y1, 0;
    set $@x2, 0;
    set $@y2, 0;
    pvpoff "018-3.gat";
    stopnpctimer;
    setnpctimer 0;
    end;

OnPCKilledEvent:
    if (attachrid(@killerrid) == 0)
        end;
    percentheal 100, 0;
    set Zeny, Zeny + 100;
    end;

L_ContinueTimer:
    if ($@Obelisk_Selected == 0) goto L_Clean;
    set $@Obelisk_Selected, 0;
    set $@Obelisk_Level, 0;
    setnpctimer 0;
    end;

L_Close:
    set @obelisk_players$, "";
    close;
}