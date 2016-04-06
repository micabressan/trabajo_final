#include <stdio.h>
#include <windows.h>
#include <tlhelp32.h>

char* sModule[] = { "SbieDll.dll", "dbghelp.dll" };

bool IsInSandbox()
{
	MODULEENTRY32 me32;
	HANDLE hSnapShot;

	me32.dwSize = sizeof(MODULEENTRY32);

	hSnapShot = CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, GetCurrentProcessId());

	Module32First(hSnapShot, &me32);

	while (Module32Next(hSnapShot, &me32))
	{
		for (int i = 0; i < (sizeof(sModule) / sizeof(char*)); i++)
		{
			// I HAVE ERROR IN LINE BELOW
			if (strstr(me32.szModule, sModule[i]))
			{
				CloseHandle(hSnapShot);
				return true;
			}
		}
	}
	CloseHandle(hSnapShot);
	return false;
}
int main()
{

	return 0;
}