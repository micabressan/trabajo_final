-- Reunion
SET @GAME_EVENT_STAIRWAY := 83;
SET @GAME_EVENT_RACE_SIGNING := 84;
SET @GAME_EVENT_RACE_PRE_START := 85;
SET @GAME_EVENT_RACE_START := 86;
SET @GAME_EVENT_BG_ARENAS := 87;

SET @NPC_ARENA_MASTER := 340026;

SET @NPC_RACE_STARTER := 340027;
SET @NPC_RACE_MANAGER := 340028;
SET @NPC_RACE_CHECKPOINTER := 340029;

DELETE FROM `game_event` WHERE `eventEntry` IN (@GAME_EVENT_RACE_SIGNING,@GAME_EVENT_RACE_PRE_START,@GAME_EVENT_RACE_START,@GAME_EVENT_BG_ARENAS);
INSERT INTO `game_event` VALUES
(@GAME_EVENT_RACE_SIGNING,'2015-08-23 17:50:00','2025-08-23 19:00:00',525600,9,0,'Reunion - Race - Signing',0,2),
(@GAME_EVENT_RACE_PRE_START,'2015-08-23 17:59:00','2025-08-23 19:00:00',525600,1,0,'Reunion - Race - PreStart',0,2),
(@GAME_EVENT_RACE_START,'2015-08-23 18:00:00','2025-08-23 19:00:00',525600,120,0,'Reunion - Race - Start',0,2),
(@GAME_EVENT_BG_ARENAS,'2015-08-23 15:00:00','2025-08-23 19:00:00',525600,540,0,'Reunion - Arenas',0,2);

DELETE FROM `creature_template` WHERE `entry` IN (@NPC_ARENA_MASTER,@NPC_RACE_STARTER,@NPC_RACE_MANAGER,@NPC_RACE_CHECKPOINTER);
INSERT INTO `creature_template` (`entry`, `difficulty_entry_1`, `difficulty_entry_2`, `difficulty_entry_3`, `KillCredit1`, `KillCredit2`, `modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `rank`, `mindmg`, `maxdmg`, `dmgschool`, `attackpower`, `dmg_multiplier`, `baseattacktime`, `rangeattacktime`, `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`, `family`, `trainer_type`, `trainer_spell`, `trainer_class`, `trainer_race`, `minrangedmg`, `maxrangedmg`, `rangedattackpower`, `type`, `type_flags`, `lootid`, `pickpocketloot`, `skinloot`, `resistance1`, `resistance2`, `resistance3`, `resistance4`, `resistance5`, `resistance6`, `spell1`, `spell2`, `spell3`, `spell4`, `spell5`, `spell6`, `spell7`, `spell8`, `PetSpellDataId`, `VehicleId`, `mingold`, `maxgold`, `AIName`, `MovementType`, `InhabitType`, `HoverHeight`, `Health_mod`, `Mana_mod`, `Armor_mod`, `RacialLeader`, `questItem1`, `questItem2`, `questItem3`, `questItem4`, `questItem5`, `questItem6`, `movementId`, `RegenHealth`, `mechanic_immune_mask`, `flags_extra`, `ScriptName`, `VerifiedBuild`) VALUES 
(@NPC_ARENA_MASTER, 0, 0, 0, 0, 0, 26552, 0, 0, 0, 'Arena Master 1vs1', '', NULL, 0, 81, 81, 0, 35, 1, 1.2, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_arena_master', 12340),
(@NPC_RACE_STARTER, 0, 0, 0, 0, 0, 26552, 0, 0, 0, 'Race Starter', '', NULL, 0, 81, 81, 0, 35, 1, 1.2, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_race_starter', 12340),
(@NPC_RACE_MANAGER, 0, 0, 0, 0, 0, 26552, 0, 0, 0, 'Race Manager', '', NULL, 0, 81, 81, 0, 35, 1, 1.2, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_race_manager', 12340),
(@NPC_RACE_CHECKPOINTER, 0, 0, 0, 0, 0, 26552, 0, 0, 0, 'Race Checkpoint', '', NULL, 0, 81, 81, 0, 35, 1, 1.2, 1.14286, 1, 0, 2, 2, 0, 24, 1, 2000, 0, 1, 0, 2048, 8, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '', 0, 4, 1, 1.15, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 'npc_race_checkpoint', 12340);

SET @CGUID := 302798;
DELETE FROM `creature` WHERE `guid` BETWEEN  @CGUID AND @CGUID+15;
INSERT INTO `creature` VALUES 
(@CGUID, @NPC_RACE_MANAGER, 1, 1, 1, 0, 0, -1081.792603, -4271.870605, 18.817240, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+1, @NPC_RACE_MANAGER, 1, 1, 1, 0, 0, -7142.359863, -3790.538330, 8.504112, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+2, @NPC_RACE_STARTER, 1, 1, 1, 0, 0, 10329.947266, 827.504700, 1326.363892, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+3, @NPC_RACE_STARTER, 0, 1, 1, 0, 0, -8927.449219, -127.765953, 81.836998, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+4, @NPC_RACE_STARTER, 0, 1, 1, 0, 0, -6232.356445, 345.015015, 383.513123 , 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+5, @NPC_RACE_STARTER, 530, 1, 1, 0, 0, -3970.627930, -13901.256836, 97.864952 , 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+6, @NPC_RACE_STARTER, 1, 1, 1, 0, 0, -2913.298828, -244.111374, 53.254456 , 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+7, @NPC_RACE_STARTER, 1, 1, 1, 0, 0, -612.745056, -4239.760254, 38.956188 , 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+8, @NPC_RACE_STARTER, 0, 1, 1, 0, 0, 1656.737183, 1672.982788, 120.718758 , 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+9, @NPC_RACE_STARTER, 530, 1, 1, 0, 0, 10339.634766, -6374.000000, 35.387463 , 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),

(@CGUID+10, @NPC_RACE_CHECKPOINTER, 1, 1, 1, 0, 0, -52.885784, -4065.069336, 69.367798, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+11, @NPC_RACE_CHECKPOINTER, 1, 1, 1, 0, 0, -1489.524536, -3386.233398, 250.935455, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+12, @NPC_RACE_CHECKPOINTER, 1, 1, 1, 0, 0, -3038.344482, -2333.372803, 102.118149, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+13, @NPC_RACE_CHECKPOINTER, 1, 1, 1, 0, 0, -4679.327148, -1850.779663, -29.076731, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0),
(@CGUID+14, @NPC_RACE_CHECKPOINTER, 1, 1, 1, 0, 0, -5784.561035, -3900.804443, -96.741661, 1.3215, 300, 0, 0, 1753, 0, 0, 0, 0, 0, 0);

DELETE FROM `game_event_creature` WHERE `eventEntry` IN (@GAME_EVENT_RACE_SIGNING,@GAME_EVENT_RACE_PRE_START,@GAME_EVENT_RACE_START);
INSERT INTO `game_event_creature` (`eventEntry`, `guid`) VALUES
(@GAME_EVENT_RACE_SIGNING, @CGUID),
(@GAME_EVENT_RACE_SIGNING, @CGUID+1),
(@GAME_EVENT_RACE_SIGNING, @CGUID+2),
(@GAME_EVENT_RACE_SIGNING, @CGUID+3),
(@GAME_EVENT_RACE_SIGNING, @CGUID+4),
(@GAME_EVENT_RACE_SIGNING, @CGUID+5),
(@GAME_EVENT_RACE_SIGNING, @CGUID+6),
(@GAME_EVENT_RACE_SIGNING, @CGUID+7),
(@GAME_EVENT_RACE_SIGNING, @CGUID+8),
(@GAME_EVENT_RACE_SIGNING, @CGUID+9),

(@GAME_EVENT_RACE_PRE_START, @CGUID),
(@GAME_EVENT_RACE_PRE_START, @CGUID+1),

(@GAME_EVENT_RACE_START, @CGUID),
(@GAME_EVENT_RACE_START, @CGUID+1),
(@GAME_EVENT_RACE_START, @CGUID+10),
(@GAME_EVENT_RACE_START, @CGUID+11),
(@GAME_EVENT_RACE_START, @CGUID+12),
(@GAME_EVENT_RACE_START, @CGUID+13),
(@GAME_EVENT_RACE_START, @CGUID+14),
(@GAME_EVENT_RACE_START, @CGUID+15);