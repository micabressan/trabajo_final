---- Minecraft Crash Report ----
// I let you down. Sorry :(

Time: 07.08.2015 14:41
Description: Initializing game

org.lwjgl.LWJGLException: Pixel format not accelerated
	at org.lwjgl.opengl.WindowsPeerInfo.nChoosePixelFormat(Native Method)
	at org.lwjgl.opengl.WindowsPeerInfo.choosePixelFormat(WindowsPeerInfo.java:52)
	at org.lwjgl.opengl.WindowsDisplay.createWindow(WindowsDisplay.java:244)
	at org.lwjgl.opengl.Display.createWindow(Display.java:306)
	at org.lwjgl.opengl.Display.create(Display.java:848)
	at org.lwjgl.opengl.Display.create(Display.java:757)
	at org.lwjgl.opengl.Display.create(Display.java:739)
	at azd.Z(SourceFile:367)
	at azd.e(SourceFile:689)
	at net.minecraft.client.main.Main.main(SourceFile:103)


A detailed walkthrough of the error, its code path and all known details is as follows:
---------------------------------------------------------------------------------------

-- Head --
Stacktrace:
	at org.lwjgl.opengl.WindowsPeerInfo.nChoosePixelFormat(Native Method)
	at org.lwjgl.opengl.WindowsPeerInfo.choosePixelFormat(WindowsPeerInfo.java:52)
	at org.lwjgl.opengl.WindowsDisplay.createWindow(WindowsDisplay.java:244)
	at org.lwjgl.opengl.Display.createWindow(Display.java:306)
	at org.lwjgl.opengl.Display.create(Display.java:848)
	at org.lwjgl.opengl.Display.create(Display.java:757)
	at org.lwjgl.opengl.Display.create(Display.java:739)
	at azd.Z(SourceFile:367)

-- Initialization --
Details:
Stacktrace:
	at azd.e(SourceFile:689)
	at net.minecraft.client.main.Main.main(SourceFile:103)

-- System Details --
Details:
	Minecraft Version: 1.7.2
	Operating System: Windows 8.1 (x86) version 6.3
	Java Version: 1.8.0_51, Oracle Corporation
	Java VM Version: Java HotSpot(TM) Client VM (mixed mode), Oracle Corporation
	Memory: 53831624 bytes (51 MB) / 125042688 bytes (119 MB) up to 523501568 bytes (499 MB)
	JVM Flags: 6 total; -XX:HeapDumpPath=MojangTricksIntelDriversForPerformance_javaw.exe_minecraft.exe.heapdump -Xmx512M -XX:+UseConcMarkSweepGC -XX:+CMSIncrementalMode -XX:-UseAdaptiveSizePolicy -Xmn128M
	AABB Pool Size: 0 (0 bytes; 0 MB) allocated, 0 (0 bytes; 0 MB) used
	IntCache: cache: 0, tcache: 0, allocated: 0, tallocated: 0
	Launched Version: 1.7.2
	LWJGL: 2.9.0
	OpenGL: ~~ERROR~~ RuntimeException: No OpenGL context found in the current thread.
	Is Modded: Probably not. Jar signature remains and client brand is untouched.
	Type: Client (map_client.txt)
	Resource Packs: []
	Current Language: ~~ERROR~~ NullPointerException: null
	Profiler Position: N/A (disabled)
	Vec3 Pool Size: ~~ERROR~~ NullPointerException: null
	Anisotropic Filtering: Off (1)