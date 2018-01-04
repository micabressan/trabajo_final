[12:29:25] [Server thread/INFO]: DomyPvP issued server command: /bw setspawn Rosso
[12:29:25] [Server thread/ERROR]: null
org.bukkit.command.CommandException: Unhandled exception executing 'bw setspawn Rosso' in com.andrei1058.bedwars.commands.MainCommand(bw)
	at org.bukkit.command.SimpleCommandMap.dispatch(SimpleCommandMap.java:148) ~[Minigames.jar:git-Spigot-db6de12-18fbb24]
	at org.bukkit.craftbukkit.v1_8_R3.CraftServer.dispatchCommand(CraftServer.java:641) ~[Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.PlayerConnection.handleCommand(PlayerConnection.java:1162) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.PlayerConnection.a(PlayerConnection.java:997) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.PacketPlayInChat.a(PacketPlayInChat.java:45) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.PacketPlayInChat.a(PacketPlayInChat.java:1) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.PlayerConnectionUtils$1.run(SourceFile:13) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:511) [?:1.8.0_151]
	at java.util.concurrent.FutureTask.run(FutureTask.java:266) [?:1.8.0_151]
	at net.minecraft.server.v1_8_R3.SystemUtils.a(SourceFile:44) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.MinecraftServer.B(MinecraftServer.java:715) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.DedicatedServer.B(DedicatedServer.java:374) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.MinecraftServer.A(MinecraftServer.java:654) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at net.minecraft.server.v1_8_R3.MinecraftServer.run(MinecraftServer.java:557) [Minigames.jar:git-Spigot-db6de12-18fbb24]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_151]
Caused by: java.lang.IllegalArgumentException: No enum constant com.andrei1058.bedwars.api.TeamColor.ROSSO
	at java.lang.Enum.valueOf(Enum.java:238) ~[?:1.8.0_151]
	at com.andrei1058.bedwars.api.TeamColor.valueOf(TeamColor.java:7) ~[?:?]
	at com.andrei1058.bedwars.api.TeamColor.getChatColor(TeamColor.java:21) ~[?:?]
	at com.andrei1058.bedwars.commands.MainCommand.execute(MainCommand.java:651) ~[?:?]
	at org.bukkit.command.SimpleCommandMap.dispatch(SimpleCommandMap.java:141) ~[Minigames.jar:git-Spigot-db6de12-18fbb24]
	... 14 more