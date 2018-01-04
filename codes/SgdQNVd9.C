#include "stdafx.h"
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#pragma comment(lib, "detours.lib")
#include "detours.h"

LPSTR newArguments = "+webSiteHostName \"localhost\" +battleFundsHostName \"localhost\" +survey 0 +dc 1 +sessionId 1234 +lang en +soldierName \"mysoldier\" +multi 1 +frontendUrl \"http://localhost/\"";

void OpenConsole()
{
			AllocConsole();
			freopen("conin$","r",stdin);
			freopen("conout$","w",stdout);
			freopen("conout$","w",stderr);
			HWND consoleHandle = GetConsoleWindow();
			MoveWindow(consoleHandle,1,1,680,480,1);
			printf("Console initialized.\n");
}

//Typedefs
typedef int (__stdcall * WINMAIN)(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd);
typedef int (__cdecl * PROTOCONNECT)(int pState, int iSecure, char *pAddr, int uAddr, __int16 iPort);

WINMAIN orgMain;
PROTOCONNECT orgProtoConnect;

int __stdcall WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd)
{
	printf("Detoured WinMain called...\n");
	printf("Arguments before: %s\n", lpCmdLine);
	printf("Arguments after: %s\n", newArguments);
	return orgMain(hInstance, hPrevInstance, newArguments, nShowCmd);
}

int __cdecl ProtoSSLConnect(int pState, int iSecure, char *pAddr, int uAddr, __int16 iPort)
{
	printf("ProtoSSLConnect was used: Address = %s\n" , pAddr);
	return orgProtoConnect(pState, iSecure, pAddr, uAddr, iPort);
}

signed int __cdecl VerifyCertificate(int a1, size_t *a2, char a3)
{
	printf("VerifyCertificate was used\n");
	return 0;
}

void Hack_Init()
{
	OpenConsole();
	printf("Hi from inside the game!\n");
	orgMain = (WINMAIN)DetourFunction((PBYTE)0x4059B0, (PBYTE)WinMain);
	orgProtoConnect = (PROTOCONNECT)DetourFunction((PBYTE)0xB18C50, (PBYTE)ProtoSSLConnect);
	DetourFunction((PBYTE)0xB18580, (PBYTE)VerifyCertificate);
	printf("Detours done.\n");

}