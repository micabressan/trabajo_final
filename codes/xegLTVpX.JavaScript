[20:41:45 WARN]: [DayZ_Loots_Blood] Task #5 for DayZ_Loots_Blood v1.0 generated
an exception
java.lang.NullPointerException
        at me.PvPNiK.DayZ_Loots_Blood.main.main.itemChest(main.java:192) ~[?:?]
        at me.PvPNiK.DayZ_Loots_Blood.main.main$1.run(main.java:46) ~[?:?]
        at org.bukkit.craftbukkit.v1_8_R3.scheduler.CraftTask.run(CraftTask.java
:71) ~[spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at org.bukkit.craftbukkit.v1_8_R3.scheduler.CraftScheduler.mainThreadHea
rtbeat(CraftScheduler.java:350) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.MinecraftServer.B(MinecraftServer.java:7
22) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.DedicatedServer.B(DedicatedServer.java:3
74) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.MinecraftServer.A(MinecraftServer.java:6
53) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.MinecraftServer.run(MinecraftServer.java
:556) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at java.lang.Thread.run(Unknown Source) [?:1.8.0_45]
[20:47:46 INFO]: UUID of player PvPNiK is af435b2e-5920-4be2-8af5-0d361f5a5f50
[20:47:46 INFO]: PvPNiK[/127.0.0.1:51388] logged in with entity id 14 at ([Land
of Cubes]-7.320624658110916, 95.0, 24.211366924137785)
[20:47:52 INFO]: PvPNiK issued server command: /setitem
[20:47:52 ERROR]: null
org.bukkit.command.CommandException: Unhandled exception executing command 'seti
tem' in plugin DayZ_Loots_Blood v1.0
        at org.bukkit.command.PluginCommand.execute(PluginCommand.java:46) ~[spi
got-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at org.bukkit.command.SimpleCommandMap.dispatch(SimpleCommandMap.java:14
1) ~[spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at org.bukkit.craftbukkit.v1_8_R3.CraftServer.dispatchCommand(CraftServe
r.java:641) ~[spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.PlayerConnection.handleCommand(PlayerCon
nection.java:1162) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.PlayerConnection.a(PlayerConnection.java
:997) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.PacketPlayInChat.a(PacketPlayInChat.java
:45) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.PacketPlayInChat.a(PacketPlayInChat.java
:1) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.PlayerConnectionUtils$1.run(SourceFile:1
3) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at java.util.concurrent.Executors$RunnableAdapter.call(Unknown Source) [
?:1.8.0_45]
        at java.util.concurrent.FutureTask.run(Unknown Source) [?:1.8.0_45]
        at net.minecraft.server.v1_8_R3.SystemUtils.a(SourceFile:44) [spigot-1.8
.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.MinecraftServer.B(MinecraftServer.java:7
14) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.DedicatedServer.B(DedicatedServer.java:3
74) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.MinecraftServer.A(MinecraftServer.java:6
53) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at net.minecraft.server.v1_8_R3.MinecraftServer.run(MinecraftServer.java
:556) [spigot-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        at java.lang.Thread.run(Unknown Source) [?:1.8.0_45]
Caused by: java.lang.NullPointerException
        at me.PvPNiK.DayZ_Loots_Blood.main.main.itemChest(main.java:192) ~[?:?]
        at me.PvPNiK.DayZ_Loots_Blood.main.main.onCommand(main.java:493) ~[?:?]
        at org.bukkit.command.PluginCommand.execute(PluginCommand.java:44) ~[spi
got-1.8.8.jar:git-Spigot-fdc1440-53fac9f]
        ... 15 more