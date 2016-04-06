---- Minecraft Crash Report ----
// Don't be sad. I'll do better next time, I promise!

Time: 19/8/2015 3:34 μμ
Description: Unexpected error

java.lang.ClassCastException: net.minecraft.client.model.ModelRenderer cannot be cast to net.gobbob.mobends.client.model.ModelRendererBends
	at net.gobbob.mobends.client.model.entity.ModelBendsPlayer.func_78087_a(ModelBendsPlayer.java:187)
	at morph.client.render.RenderPlayerHand.func_82441_a(RenderPlayerHand.java:58)
	at net.minecraft.client.renderer.ItemRenderer.func_78440_a(ItemRenderer.java:531)
	at net.minecraft.client.renderer.EntityRenderer.func_78476_b(EntityRenderer.java:736)
	at morph.common.core.EventHandler.onRenderHand(EventHandler.java:238)
	at cpw.mods.fml.common.eventhandler.ASMEventHandler_59_EventHandler_onRenderHand_RenderHandEvent.invoke(.dynamic)
	at cpw.mods.fml.common.eventhandler.ASMEventHandler.invoke(ASMEventHandler.java:54)
	at cpw.mods.fml.common.eventhandler.EventBus.post(EventBus.java:138)
	at net.minecraftforge.client.ForgeHooksClient.renderFirstPersonHand(ForgeHooksClient.java:266)
	at net.minecraft.client.renderer.EntityRenderer.func_78471_a(EntityRenderer.java:1358)
	at net.minecraft.client.renderer.EntityRenderer.func_78480_b(EntityRenderer.java:1011)
	at net.minecraft.client.Minecraft.func_71411_J(Minecraft.java:989)
	at net.minecraft.client.Minecraft.func_99999_d(Minecraft.java:887)
	at net.minecraft.client.main.Main.main(SourceFile:148)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
	at java.lang.reflect.Method.invoke(Unknown Source)
	at net.minecraft.launchwrapper.Launch.launch(Launch.java:135)
	at net.minecraft.launchwrapper.Launch.main(Launch.java:28)


A detailed walkthrough of the error, its code path and all known details is as follows:
---------------------------------------------------------------------------------------

-- Head --
Stacktrace:
	at net.gobbob.mobends.client.model.entity.ModelBendsPlayer.func_78087_a(ModelBendsPlayer.java:187)
	at morph.client.render.RenderPlayerHand.func_82441_a(RenderPlayerHand.java:58)
	at net.minecraft.client.renderer.ItemRenderer.func_78440_a(ItemRenderer.java:531)
	at net.minecraft.client.renderer.EntityRenderer.func_78476_b(EntityRenderer.java:736)
	at morph.common.core.EventHandler.onRenderHand(EventHandler.java:238)
	at cpw.mods.fml.common.eventhandler.ASMEventHandler_59_EventHandler_onRenderHand_RenderHandEvent.invoke(.dynamic)
	at cpw.mods.fml.common.eventhandler.ASMEventHandler.invoke(ASMEventHandler.java:54)
	at cpw.mods.fml.common.eventhandler.EventBus.post(EventBus.java:138)
	at net.minecraftforge.client.ForgeHooksClient.renderFirstPersonHand(ForgeHooksClient.java:266)
	at net.minecraft.client.renderer.EntityRenderer.func_78471_a(EntityRenderer.java:1358)

-- Affected level --
Details:
	Level name: MpServer
	All players: 1 total; [EntityClientPlayerMP['tonimark'/320, l='MpServer', x=-4892,86, y=81,24, z=1475,89]]
	Chunk stats: MultiplayerChunkCache: 573, 573
	Level seed: 0
	Level generator: ID 00 - default, ver 1. Features enabled: false
	Level generator options: 
	Level spawn location: World: (0,0,0), Chunk: (at 0,0,0 in 0,0; contains blocks 0,0,0 to 15,255,15), Region: (0,0; contains chunks 0,0 to 31,31, blocks 0,0,0 to 511,255,511)
	Level time: 150779 game time, 150779 day time
	Level dimension: 0
	Level storage version: 0x00000 - Unknown?
	Level weather: Rain time: 0 (now: false), thunder time: 0 (now: false)
	Level game mode: Game mode: survival (ID 0). Hardcore: false. Cheats: false
	Forced entities: 82 total; [LOTREntityBird['Bird'/1368069, l='MpServer', x=-4862,51, y=79,79, z=1532,82], LOTREntityBird['Bird'/1368073, l='MpServer', x=-4842,50, y=79,00, z=1549,50], LOTREntityButterfly['Butterfly'/1374364, l='MpServer', x=-4902,55, y=80,39, z=1524,04], LOTREntityButterfly['Butterfly'/1374362, l='MpServer', x=-4882,21, y=79,33, z=1511,49], LOTREntityButterfly['Butterfly'/1374363, l='MpServer', x=-4893,81, y=81,14, z=1505,00], LOTREntityRabbit['Rabbit'/1372511, l='MpServer', x=-4930,50, y=78,00, z=1525,50], LOTREntityBird['Bird'/1368448, l='MpServer', x=-4815,09, y=91,59, z=1438,10], EntityClientPlayerMP['tonimark'/320, l='MpServer', x=-4892,86, y=81,24, z=1475,89], EntityBat['Νυχτερίδα'/1372607, l='MpServer', x=-4831,19, y=46,10, z=1473,18], LOTREntityRabbit['Rabbit'/1362382, l='MpServer', x=-4823,50, y=80,00, z=1444,09], LOTREntityRabbit['Rabbit'/1370749, l='MpServer', x=-4888,59, y=80,00, z=1431,72], LOTREntityRabbit['Rabbit'/1370793, l='MpServer', x=-4928,50, y=80,00, z=1505,50], LOTREntityGundabadOrc['Zagl?, the Gundabad Orc'/1362704, l='MpServer', x=-4932,50, y=55,00, z=1406,50], LOTREntityGundabadOrc['Nagzag, the Gundabad Orc'/1364753, l='MpServer', x=-4817,50, y=58,00, z=1505,50], LOTREntityGundabadOrcArcher['Gazmog, the Gundabad Orc Archer'/1362705, l='MpServer', x=-4932,50, y=55,00, z=1406,50], LOTREntityRabbit['Rabbit'/1364764, l='MpServer', x=-4895,50, y=79,00, z=1458,50], LOTREntityGundabadOrcArcher['Ugh?, the Gundabad Orc Archer'/1362700, l='MpServer', x=-4932,50, y=55,00, z=1406,50], LOTREntityGundabadOrcArcher['Lugdush, the Gundabad Orc Archer'/1362701, l='MpServer', x=-4932,50, y=55,00, z=1406,50], LOTREntityGundabadOrc['Zagdush, the Gundabad Orc'/1362702, l='MpServer', x=-4932,50, y=55,00, z=1406,50], LOTREntityGundabadOrcArcher['Zagdush, the Gundabad Orc Archer'/1362703, l='MpServer', x=-4932,50, y=55,00, z=1406,50], LOTREntityRabbit['Rabbit'/1371006, l='MpServer', x=-4891,50, y=76,00, z=1525,50], LOTREntityBird['Bird'/1371000, l='MpServer', x=-4884,50, y=79,00, z=1498,50], LOTREntityGundabadOrc['Muzgash, the Gundabad Orc'/1373079, l='MpServer', x=-4840,50, y=19,00, z=1500,50], LOTREntityGundabadOrcArcher['Maugash, the Gundabad Orc Archer'/1360796, l='MpServer', x=-4863,50, y=23,00, z=1425,50], LOTREntityGundabadOrcArcher['Uflug, the Gundabad Orc Archer'/1360797, l='MpServer', x=-4863,50, y=23,00, z=1425,50], LOTREntityGundabadOrc['Lug?, the Gundabad Orc'/1360798, l='MpServer', x=-4863,50, y=23,00, z=1425,50], LOTREntityGundabadOrcArcher['Radnag, the Gundabad Orc Archer'/1360799, l='MpServer', x=-4863,50, y=23,00, z=1425,50], EntityBat['Νυχτερίδα'/1364865, l='MpServer', x=-4892,34, y=25,00, z=1498,50], LOTREntityBird['Bird'/1373093, l='MpServer', x=-4888,94, y=87,80, z=1408,79], LOTREntityGundabadOrc['Gorduf, the Gundabad Orc'/1360800, l='MpServer', x=-4863,50, y=23,00, z=1425,50], LOTREntityGundabadOrcArcher['Lagl?, the Gundabad Orc Archer'/1360801, l='MpServer', x=-4863,50, y=23,00, z=1425,50], EntityBat['Νυχτερίδα'/1366993, l='MpServer', x=-4921,00, y=20,87, z=1437,53], LOTREntityBird['Bird'/1375199, l='MpServer', x=-4841,50, y=79,00, z=1547,50], LOTREntityGundabadOrc['Muzlag, the Gundabad Orc'/1364960, l='MpServer', x=-4847,50, y=43,00, z=1456,50], LOTREntityGundabadOrc['Yagl?, the Gundabad Orc'/1364961, l='MpServer', x=-4848,50, y=43,00, z=1458,50], LOTREntityRabbit['Rabbit'/1369105, l='MpServer', x=-4889,50, y=76,00, z=1526,50], LOTREntityBird['Bird'/1373198, l='MpServer', x=-4819,50, y=99,00, z=1407,50], LOTREntityBird['Bird'/1365086, l='MpServer', x=-4814,42, y=93,88, z=1418,36], LOTREntityRangerNorth['Angbor, the Ranger of the North'/1367134, l='MpServer', x=-4855,50, y=81,00, z=1429,50], LOTREntityBird['Bird'/1371236, l='MpServer', x=-4827,36, y=108,26, z=1402,96], LOTREntityBird['Bird'/1371302, l='MpServer', x=-4812,50, y=94,00, z=1411,50], EntityBat['Νυχτερίδα'/1367210, l='MpServer', x=-4841,34, y=13,10, z=1497,63], EntityBat['Νυχτερίδα'/1367211, l='MpServer', x=-4836,41, y=14,00, z=1510,16], LOTREntityButterfly['Butterfly'/1365214, l='MpServer', x=-4903,40, y=82,93, z=1489,47], EntityItem['item.item.lotr:chestnut'/1369304, l='MpServer', x=-4907,56, y=76,13, z=1527,22], LOTREntityGundabadOrcArcher['Muzl?, the Gundabad Orc Archer'/1369340, l='MpServer', x=-4886,00, y=36,00, z=1490,56], LOTREntityGundabadOrc['Lugthak, the Gundabad Orc'/1369315, l='MpServer', x=-4901,38, y=59,00, z=1438,50], LOTREntityGundabadOrc['Maul?, the Gundabad Orc'/1365219, l='MpServer', x=-4823,50, y=26,00, z=1555,50], LOTREntityRabbit['Rabbit'/1367274, l='MpServer', x=-4850,22, y=80,00, z=1523,50], EntityItem['item.item.string'/1363221, l='MpServer', x=-4939,66, y=12,13, z=1459,47], EntityItem['item.item.string'/1363222, l='MpServer', x=-4936,13, y=11,13, z=1462,81], LOTREntityGundabadOrc['L?nbu, the Gundabad Orc'/1365248, l='MpServer', x=-4839,16, y=12,00, z=1503,50], EntityTrail['άγνωστο'/1223997, l='MpServer', x=-4892,86, y=81,62, z=1475,89], LOTREntityRangerNorth['Eldacar, the Ranger of the North'/1363288, l='MpServer', x=-4868,50, y=78,00, z=1448,50], LOTREntityRangerNorth['Halbarad, the Ranger of the North'/1363289, l='MpServer', x=-4863,34, y=78,00, z=1448,31], LOTREntityRangerNorth['Dervorin, the Ranger of the North'/1363290, l='MpServer', x=-4870,50, y=77,00, z=1452,69], LOTREntityButterfly['Butterfly'/1373530, l='MpServer', x=-4911,29, y=76,04, z=1521,44], LOTREntityRangerNorth['Duinhir, the Ranger of the North'/1363291, l='MpServer', x=-4871,88, y=77,00, z=1455,50], LOTREntityRabbit['Rabbit'/1365318, l='MpServer', x=-4886,50, y=79,00, z=1504,50], LOTREntityRabbit['Rabbit'/1373565, l='MpServer', x=-4887,50, y=79,00, z=1440,50], LOTREntityRabbit['Rabbit'/1375763, l='MpServer', x=-4960,50, y=79,00, z=1537,50], LOTREntityRangerNorth['Forlong, the Ranger of the North'/1373732, l='MpServer', x=-4828,64, y=82,00, z=1492,44], LOTREntityRangerNorth['Beregond, the Ranger of the North'/1373730, l='MpServer', x=-4822,50, y=86,00, z=1488,50], LOTREntityRangerNorth['Findegil, the Ranger of the North'/1373731, l='MpServer', x=-4821,50, y=86,00, z=1492,50], LOTREntityRangerNorth['Ohtar, the Ranger of the North'/1373738, l='MpServer', x=-4914,50, y=77,00, z=1518,50], LOTREntityRangerNorth['Hallas, the Ranger of the North'/1373739, l='MpServer', x=-4912,50, y=77,00, z=1516,50], LOTREntityRabbit['Rabbit'/1369667, l='MpServer', x=-4930,31, y=80,00, z=1488,41], EntitySheep['Πρόβατο'/1361532, l='MpServer', x=-4901,66, y=80,00, z=1454,47], LOTREntityButterfly['Butterfly'/1375868, l='MpServer', x=-4891,50, y=79,00, z=1513,50], EntitySheep['Πρόβατο'/1361533, l='MpServer', x=-4905,98, y=77,00, z=1455,53], LOTREntityRabbit['Rabbit'/1369725, l='MpServer', x=-4956,50, y=81,00, z=1467,50], EntitySheep['Πρόβατο'/1361530, l='MpServer', x=-4902,56, y=79,00, z=1455,78], EntitySheep['Πρόβατο'/1361531, l='MpServer', x=-4901,19, y=79,00, z=1455,78], LOTREntityGundabadOrc['Lagduf, the Gundabad Orc'/1367709, l='MpServer', x=-4817,50, y=66,00, z=1516,50], LOTREntityGundabadOrc['Yagbug, the Gundabad Orc'/1367710, l='MpServer', x=-4818,50, y=66,00, z=1516,50], LOTREntityButterfly['Butterfly'/1375874, l='MpServer', x=-4892,50, y=79,00, z=1506,50], LOTREntityGundabadOrc['Muzbug, the Gundabad Orc'/1369776, l='MpServer', x=-4910,50, y=56,00, z=1498,50], LOTREntityGundabadOrcArcher['Muzlag, the Gundabad Orc Archer'/1369777, l='MpServer', x=-4918,63, y=53,00, z=1504,50], LOTREntityGundabadOrc['Gaz?, the Gundabad Orc'/1369775, l='MpServer', x=-4912,09, y=56,00, z=1492,59], LOTREntityButterfly['Butterfly'/1365912, l='MpServer', x=-4847,39, y=81,33, z=1497,92], LOTREntityGundabadOrc['L?nla, the Gundabad Orc'/1365900, l='MpServer', x=-4822,49, y=53,00, z=1492,63], LOTREntityButterfly['Butterfly'/1374195, l='MpServer', x=-4923,05, y=82,92, z=1552,63]]
	Retry entities: 0 total; []
	Server brand: fml,forge
	Server type: Integrated singleplayer server
Stacktrace:
	at net.minecraft.client.multiplayer.WorldClient.func_72914_a(WorldClient.java:373)
	at net.minecraft.client.Minecraft.func_71396_d(Minecraft.java:2432)
	at net.minecraft.client.Minecraft.func_99999_d(Minecraft.java:916)
	at net.minecraft.client.main.Main.main(SourceFile:148)
	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
	at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
	at java.lang.reflect.Method.invoke(Unknown Source)
	at net.minecraft.launchwrapper.Launch.launch(Launch.java:135)
	at net.minecraft.launchwrapper.Launch.main(Launch.java:28)

-- System Details --
Details:
	Minecraft Version: 1.7.10
	Operating System: Windows 8.1 (amd64) version 6.3
	Java Version: 1.8.0_51, Oracle Corporation
	Java VM Version: Java HotSpot(TM) 64-Bit Server VM (mixed mode), Oracle Corporation
	Memory: 389731544 bytes (371 MB) / 2701656064 bytes (2576 MB) up to 2863661056 bytes (2731 MB)
	JVM Flags: 6 total; -XX:HeapDumpPath=MojangTricksIntelDriversForPerformance_javaw.exe_minecraft.exe.heapdump -Xmx2560m -XX:MaxPermSize=256m -Xms2048M -Xmx3072M -XX:PermSize=256M
	AABB Pool Size: 0 (0 bytes; 0 MB) allocated, 0 (0 bytes; 0 MB) used
	IntCache: cache: 0, tcache: 0, allocated: 3, tallocated: 55
	FML: MCP v9.05 FML v7.10.103.1352 Minecraft Forge 10.13.2.1352 30 mods loaded, 30 mods active
	mcp{9.05} [Minecraft Coder Pack] (minecraft.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	FML{7.10.103.1352} [Forge Mod Loader] (modpack.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	Forge{10.13.2.1352} [Minecraft Forge] (modpack.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	CodeChickenCore{1.0.2.11} [CodeChicken Core] (minecraft.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	NotEnoughItems{1.0.2.15} [Not Enough Items] (NotEnoughItems-1.7.10-1.0.2.15-universal.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	lotr{Beta v23.3 for Minecraft 1.7.10} [The Lord of the Rings Mod] ([1.7.10] The Lord of the Rings Mod B23.3.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	iChunUtil{4.1.3} [iChunUtil] (iChun-Util-Mod-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	Morph{0.9.1} [Morph] (_Morphing-Mod-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	AppleCore{1.1.0} [AppleCore] (AppleCore-mc1.7.10-1.1.0.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	cgum{1.2.1} [Gum Mod] (Chewing-Gum-Mod-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	darkcore{0.25} [Dark Core] (darkcore-0.25-35.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	props{2.0.2} [Decocraft] (Decocraft-2.0.2_1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights{1.3.5} [Dynamic Lights] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_onFire{1.0.4} [Dynamic Lights Burning Entity Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_creepers{1.0.4} [Dynamic Lights Creeper Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_dropItems{1.0.7} [Dynamic Lights EntityItem Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_entityClasses{1.0.1} [Dynamic Lights Entity Light Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_mobEquipment{1.0.5} [Dynamic Lights Mob Equipment Light Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_flameArrows{1.0.0} [Dynamic Lights Fiery Arrows Light Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_floodLights{1.0.1} [Dynamic Lights Flood Light] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_otherPlayers{1.0.7} [Dynamic Lights OtherPlayers Light Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	DynamicLights_thePlayer{1.1.3} [Dynamic Lights Player Light Module] (DynamicLights-1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	mobends{0.20.1} [Mo' Bends] (MoBends-0.20.1 for MC 1.7.10.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	cfm{3.4.8} [§9MrCrayfish's Furniture Mod] (MrCrayfishFurnitureModv3.4.8(1.7.10).jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	shadowworld{1.3.3} [Shadow World] (shadowworld-1.3.3.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	shadowworld/DynamicLights{1.0.0} [DynamicLights in the Shadow World] (shadowworld_DynamicLights_1.0.0.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	Sleep{0.0-1} [Sleep] (Sleep-Mod-1.7.10 (1).jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	TardisMod{0.985} [Tardis Mod] (tardismod-1.7.10-0.985-178.jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	thedalekmod{39.51} [The Dalek Mod] (the_dalek_mod_1.7.10.zip) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	HungerOverhaul{1.7.10-1.0.0.jenkins75} [Hunger Overhaul] (HungerOverhaul-1.7.10-1.0.0 (1).jar) Unloaded->Constructed->Pre-initialized->Initialized->Post-initialized->Available->Available->Available->Available
	Launched Version: 1.7.10-Forge10.13.2.1352-1.7.10
	LWJGL: 2.9.1
	OpenGL: Intel(R) HD Graphics 4400 GL version 4.3.0 - Build 10.18.15.4256, Intel
	GL Caps: Using GL 1.3 multitexturing.
Using framebuffer objects because OpenGL 3.0 is supported and separate blending is supported.
Anisotropic filtering is supported and maximum anisotropy is 16.
Shaders are available because OpenGL 2.1 is supported.

	Is Modded: Definitely; Client brand changed to 'fml,forge'
	Type: Client (map_client.txt)
	Resource Packs: []
	Current Language: Ελληνικά (Ελλάδα)
	Profiler Position: N/A (disabled)
	Vec3 Pool Size: 0 (0 bytes; 0 MB) allocated, 0 (0 bytes; 0 MB) used
	Anisotropic Filtering: Off (1)