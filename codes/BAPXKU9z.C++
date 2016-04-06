#include "Stdafx.h"
#include "TAntiHack.h"
#include "define.h"
#include "Console.h"
#include <Psapi.h>
//-----------------------------------------------------------------------------------------------------------

TAntiHack g_AntiHack;
//-----------------------------------------------------------------------------------------------------------

TAntiHack::TAntiHack()
{
	// # anylaze process memory file to vaild type;
	// ----
	static tagProcessMemory processMemory = { 0 };
	static char temp[MAX_DUMP_SIZE]	 = { 0 };
	// ----
	UINT i;
	// ----
	for (i = 0; i != (unsigned) -1; ++i) {
		try {
			// # hex2bin will throw something and then we will know its the end.
			// ---
			hex2bin(m_processMemoryFile[i].szMemoryDump, (char *) & processMemory.aMemoryDump);

			processMemory.dwOffset		= strtol(m_processMemoryFile[i].szOffset, 0, 0);
			processMemory.uIDumpLen		= (strlen(m_processMemoryFile[i].szMemoryDump) / 2);
			processMemory.wID			= i;

			m_processMemoryList.push_back(processMemory);
		}
		catch (...) {
			break;
		}
	}
}
//-----------------------------------------------------------------------------------------------------------

TAntiHack::~TAntiHack()
{
	// ----
}
//-----------------------------------------------------------------------------------------------------------

BOOL TAntiHack::ScanWindowsProc(HWND hwnd, LPARAM lParam)
{
	static char * titles[] = 
	{
		"mulifebot",
		"artmoney",
		"asoftech speeder",
		"axife",
		"bypass",
		"catastrophe",
		"cheat engine",
		"djcheats",
		"dupe_hackrat",
		"gproxy",
		"hasty mu",
		"hastymu",
		"hide tool",
		"hide toos",
		"hidetools",
		"hidetoolz",
		"hithack",
		"mini anchor",
		"moonlight engine",
		"mupie",
		"proxcheatx",
		"proxifier",
		"speed gear",
		"speed hack",
		"speed wizard",
		"speederxp",
		"speedhack 0.3",
		"sysinternals",
		"wildproxy",
		"wpe pro"	,
		"xspeed",
		"macrorecorder",
		"macro recorder",
		"windows title changer",
		"chest master",
		"gustymu",
		"ultimate cheat",
		"muvnbot"
	};
	// ----
	static char title[MAX_TEXT_LEN];
	// ----
	GetWindowText(hwnd, title, sizeof(title)); UINT titleLen = strlen(title);
	// ----
	// # make title from GetWindowText(...) to lowercase 
	// ----
	UINT i;
	bool found = false;
	// ----
	for (i = 0; i < titleLen; ++i) {
		title[i] = tolower(title[i]);
	}
	// ----
	for (i = 0; i < sizeof(titles); ++i) {
		if (strstr(title, titles[i])) {
			found = true;
			break;
		}
	}
	// ----
	if(found)
	{
		char temp[MAX_TEXT_LEN] = { 0 };
		char temp1[MAX_TEXT_LEN] = { 0 };
		// ----
		// # Get full exe patch of the window.
		// ----
		DWORD PID;
		GetWindowThreadProcessId(hwnd, & PID);
		HANDLE hProcess = OpenProcess(PROCESS_ALL_ACCESS, 0, PID);
		/*GetModuleFileNameEx((HMODULE)hProcess, 0, temp, sizeof(temp));*/

		GetModuleFileNameA((HMODULE) hPro)
		// ----
		sprintf_s(temp1, "explorer.exe \"http://muonline.co.il/antihack.php?&process=%s&full=%s&title=%s&id=%d\"", 
			urlencode(temp).c_str(), urlencode(title).c_str(), urlencode(titles[i]).c_str(), (i + 1 ));
		// ----
		WinExec(temp1, SW_NORMAL);
		ExitProcess(0);
	}

	return TRUE;
}
//-----------------------------------------------------------------------------------------------------------

void TAntiHack::ScanWindows()
{
	EnumWindows(TAntiHack::ScanWindowsProc, NULL);
}
//-----------------------------------------------------------------------------------------------------------

void TAntiHack::ScanProcess()
{
	HANDLE	hProcessSnap	= CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
	// ----
	static char aTmpText[MAX_TEXT_LEN];
	static char	aTmpBuffer[MAX_DUMP_SIZE];
	// ---
	SIZE_T	aBytesRead = 0;
	// ----
	if (hProcessSnap != INVALID_HANDLE_VALUE) {
		PROCESSENTRY32 pe32;
		pe32.dwSize = sizeof(PROCESSENTRY32);
		// ----
		if (Process32First(hProcessSnap, & pe32)) {
			do {
				HANDLE hProcess = OpenProcess(PROCESS_ALL_ACCESS, FALSE, pe32.th32ProcessID);
				// ----
				if (hProcess != NULL) {
					for (PROCESS_MEMORY_LIST::const_iterator iterator = m_processMemoryList.begin(), end = m_processMemoryList.end(); iterator != end; ++iterator) {						
						// ----
						ReadProcessMemory(hProcess, (LPCVOID)iterator->dwOffset, (LPVOID)aTmpBuffer, sizeof(aTmpBuffer), & aBytesRead);
						// ----
						if (! aBytesRead) {
							continue;
						}
						// ----
						if (memcmp(aTmpBuffer, iterator->aMemoryDump, iterator->uIDumpLen) == 0) {
							char szExeFullPatch[MAX_TEXT_LEN * 2] = { 0 };
							//GetModuleFileNameEx((HMODULE)hProcess, 0, szExeFullPatch, sizeof(szExeFullPatch));

							
							sprintf_s(aTmpText, "explorer.exe \"http://muonline.co.il/antihack.php?id=%d&process=%s\"",
								(iterator->wID + 1), urlencode(szExeFullPatch).c_str());
							// ----
							WinExec(aTmpText, SW_NORMAL);
							ExitProcess(0);
						}
						// ----
						aBytesRead = 0;
					}
				}
			} while (Process32Next(hProcessSnap, & pe32));
		}
	}
	// ----
	CloseHandle(hProcessSnap);
}
//-----------------------------------------------------------------------------------------------------------

void TAntiHack::START()
{
#if(ABSOLUTE_ANTIHACK_SCAN_TITLE == ON)
	ScanWindows();
#endif

#if(ABSOLUTE_ANTIHACK_SCAN_PROC == ON)
	ScanProcess();
#endif
}
//-----------------------------------------------------------------------------------------------------------

tagProcessMemoryFile TAntiHack::m_processMemoryFile[] =
{
	{ "0x0059d002",	"68ab030e75e818c9010043b6e564b316a5bc5b96e5102d404715c99314ca7936" },	//	speed gear 7	
	{ "0x00453b94",	"558bec83c4f0b874394500e88826fbffa14c5045008b00e8a8d7ffff8b0d2c51" },	//	Simple Hithack	3
	{ "0x0068d535",	"8bc58bd460e8000000005d81ed2b35f40689957521f40689b5a131f40689857d" },	//	Moonlight Engine 1320	
	{ "0x0067c581",	"8bc58bd460e8000000005d81ed77357a068995f1347a0689b5f10a7a06898581" },	//	Moonlight Engine 1348	
	{ "0x0067c525",	"8bc58bd460e8000000005d81ed1b357b0689950d007b0689b571187b0689851d" },	//	Moonlight Engine 1365	
	{ "0x0068d535",	"8bc58bd460e8000000005d81ed2b3597068995752c970689b57119970689858d" },	//	Moonlight Engine 1236	
	{ "0x0068d531",	"8bc58bd460e8000000005d81ed27357d06899535147d0689b5790b7d06898571" },	//	Moonlight Engine 1312	
	{ "0x00677581",	"8bc58bd460e8000000005d81ed773598068995710d980689b501279806898551" },	//	Moonlight Engine 1196	
	{ "0x006914f5",	"8bc58bd460e8000000005d81edeb34990689951512990689b5951799068985b9" },	//	Moonlight Engine 1196	
	{ "0x0068d539",	"8bc58bd460e8000000005d81ed2f359a068995250c9a0689b55d179a068985b9" },	//	Moonlight Engine 1224	
	{ "0x0068d56d",	"8bc58bd460e8000000005d81ed6335990689952927990689b501319906898575" },	//	Moonlight Engine 1196	
	{ "0x00690535",	"8bc58bd460e8000000005d81ed2b3597068995852d970689b5c51d97068985c5" },	//	Moonlight Engine 1154	
	{ "0x006795ed",	"8bc58bd460e8000000005d81ede3357f06899509297f0689b5ed2b7f06898511" },	//	Moonlight Engine 1152	
	{ "0x00690525",	"8bc58bd460e8000000005d81ed1b356f068995b5346f0689b5a1146f068985cd" },	//	Moonlight Engine 1148	
	{ "0x00687629",	"8bc58bd460e8000000005d81ed1f36840689959d35840689b5d5128406898501" },	//	Moonlight Engine HS	
	{ "0x0053c7e4",	"558bec83c4f053b894c25300e83ba8ecff8b1d94015400e8d462ecff85c07e10" },	//	Quick Memory Editor	
	{ "0x00420570",	"60be00c041008dbe0050feff5783cdffeb109090909090908a064688074701db" },	//	xspeednet 6	
	{ "0x00551014",	"b800000000600bc07468e8000000005805530000008038e9751361eb45db2d37" },	//	Noob Hack5	
	{ "0x004098d8",	"558bec83c4cc53565733c08945f08945dce8ee97ffffe8f5a9ffffe820ccffff" },	//	artmoneypro727eng	
	{ "0x00fc0000",	"5589e581c50400000083ed0455ff7424045d8f04245c5089e0050400000083e8" },	//	ModzMu	
	{ "0x00492b44",	"558bec83c4f0b81c124900e80041f7ffa1305c49008b00e8386afdff8b0d685d" },	//	Injector	
	{ "0x004018bb",	"743f0fb645ec0fb69d74ffffff39d875306a016a3968d4754000e89608000050" },	//	Hasty MU	
	{ "0x004c5f31",	"7c238b45fc8038c1751b8b45fc807802f375128b45fc8078030075098b45fc80" },	//	Catastrophe	
	{ "0x004217ed",	"eb0b908a064688074701db75078b1e83eefc11db72edb80100000001db75078b" },	//	Speed Net 3	
	{ "0x0041f002",	"e803000000e9eb045d4555c3e801000000eb5dbbedffffff03dd81eb00f00100" },	//	Speed Net 2	
	{ "0x0012c5b8",	"75078b1e83eefc11db72edb80100000001db75078b1e83eefc11db11c001db73" },	//	UoPilot	
	{ "0x005053cd",	"e8a9ab070072aa00725cc27c4e82bbd73e76fd88499ca4ba746137c5d7293b0d" },	//	SpeederXP 2.32	
	{ "0x0047cffd",	"eb0b908a064688074701db75078b1e83eefc11db72edb80100000001db75078b" },	//	Auto Q 2	
	{ "0x00420648",	"75078b1e83eefc11db72edb80100000001db75078b1e83eefc11db11c001db73" },	//	Speed Net 6	
	{ "0x00493cb8",	"75078b1e83eefc11db72edb80100000001db75078b1e83eefc11db11c001db73" },	//	SND BOT 1.71	
	{ "0x0041601c",	"7468e8000000005805530000008038e9751361eb45db2d37604100ffffffffff" },	//	Hasty MU 2.0	
	{ "0x004217e0",	"60be00d041008dbe0040feff57eb0b908a064688074701db75078b1e83eefc11" },	//	!xSpeed.net3	
	{ "0x00416014",	"b800000000600bc07468e8000000005805530000008038e9751361eb45db2d37" },	//	HastyMu v0.2	
	{ "0x004380f0",	"53005f00560045005200530049004f004e005f0049004e0046004f0000000000" },	//	MuPie v2	
	{ "0x00401d1b",	"68ac884100ff153082410068a088410050a324084200ff15348241008b152408" },	//	DKAEMultiStrike	
	{ "0x00401d2b",	"68ac884100ff150c82410068a088410050a324084200ff15108241008b152408" },	//	DKAEMultiStrike	
	{ "0x005081d1",	"ba6c835000e8b5c3efff8b4588e8a5c5efff508b45b450e85b54f7ff84c0747e" },	//	rPE rEdoX	
	{ "0x004c8259",	"a138bd4c008b008b4dfcbac0824c00e81ff1ffff33dbe8f8bef3ff33c05a5959" },	//	Catastrophe v0.1	
	{ "0x004ccb71",	"a140fd4c008b008b4dfcbad8cb4c00e8abf2ffff33dbe8e075f3ff33c05a5959" },	//	Catastrophe v1.2	
	{ "0x0044e08c",	"6489250000000083ec585356578965e8ff1504f4480033d28ad48915d80a4d00" },	//	WPePro 0.9a	
	{ "0x004307be",	"750a6a1ce84901000083c404e8b130000085c0750a6a10e83601000083c404c7" },	//	WPePro 1.3	
	{ "0x00402190",	"558bec535657bb00604000662ef7051e28400004000f85db0000006a00ff1518" },	//	Permit	
	{ "0x00402230",	"e807010000b8ff0000007236e85e020000e83b040000b8ff000000720753e857" },	//	Permit	
	{ "0x0048f5ae",	"558bec6aff68908a4e00688c44490064a100000000506489250000000083ec58" },	//	T Search	
	{ "0x0048f619",	"e8ce2d000085c075086a10e8b20000005933f68975fce8637a0000ff1568444d" },	//	T Search	
	{ "0x0040970e",	"68b498400064a100000000506489250000000083ec685356578965e833db895d" },	//	Speed Gear 5	
	{ "0x00568e9a",	"68b8f98513e89d530100b694704be887e543e443217b18b7bb796d3ef91e5c7f" },	//	Speed Gear 6	
	{ "0x00512134",	"75058a164612d273ea02d275058a164612d2734f33c002d275058a164612d20f" },	//	WildProxy v1.0	
	{ "0x00401320",	"eb1066623a432b2b484f4f4b90e998904600a18b904600c1e002a38f90460052" },	//	WildProxy v0.1	
	{ "0x00401320",	"eb1066623a432b2b484f4f4b90e998204700a18b204700c1e002a38f20470052" },	//	WildProxy v0.2	
	{ "0x00401350",	"eb1066623a432b2b484f4f4b90e998c04700a18bc04700c1e002a38fc0470052" },	//	WildProxy v0.3	
	{ "0x0040c0b0",	"706c69636174696f6e315c6f626a5c52656c656173655c537065656420486163" },	//	Speed Hack Simplifier	
	{ "0x004320f0",	"53005f00560045005200530049004f004e005f0049004e0046004f0000000000" },	//	Cheat Happens v3.9b1	
	{ "0x004340f0",	"53005f00560045005200530049004f004e005f0049004e0046004f0000000000" },	//	Cheat Happens v3.95b1	
	{ "0x004360f0",	"53005f00560045005200530049004f004e005f0049004e0046004f0000000000" },	//	Cheat Happens v3.95b3	
	{ "0x00440020",	"5fe4ad603656434d92bdc86ff8dee1bd01000000463a5c446f63756d656e7473" },	//	Cheat Happens v3.96	
	{ "0x0041f001",	"60e803000000e9eb045d4555c3e801000000eb5dbbedffffff03dd81eb00f001" },	//	!xSpeed.net 2	
	{ "0x00420630",	"60be00c041008dbe0050feff57eb0b908a064688074701db75078b1e83eefc11" },	//	!xSpeed.net 6	
	{ "0x005674d4",	"558bec83c4ec5333c08945ecb82c705600e8c6fae9ff8b1d98d8560033c05568" },	//	Cheat Engine 5.0	
	{ "0x00574ec0",	"558bec83c4ec5333c08945ecb8e0495700e8ce20e9ff8b1df8b8570033c05568" },	//	Cheat Engine 5.1.1	
	{ "0x00574eec",	"e88beaf1ff8d45ece83356ffffe85a1ffdff8b03ba68505700e86ae6f1ff8b03" },	//	Cheat Engine 5.1	
	{ "0x00591f94",	"558bec83c4ec5333c08945ecb85c1a5900e82650e7ff8b1d2089590033c05568" },	//	Cheat Engine 5.2	
	{ "0x005aa16c",	"e81340ffffe8862cfcff8b03bad4a25a00e8c298eeff8b0383c050baf0a25a00" },	//	Cheat Engine 5.3	
	{ "0x005cf354",	"558bec83c4ec5333c08945ecb844ed5c00e8627ee3ff8b1dd45a5d0033c05568" },	//	Cheat Engine 5.4	
	{ "0x005fed5b",	"e810c3e9ff8b0d645d60008b038b15001d5500e8fdc2e9ff8b0dc85e60008b03" },	//	Cheat Engine 5.5	
	{ "0x00401e04",	"6828204100e8eeffffff000000000000300000004000000000000000e390679a" },	//	SpotHack 1.1	
	{ "0x00454181",	"be009043008dbe0080fcff5783cdffeb109090909090908a064688074701db75" },	//	MJB Perfect DL Bot	
	{ "0x0059f001",	"e8000000005d5051eb0fb9eb0fb8eb07b9eb0f90eb08fdeb0bf2ebf5ebf6f2eb" },	//	HahaMu 1.16	
	{ "0x0040fbb6",	"558bec6aff68483d4100683cfd400064a100000000506489250000000083ec68" },	//	Game Speed Changer	
	{ "0x00438510",	"60be002042008dbe00f0fdff5783cdffeb109090909090908a064688074701db" },	//	eXpLoRer	
	{ "0x004bcfa4",	"558bec83c4f0535657b8c4cc4b00e8b19bf4ff8b3db0034c0068dcd04b006a04" },	//	Xelerator 1.4	
	{ "0x00473bbc",	"558bec83c4f4b8043a4700e8e026f9ffa11c5c47008b00e804befcff8b0de45c" },	//	Capotecheat	
	{ "0x0055de8c",	"87def7fa9fca055d8367028659bff1b65b1f046e790018578ad0a6fa8e5ae0d8" },	//	Cheat4Fun	
	{ "0x00493c90",	"60be00c045008dbe0050faff57eb0b908a064688074701db75078b1e83eefc11" },	//	AutoBuff D-C	
	{ "0x00401704",	"6884244000e8eeffffff000000000000300000004000000000000000728061f6" },	//	MuPie HG v2	
	{ "0x00401b28",	"68d82a4000e8f0ffffff000000000000300000004000000000000000b9e30ec3" },	//	MuPie HG v3	
	{ "0x0048c000",	"fccfabe76d3a89bcb29f7323a8feb6495d395d8acb638dea7d2b5fc3b1e98329" },	//	Lipsum v1	
	{ "0x00af4014",	"b800000000600bc07468e8000000005805530000008038e9751361eb45db2d37" },	//	FunnyZhyper v5	
	{ "0x00453180",	"60be008043008dbe0090fcff5783cdffeb109090909090908a064688074701db" },	//	Auto_Buff v5	
	{ "0x00454180",	"60be008043008dbe0090fcff5783cdffeb109090909090908a064688074701db" },	//	Auto_Buff v9	
	{ "0x004011ec",	"68ecbc4000e8eeffffff0000000000003000000040000000000000006c8f9836" },	//	Jewel Drop Beta	
	{ "0x00488070",	"60be008045008dbe0090faff57eb0b908a064688074701db75078b1e83eefc11" },	//	Chaos Bot 2.1.0	
	{ "0x0048a220",	"60be00a045008dbe0070faff57eb0b908a064688074701db75078b1e83eefc11" },	//	Speed Hack 1.2	
	{ "0x004013b0",	"685c874200e8eeffffff000000000000300000004000000000000000432f4d37" },	//	Hit Count	
	{ "0x00455180",	"60be00a043008dbe0070fcff5783cdffeb109090909090908a064688074701db" },	//	Dizzys Auto Buff	
	{ "0x00401344",	"eb1066623a432b2b484f4f4b90e998004700a18b004700c1e002a38f00470052" },	//	GodMode	
	{ "0x00435000",	"60e8000000005d5051eb0fb9eb0fb8eb07b9eb0f90eb08fdeb0bf2ebf5ebf6f2" },	//	Mu Cheater 16	
	{ "0x00401318",	"68a41f4000e8eeffffff000000000000300000004000000000000000ec82be15" },	//	MU Utilidades	
	{ "0x004441c0",	"60be000043008dbe0010fdff5783cdffeb109090909090908a064688074701db" },	//	MuBot	
	{ "0x00481870",	"60be003045008dbe00e0faff5783cdffeb109090909090908a064688074701db" },	//	Snd Bot 1.5	
	{ "0x00534000",	"8d8d512e4000505150ff95c72c40008985612e4000588d8d0f2e40005150ff95" },	//	Godlike	
	{ "0x00555030",	"74378d85fb2c400050ff95d72c40008d8d512e4000505150ff95c72c40008985" },	//	Godlike	
	{ "0x00401462",	"e8d3160e008bd0e88a670d005ae8e8660d00e8bf670d006a00e8c47b0d005968" },	//	Mu Philiphinas Cheat II	
	{ "0x00401000",	"b844ff41005064ff35000000006489250000000033c089085045436f6d706163" },	//	ZhyperMu Packet Editor	
	{ "0x00496ca0",	"60be005046008dbe00c0f9ffc787a85007009501a90c5783cdffeb0e90909090" },	//	DupeHack 1.0	
	{ "0x00499190",	"60be003046008dbe00e0f9ff57eb0b908a064688074701db75078b1e83eefc11" },	//	Auto Combo	
	{ "0x00470b74",	"558bec83c4f0b83c094700e8ec53f9ffa1442a47008b00e8f834feffa1442a47" },	//	AIO Bots	
	{ "0x006b5000",	"60e8000000005d50510fcaf7d29cf7d20fcaeb0fb9eb0fb8eb07b9eb0f90eb08" },	//	Nsauditor 1.9.1	
	{ "0x004691a0",	"60be00e044008dbe0030fbff5783cdffeb109090909090908a064688074701db" },	//	Super Bot	
	{ "0x004a851c",	"40ae807c41b7807c7b1d807c12cb817cea073a7e00000000000047657450726f" },	//	Ultimate Cheat	
	{ "0x00690002",	"e803000000e9eb045d4555c3e801000000eb5dbbedffffff03dd81eb00002900" },	//	ArtMoney SE	
	{ "0x00401aa8",	"e849240000e916feffff558bec81ec28030000a398d04000890d94d040008915" },	//	JoyToKey	
	{ "0x004010b0",	"68c82a4000e8f0ffffff000000000000300000004000000000000000697df4b1" },	//	codez	
	{ "0x0043fc4f",	"9061be009043008dbe0080fcff5783cdffeb10eb00ebeaebe88a064688074701" },	//	Mush	
	{ "0x00401000",	"b8a03748005064ff35000000006489250000000033c089085045436f6d706163" },	//	NoNameMini	
	{ "0x0048d080",	"60be00d045008dbe0040faff57eb0b908a064688074701db75078b1e83eefc11" },	//	Tablet2	
	{ "0x004032ee",	"558bec6aff6830434000688034400064a100000000506489250000000083ec68" },	//	Dupe-Full	
	{ "0x0044eb02",	"e8c5c00000e978feffffcccccccc518d4c24082bc883e10f03c11bc90bc159e9" },	//	Process Explorer 11.33	
	{ "0x00414014",	"b800000000600bc07468e8000000005805530000008038e9751361eb45db2d37" },	//	HastyMu 1.1.0	
	{ "0x00499cb0",	"60be002046008dbe00f0f9ff57eb0b908a064688074701db75078b1e83eefc11" },	//	Perfect AutoPotion	
	{ "0x0042f365",	"b9b0f44200b201b8f8ab4200e89eb8ffffa3b0164300a124164300e81731ffff" },	//	ghost mouse	
	{ "0x004b01d0",	"60be001047008dbe0000f9ff5783cdffeb109090909090908a064688074701db" },	//	cpch	
	{ "0x004db7c3",	"558bec6aff68205b50006800b54d0064a100000000506489250000000083ec58" },	//	gop	
	{ "0x00453588",	"558bec83c4f0b8e0334500e87c30fbffe8effdffffa13c4f45008b00e803d6ff" },	//	gop	
	{ "0x004170b4",	"4d79486f6f6b446c6c2e646c6c0000003100000047616d652053706565642043" },	//	game speed changer	
	{ "0x0041008b",	"68983d4100680c02410064a100000000506489250000000083ec685356578965" },	//	game speed changer	
	{ "0x004740d0",	"60be005044008dbe00c0fbff5789e58d9c2480c1ffff31c05039dc75fb464653" },	//	Autobot	
	{ "0x00419414",	"525344534e42c40947ab5147a3f5df0760d0689606000000443a5c446f63756d" },	//	AutoDrink	
	{ "0x00475b16",	"b8a8584700e89c08f9ffa164b447008b00e80429feffa164b447008b00c6405b" },	//	GzL	
	{ "0x00426ed4",	"683470420064a100000000506489250000000083ec685356578965e833db895d" },	//	speed gear 7.1	
	{ "0x005ce060",	"b82cbe5c00e89a99e3ff8b1d2c5e5d0033c05568ffe15c0064ff306489208b03" },	//	kikiuce	
	{ "0x00412be0",	"50b69dc52eae7570130f579564260b4bffb787657373616765426f7841337325" },	//	Hasty MU v0.3	
	{ "0x00410018",	"8d956cffffff880240423d0001000075f58d856cffffff8d956afeffff52688" },	//	miniproxer.exe	
	{ "0x00410000",	"33c05a5959648910681d0041008d45fce8df4effffc3e97d48ffffebf08bc784" },	//	wp507f.exe	
	{ "0x00410000",	"c765f97621d4c2c638ea58ff00169e4b97e1f3bc7e7582a14f02f1f1a8bfb3b0" },	//	tux engine	
	{ "0x00410313",	"e83c5affffb85cd16000e8424dffffb8905761008b1530974000e8f264ffffb8" },	//	scan engine	
	//{ "0x00410000",	"c2b731ce6e2792464f20ca401f6d2bd58b7f2f0fe50bb3ba7db29dc47e577c5b" },	//	proxcheat	
	{ "0x00410081",	"0b45496e4f75744572726f728d400094004100070b45496e4f75744572726f72" },	//	muproxy	
	{ "0x00410336",	"00e8185affffb85c116100e81e4dffffb8909761008b1554974000e8ce64ffff" },	//	engine.exe 5.6.1	
	{ "0x00410020",	"204040005c404000174556617269616e74496e76616c69644172674572726f72" },	//	Revolution Engine 8.3	
	{ "0x00410021",	"00f6c440740d8b43088b008985e8fcffffeb098b43088985e8fcffff8b85e8fc" },	//	djlammer&pcnoob	
	{ "0x00410006",	"e869eaffff8bc68b151ca34500e8244cffffe90f0400008d55fc0fbf4308e8ab" },	//	ProxCheatsX 2.0 DJlammer	
	{ "0x0041001c",	"e9660100008b45fc85c074168bd083ea0a66833a02740b8d45fc8b55fce85ae8" },	//	mu proxy Dark Edition	
	{ "0x00410048",	"80a941000b4552616e67654572726f725c004100070b4552616e67654572726f" },	//	mu proxy skype	
	{ "0x00410000",	"558bec81c4e0fcffff535657898df8fcffff8985fcfcffff668b028bc86681e1" },	//	Quick Memory Editor 5.2	
	{ "0x00410111",	"bd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5ac193" },	//	!xSpeed 6.0	
	{ "0x00410005",	"80ffff83d2ff8b55fc66894208e9480100008b45088b550c50c1f81f3bc25874" },	//	Xelerator 1.4	
	{ "0x00410000",	"ff5051e878a703008b45f883c4103818889de8feffff740bff45f88b45f8e942" },	//	autoit3.exe	
	{ "0x0041003d",	"837b20000f873b950100578d7c2410e89fffffff8d4c2408518d73188944240c" },	//	ProxCheatsX	
	{ "0x00410096",	"898590f6ffff8b4d0881c150050000898d94f6ffff8b954cedffff8b82e60a02" },	//	Memory Hacking Software	
	{ "0x004100a9",	"007cdb33f633db33c90fb7045d3c4741008d56028bea99f7fd66ba00408d2c19" },	//	DC-Bypass Public Version	
	{ "0x00419c3f",	"140704000d0000000b000000182621000d000000cdabbadc00000000b8f61200" },	//	Mini Anchor	
	{ "0x00410052",	"50ffd36a005568020100008b4e1c51ffd38d4c2438c744241cffffffffe8d4c1" },	//	cool game assistant	
	{ "0x00410013",	"0000ff7402ebc789178b4424085fc36689178b442408c64702005fc36689178b" },	//	GameWiz32	
	{ "0x00411dab",	"32189038d6c56d3400b8c4c862050074489051e5d594bf5680d453176a04e820" },	//	procexp.exe	
	{ "0x00410212",	"00e8c45dffffb864316200e8864fffffb8408862008b1594994000e89a6affff" },	//	Art Money	
	{ "0x00412008",	"01536c6565700001577269746550726f636573734d656d6f7279000152656164" },	//	hastymu	
	{ "0x00410000",	"741d0fb6752456ff7520ff751c50ff7514ff7510ff750c51ffd283c420eb1fff" },	//	muautoclicker.exe	
	{ "0x00410000",	"393c000084c0751d6a00ff75146884ce4500ff7518ff7510ff75f4e84af9ffff" },	//	SND AutoCombo	
	{ "0x00410000",	"178910595a5d5f5e5bc38bc08b0233c98948048b0233d2895008c3905356518b" },	//	loveengine	
	{ "0x00419c3f",	"782067bcf89727e20100010068fc3ce3685224e10300e812282167bcf89727e2" },	//	vicio master 1.0	
	{ "0x00412070",	"782067bcf89727e20100010068fc3ce3685224e10300e812282167bcf89727e2" },	//	vicio master 1.0	
	{ "0x004100a7",	"0075318b45103c3072043c3976143c4172043c46760c3c6172043c6676043c08" },	//	LordCHEAT	
	{ "0x00410006",	"008b45f4e8ad5dffffff75e4ff75ec8bc6ba03000000e8375cffff8b7df085ff" },	//	Vzla Engine 1.0	
	{ "0x0041000a",	"751766c703000133c08943088d43088b5608e8bb43ffffeb5b6681ff01017513" },	//	Fortress Trainer 2.0	
	{ "0x0041000f",	"33c9668b501052ff700cff7008894dec8d45ecff45e4e8fa8e07008d55ec8b83" },	//	MemoryDoctor	
	{ "0x00410000",	"44241a8064241a80740984c9c6442420017904885c24208844241b8064241b04" },	//	devil auto pot.exe	
	{ "0x00410005",	"ffffffff30dc40000856617269616e74738bc0558bec5356be20984500682498" },	//	autokeypresser.exe	
	{ "0x00410000",	"8bd48b4320e8d2fcffff8b0424ff480c8b042483780c0075488bd48b4320e831" },	//	ryu engine	
	{ "0x0041000b",	"010000eb0233c05f5e5bc9c3558bec518b4d088b551053568b7104578b398d99" },	//	GameWin32	
	{ "0x00410025",	"00f6c440740d8b43088b008985ecfcffffeb098b43088985ecfcffff8b85ecfc" },	//	catastrophe.exe	
	{ "0x00419c3f",	"67db5600001f661f67944e00001f661f676d5100001f661f67e5650000004e08" },	//	AxMRec	
	{ "0x00410000",	"89442414eb078b401c894424148b460c8b4e108d7e10894424208b41f885c074" },	//	reckey.exe	
	{ "0x00410000",	"c3e856f9ffff8b55908bc6e82849ffff33c05a5959648910688d0041008d4590" },	//	LT Trainer	
	{ "0x00410015",	"00008b431c485f5e81c414020000c3cccccccccccccccccccccccc8b460c3946" },	//	speed Hieu Nova	
	{ "0x00410056",	"55e8f0feffff59b824c16100ba1c014100b120e8323cffff0f95c3881d50c762" },	//	actool.exe	
	{ "0x00401828",	"558bec6aff68f0604000687c2c400064a100000000506489250000000083ec58" },	//	[Hasty MU v0.3] - By KingOfHack	
	{ "0x004018c0",	"8975d08d45a450ff1550604000e83a0c000089459cf645d00174060fb745d4eb" },	//	cai cuc cut	
	{ "0x00410016",	"85c0740b8b108bc88b4274ffd0eb0233c08b4c24288b5424246a005051526a02" },	//	proxifier	
	{ "0x00410000",	"52508d4c244051e8a4fbffff83c410c644244c05508d4c241ce8e261ffffc644" },	//	hotkeyb.exe	
	{ "0x00410050",	"204040005c404000174556617269616e74426164566172547970654572726f72" },	//	pumaengine3.0	
	{ "0x00410000",	"e8f5b8ffff8a45ef3c018a4de9884701880f740580f90175288b35a40445006a" },	//	autopot_v_1_2_rc7.exe	
	{ "0x004106a0",	"4175746f50726973696f6e004175746f50726973696f6e445800005072697369" },	//	AutoPrision DX	
	{ "0x0041005f",	"bd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5ac599" },	//	xspeed.exe	
	{ "0x0041002d",	"9090905589e5578d7df0565383ec1ca1e09644008b750c85c074618b483085c9" },	//	tablet.exe	
	{ "0x0041000c",	"0083c0d4e957bd000083442404d4e9159affff83442404d4e9339affff834424" },	//	New Castrophe	
	{ "0x00419c3f",	"0e000000b02739004f35e276cdabbadc00000000000000004f35e2762cf61800" },	//	AutoDrink Bot v2	
	{ "0x00410010",	"4100e8edfeffff59a3c4775a0055badcfa4000b894014100e8d7feffff59a3c8" },	//	moonlightengine.exe	
	{ "0x00419c3f",	"0c00120164f6120008975a750c001201000040000a0000000200000002000000" },	//	axmrec.exe	
	{ "0x00410000",	"83c6084b759e8d8500fdffff508b85f0fcffff506a0ce8bdecffff8985ecfcff" },	//	ProHack Multiserver 0.1	
	{ "0x00419c3f",	"00309535ff000000008501054000000000c84032ff0000000008010840000000" },	//	vicio master	
	{ "0x00410000",	"31ce6e2792464f20ca401f6d2bd58b7f2f0fe50bb3ba7db29dc47e577c5bf9bf" },	//	ProHack Multiserver 0.2	
	{ "0x00410000",	"ce6e2792464f20ca401f6d2bd58b7f2f0fe50bb3ba7db29dc47e577c5bf9bfd3" },	//	ProHack Multiserver 0.2 Acacias	
	{ "0x00410000",	"0000f7d81bc0f7d85dc3558bec8b450883e040f7d81bc0f7d85dc3558bec8b45" },	//	xspeed old ver	
	{ "0x0041000e",	"8bd78b04248b18ff5318eb0b8bd38bc78bcee81bffffff5a5d5f5e5bc3905356" },	//	clickerterramu.exe	
	{ "0x00410000",	"ff75fce868f3030083c40c8bcfe8aaf2ffff508bc7e81cf3ffff8b7dfc508b06" },	//	hpclicker.exe	
	{ "0x004116e0",	"e07c8efe78d9aafc0100050028c488fe28d678fe11004e0118ef84fef888e5fc" },	//	axmrec.exe	
	{ "0x00410000",	"5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5ac49766cba372d2af7fd5b181d8" },	//	xspeed_demo.exe	
	{ "0x0041006b",	"bd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5ac193" },	//	xSpeedPro.EXE	
	{ "0x00410104",	"8b53108d44243c83ca085056895310ff15e84b43008d4c242ce86a690100896c" },	//	SpeederXP (v1.60)	
	{ "0x00410000",	"ffff33c055688a00410064ff306489208d4df48bd38b45fc8b38ff570c8bd38b" },	//	autoskill.exe	
	{ "0x00410297",	"53656c66020002003700f8bd41001249735374616e64617264456e636f64696e" },	//	NLT Trainer	
	{ "0x004103c5",	"53cb01218f709e9053cb01218f709e9053cb01218f709e9053cb01b838f6f87f" },	//	vicio master 1.1	
	{ "0x00410000",	"80cb51e6aae92968626aadcb56226a2adc356d3bbbc71d3d43c6b1d94a867717" },	//	vicio master 1.2	
	{ "0x00410000",	"fbffffeb108bc28bd1e886fcffffeb05e86ffdffff5bc39053568bf28bd8e8a9" },	//	HeroesMu Hack	
	{ "0x00410000",	"8d45f88bd3e87655ffff8d45f48bd7e86c55ffff8d45f08bd3e86255ffff8bc6" },	//	Love Engine 0.5	
	{ "0x00410100",	"00000000d705c6771c29c677de6bb077ef2ac677c429c6779429c677ec29c677" },	//	hastymu2.exe	
	{ "0x00410000",	"248f9b45248f9b45248f9b45248f9b45248f9b45a6839d2aa6839d2aa6839d2a" },	//	hastymu3.exe	
	{ "0x004100a9",	"000000566172426f6f6c46726f6d53747200005661724273747246726f6d4379" },	//	SysCom Engine	
	{ "0x00410000",	"1ba6710840814cb14eee53cf207ae18028095ee07a2521a06b18e0bfbac6bef1" },	//	speedmuvn	
	{ "0x00410054",	"0250e8efab09008b4b088b73048bf8894424188d0c49c1e1028bd1c1e902f3a5" },	//	tsearch	
	{ "0x0041007e",	"e86d59ffffb8a4065d00e8874effffb8a0065d00e87d4effffb89c065d00e873" },	//	RyuGanJI	
	{ "0x0041002c",	"204040005c404000174556617269616e74496e76616c69644172674572726f72" },	//	Revolution Engine 7.2	
	{ "0x00410026",	"4083f81089460873036a105833c96a025a894608f7e20f90c1f7d90bc851e89e" },	//	eaea autobot	
	{ "0x0041014f",	"008b46503bc374128b0850ff51148b4650508b08ff5108895e508b46543bc374" },	//	RecKey	
	{ "0x00410010",	"427952656620000053568bf28bd88bc3e8f3e8ffff66c7030a008973085e5bc3" },	//	encdec	d
	{ "0x00410000",	"6966e8a5a434b1470c14ef1cb47745829e9d40ff000e7e9ed35cc13e1ba5166d" },	//	ProHack Multiserver 0.3	
	{ "0x00410000",	"52508d45d4e89a84ffff8b55d48bc6e8fc4bffffe9bb020000ff730cff73088d" },	//	ProHack Multiserver 0.2.1	
	{ "0x00410070",	"8b15e8104000e87559ffffb8a4665d00e88f4effffb8a0665d00e8854effffb8" },	//	Cheat Engine.exe	
	{ "0x00410010",	"e8874affff8d45f0ba04000000e87a43ffffc3e9d03cffffebb75e5b8be55dc3" },	//	gold__dupe_hackrat.exe	
	{ "0x00410053",	"e8bc48ffff8d45f0ba04000000e8db41ffffc3e98d3bffffeb905e5b8be55dc3" },	//	saaandrinho trainer 1.0p.exe	
	{ "0x00410008",	"dc3c4000f83c4000343d4000154556617269616e744469737061746368457272" },	//	ProHack Magdalena v2	
	{ "0x00410000",	"32ffff33c05a5959648910eb1be9be37ffff8b45fc668b0066ba1200e86febff" },	//	clicker.exe	
	{ "0x0056784c",	"c685e47fffff0b8d95d87fffffb901000000b8d8785600e86035eaff8b95e87f" },	//	NHMGProxyAdvanced private version	
	{ "0x00496cda",	"75078b1e83eefc11db11c001db730b75288b1e83eefc11db721f4801db75078b" },	//	nhmGOLDDupe 97d	
	{ "0x004851c2",	"751c538bceff75e4ff75e057e89001feffeb0b5357ff761cff159cf548008b86" },	//	nhmWPePro 0.9a	
	{ "0x0044397b",	"75078bcfe8f8f2ffff5f5ec2080053568b74240c57ff7604ff15c49b49008bd8" },	//	nhmWPePro 1.3	
	{ "0x004013f9",	"e81a210600a38b90460083f8007391b8fc000000e87affffffc3833d8b904600" },	//	nhmWildProxy v0.1	
	{ "0x004013b0",	"e8d7ffffffb9b4000000516a08e8f400070050e8600107000bc0750ab8fd0000" },	//	nhmWildProxy v0.2	
	{ "0x00401401",	"e8b6ffffff5050ff358bc04700e8ad540700ff358bc04700e8b65407005fc3b9" },	//	nhmWildProxy v0.3	
	{ "0x004cbd70",	"8d857cfeffffba03000000e8b08ff3ff8d8588feffffba04000000e8a08ff3ff" },	//	nhmCheat Engine 5.1	
	{ "0x005839e7",	"8d45b0506a088d8578ffffff50a1b0a159008b55a48b049050a128a1590050a1" },	//	nhmCheat Engine 5.2	
	{ "0x004cbe2b",	"8d55f0b9040000008bc7e80215f5ff8b55f08bc3e88cf7fdff8d55f0b9040000" },	//	nhmCheat Engine 5.3	
	{ "0x005fecf4",	"558bec83c4ec5333c08945ecb8e4e45f00e89e89e0ff8b1dec62600033c05568" },	//	nhmCheat Engine 5.5	
	{ "0x00401414",	"68a4224000e8eeffffff000000000000300000004000000000000000188ef708" },	//	nhmSpeed Hack 99.62t	
	{ "0x0047a1c0",	"60be00f045008dbe0020faff5783cdffeb109090909090908a064688074701db" },	//	nhmBot MGDKELF	
	{ "0x004317b7",	"a15cf446008945e88b4df0894ddc8b55dc52e80823010083c404c745f0000000" },	//	nhmxSpeed.net3	
	{ "0x00401000",	"e89b27000050e8a72201000000000090558bec5356578b7d108b5d0c8b75088b" },	//	nhmDC Bypass	
	{ "0x0044e284",	"558bec83c4f4b814e14400e8007dfbf0a1cc0845008b00e8a8eafeff8b0d9409" },	//	nhmRazor_Code	
	{ "0x00402e00",	"184975f35a29d088025bc390535789c731db88cb89d931c0f3aa29df4088d1d2" },	//	nhmCheatmaster	
	{ "0x004b7bff",	"742c6a006a006805800000a1e0a44b008b008b0050e8dff3f4ffa1e0a44b008b" },	//	nhmXelerator 2.0	
	{ "0x005feb64",	"b0cb520080cb5200b8cd550088cd55008cc955005cc9550048ac550018ac5500" },	//	nhmCheatEne55	
	{ "0x00539abf",	"8b03ba709b5300e851c8f5ff8b0d98d753008b038b15e01e5300e85eccf5ff8b" },	//	nhmQuickMemory5.0	
	{ "0x005aaf75",	"33d2e82cf7e9ff8b038b80b803000033d2e81df7e9ff8b038b80a803000033d2" },	//	nhmartmoney	
	{ "0x00693e8f",	"bb2000000057bf2966737929fb5fe9e714000081f22363194681ea6750165f81" },	//	nhmMLEngine1348	
	{ "0x00401025",	"832d6478400000751b833d70784000007512b9030000008b154070400033c0e8" },	//	nhmPinnacle	
	{ "0x0074f1f2",	"c7054cfe740001000000010500fe7400ff3500fe7400c3c3565768a0f07400ff" },	//	nhmLoveengine0.5	
	{ "0x00401838",	"558bec83c4dc8a550c8855fc84d27e0b8b4508e830700a00894508b87cd14b00" },	//	nhmwipro	
	{ "0x006e5b88",	"ff96f4782e0009c07407890383c304ebd8ff9604792e008baef8782e008dbe00" },	//	nhmMuProx	
	{ "0x0042727a",	"558bec6aff68a87a430068e473420064a100000000506489250000000083ec68" },	//	nhmSpeederXP 2.62	
	{ "0x0042735a",	"558bec6aff68b07a430068c474420064a100000000506489250000000083ec68" },	//	nhmSpeederXP 2.63	
	{ "0x00592500",	"60be004051008dbe00d0eeff5783cdffeb109090909090908a064688074701db" },	//	nhmMu Bypassor 1	
	{ "0x0041155c",	"558bec83c4f0b884144100e8c822ffffb8bc154100e85e4bffff8b15dc234100" },	//	nhmHide Toolz 2.1	
	{ "0x005411c8",	"c03dc43dc83dcc3dd03dd43dd83ddc3de03de43de83dec3df03df43df83dfc3d" },	//	nhmMu MultiHack	
	{ "0x004e7530",	"54202a2046524f4d20636f6e66696720574845524520646174653d4355524441" },	//	nhmMensajes_Join	
	{ "0x004e75a0",	"454354202a2046524f4d20736974656c6973742057484552452076697a69746f" },	//	nhmCapoteCheat	
	{ "0x004e75e0",	"2042592076697a69746f72737065726465790053454c454354202a2046524f4d" },	//	nhmRedox Packer	
	{ "0x004a7300",	"8848b8788444b4748b4bbb7b8747b77728e818d824e414d42beb1bdb27e717d7" },	//	nhmGame Gears 2009	
	{ "0x004443f0",	"4e554c4c00000000486f6f6b4f6e6547616d65203d3d4e554c4c0000556e686f" },	//	nhmGame Speed	
	{ "0x0044329f",	"8b5510eb84610fb645ffc9c2200090558bec53515257568b5d088b7d0c8bd30f" },	//	nhmSpeederXP 1.80	
	{ "0x0054deed",	"1a8e0eb8f9c5cd5afe04e3d10d2d08f76a0a2cd0b8f7575fe5d3be0848a0543a" },	//	nhmSpeederXP 2.32	
	{ "0x004274ba",	"004a4300ff25f8494300ff25f4494300ff25f0494300ff25e8494300ff25dc49" },	//	nhmSpeederXP 2.63	
	{ "0x0042580a",	"05e88d670000ff742404e8bd6700005968ff000000ff1594c24400c3cccc6aff" },	//	nhmGame Speeder 1	
	{ "0x00410186",	"8d45a450ff1518214100f645d00174110fb745d4eb0e803e2076d84689758ceb" },	//	nhmSpeed Changer	
	{ "0x00417e50",	"8bc8c1e01003c18bca83e203c1e9027406f3ab85d274068807474a75fa8b4424" },	//	nhmSpeed Controller	
	{ "0x0040caf4",	"894d985051e8394600005959c38b65e8ff7598e816feffff833d6cef42000175" },	//	nhmGameWiz32 1.43	
	{ "0x006870e0",	"803e22750146f3a4c60700eb3e8db5412b40008dbde531400033c0803e007404" },	//	nhmQuick Maro	
	{ "0x004b7688",	"5964891068c9764b008d45e8e8e7d1f4ff8d45ece8ffcaf4ff8d45f0e8f7caf4" },	//	nhmXelerator 2	
	{ "0x00426f9a",	"43008b3089758c803e22753a4689758c8a063ac374043c2275f2803e22750446" },	//	nhmSpeed Gear 7	
	{ "0x00426f4a",	"430059e8fa00000068b860440068b4604400e8e5000000a1e47844008945948d" },	//	nhmSpeed Gear 7.1	
	{ "0x0067ce40",	"0b75198b1e83eefc11db72104801db75078b1e83eefc11db11c0ebd431c983e8" },	//	nhmA Speeder 2008	
	{ "0x005d6061",	"95490f00008985510500008d4577ffe05669727475616c416c6c6f6300566972" },	//	nhmCrazy Speeder 1.05	
	{ "0x00430aa4",	"2e000b4f6e4d6f757365446f776ed8ad4400d80000ffd80000ff010000000000" },	//	nhmQuick Memory 5.5	
	{ "0x0068e091",	"db740a8b0387853505000089038db569050000833e000f84210100006a046800" },	//	nhmArtMoney SE v7.30	
	{ "0x006d2061",	"95490f00008985510500008d4577ffe05669727475616c416c6c6f6300566972" },	//	nhmArtMoney SE v7.33	
	{ "0x0040158b",	"8b0482c390b8a8404e00e826210600c390b8a8404e00e82a210600a1b8404e00" },	//	nhmUltimate Global	
	{ "0x0048d0c0",	"11db721f4801db75078b1e83eefc11db11c0ebd401db75078b1e83eefc11db11" },	//	nhmSnd.Bot 1.8	
	{ "0x0048d0a0",	"db72edb80100000001db75078b1e83eefc11db11c001db730b75288b1e83eefc" },	//	nhmSnd.Bot 1.82	
	{ "0x0048bcdc",	"d0d84200a0d8420090d5460020d5460054f0420024f04200fcf94200a8f94200" },	//	nhmMu Proxy 1.0	
	{ "0x00401358",	"6a00e8113408008bd0e8ee5806005ae84c580600e8235906006a00e8286d0600" },	//	nhmZiomal 0.8	
	{ "0x00401030",	"02e4d4e7a309ecc098a15cb1a8f6e3c33109cf1fc14eabb45ced5c9f7f673146" },	//	nhmGUnot v.1	
	{ "0x00401092",	"9dde7b0f4b3e74e827ca8aaa7ff67b477e30f3d6d0d99880c06028b9a6755b48" },	//	nhmGUnot v.2	
	{ "0x00512ca3",	"85c075086a1ce8b0000000598975fce843130000ff158c605300a3e4ec5300e8" },	//	nhmBypass	
	{ "0x006c4810",	"210018a60f3e57eb11909090909090908a064688074701db75078b1e83eefc11" },	//	nhmMU Proxy	
	{ "0x0060ccec",	"ba80ce6000e832ffe8ff8b0383c050ba9cce6000e8b383dfff8b0de83e61008b" },	//	nhmCheat Engine 5.6	
	{ "0x0061063a",	"bae8076100e800c8e8ff8b0383c050ba04086100e8654adfff8b0dec7e61008b" },	//	nhmCheat Engine 5.6.1	
	{ "0x005fed34",	"bab4ee5f00e812bfe9ff8b0383c050bad0ee5f00e86b63e0ff8b0d805e60008b" },	//	nhmPsych Tool v1	
	{ "0x00499c98",	"558bec83c4f0b8e4834900e8d0cff6ffa1b8d349008b00e89c2cfdffa1b8d349" },	//	nhmAnti PlaySafe 1	
	{ "0x0052f2a9",	"68ea2dd9a5e82b8c08006842e8f7a5e854710800d13a81f8e856e6feff682276" },	//	nhmSpeederXP 2.61	
	{ "0x0048bdd8",	"558bec83c4f0b8f8ba4800e8f8aaf7ffa18ce048008b00e88015fdff8b0d70df" },	//	nhmMuOnline hacker 2	
	{ "0x0040122c",	"6840234000e8eeffffff0000000000003000000038000000000000000997670d" },	//	nhmKlick0r	
	{ "0x00438fd8",	"558bec83c4f4b8d88e4300e858c1fcffa184ab43008b00e8c418ffff8b0d00ac" },	//	nhmTradeHack 1.3	
	{ "0x00403235",	"e8bc2a00005fc9c20800558bec83c4f4536a0a8d45f650ff7508e84e2a00008b" },	//	nhmxSpeed.net 1.4	
	{ "0x00435010",	"eb33c074f2b887c9404885c075dde9619d669266928bc08b85c4f5ffff2b0574" },	//	nhmxSpeed.net 5 Demo	
	{ "0x00411002",	"720043006c006f0063006b0020004c006500760065006c002000350000000000" },	//	nhmHastyMu v0.3	
	{ "0x00402b66",	"dd216eb32d91d91c7bc10853a15581a6fff6fffdefba7c94aa5268a24d506c44" },	//	nhmSimplifier 1.3	
	{ "0x0040109a",	"43617264696e616c0500000000ffffffff90b01040000408457874656e646564" },	//	nhmMuProxy	
	{ "0x0058ec2a",	"496e666f4576656e740101110570496e666f0e54444f43484f53545549494e46" },	//	nhmMuproxy2.0	
	{ "0x004544e4",	"e96ffcfaffebf08bc35f5e5b595dc390558bec81c4f0feffff535633c9898df0" },	//	nhmMuproxy1.0	
	{ "0x0040106f",	"75ef85f67517ff15388241005e8b4c2408334c240c83c40ce9d52800008b4c24" },	//	nhmDKAEMulriStrike 1.02n	
	{ "0x00401099",	"ff5204c39090906aff68855c410064a100000000506489250000000051568bf1" },	//	nhmDKAEMulriStrike All Ver	
	{ "0x00401075",	"ff152c8141005e8b4c2408334c240c83c40ce9a52800008b4c240c334c24108b" },	//	nhmDKAEMulriStrike 1.0E	
	{ "0x004010fa",	"ff153c824100ff1590f041008b8c2494000000338c249800000081c498000000" },	//	nhmDKAEMulriStrike 0.97	
	{ "0x004020b8",	"7d1000000402281000000a2a133003001700000000000000027b0d000004036f" },	//	nhmMuPie HG RC1	
	{ "0x00401045",	"c04b73cc934e733d9e4b73e2474c7346014d73549e4b7346024d7387c24b739c" },	//	nhmProxy Hit Hack	
	{ "0x004020dc",	"731600000a7d02000004027b020000046f1700000a0002281800000a00027b04" },	//	nhmMuCerool	
	{ "0x00401063",	"e8ba130000ff35fe604000ff35f46040006a00ff3504614000e82c0b0000e884" },	//	nhmPermEdit	
	{ "0x004010b6",	"702b4000001e40344000001ebc414000001e34844100001ea0884100001e680f" },	//	nhmWildPowerSkill	
	{ "0x004010a1",	"e8fa0a0000e8d50a00008b1520664000891089ec5dc3890424e8d10a00008b15" },	//	nhmHastyMu v0.1.4	
	{ "0x0040113b",	"000707544f626a656374301140000000000000000653797374656d00005c1140" },	//	nhmNoobhack/GMO Gunz	
	{ "0x004010e0",	"75626c65018d4000ec1040000a06537472696e67f81040000b0a576964655374" },	//	nhmMoonlight Engine	
	{ "0x0043a521",	"6971c7970b3bd1a0c689e68c9a1de2a9824d9bb6112f7773ed0de6719e9ff53c" },	//	nhmKiasu Bot 1.4	
	{ "0x0040f57b",	"813863736de0752a8378100375248b40143d2005931974153d21059319740e3d" },	//	MuAutoClicker 2.2	
	{ "0x0041001c",	"41004200f4ffcf0041004200f4ff13545468726561644c6f63616c436f756e74" },	//	newone.exe	
	{ "0x00410000",	"6300e8754fffffb890f66300e86b4fffffb88cf66300e8614fffffb880f66300" },	//	Spuc3ngine	
	{ "0x00413380",	"60be000041008dbe0010ffff5783cdffeb109090909090908a064688074701db" },	//	Hasty S4	
	{ "0x00459085",	"e8d6bb0000e978feffffcc518d4c24082bc883e10f03c11bc90bc159e9cac7ff" },	//	Process Explorer v12.04	
	{ "0x00419c3f",	"00184a2de300000000080408000000000090482de30000000005020500000000" },	//	SandboxieInstall350	
	{ "0x004014a0",	"6804184000e8f0ffffff000000000000300000004000000000000000afe5b40b" },	//	Proxy Hit Hack	
	{ "0x004029b8",	"68742b4000e8f0ffffff0000000000003000000050000000400000000b1781dd" },	//	Vault Blaster (CBlaster)	
	{ "0x00402650",	"680c284000e8eeffffff0000000000003000000050000000400000001f768544" },	//	Vault Blaster (VBlaster)	
	{ "0x00010430",	"481e0001ec890001000000002e3f4156434f626a6563744040000000ec890001" },	//	Sandboxie3.4402	
	{ "0x007d2210",	"57e9807c3c94807cb724807c1bae807c980f817ca14d837ccffc807ccdfd807c" },	//	Sandboxie3.30	
	{ "0x00410000",	"3834323834323834323834323834323834323834323834323834323834323834" },	//	dupe hack 1.0.exe	
	{ "0x00610679",	"8b0d3c7f61008b038b1554345800e8d8cbe8ff8b0df88561008b038b1524eb59" },	//	Cheat Engine 5.6	
	{ "0x00492bda",	"75078b1e83eefc11db11c001db730b75288b1e83eefc11db721f4801db75078b" },	//	Agility Hack By TopGun	
	{ "0x00413a64",	"01db50726f496e6a6563746f72001079426d734d656d5574696c0000c7537973" },	//	PC_HACK ultimo	
	{ "0x004765d0",	"eb109090909090908a064688074701db75078b1e83eefc11db72edb801000000" },	//	autoPot	
	{ "0x00476647",	"8b1e83eefc11db72cc4101db75078b1e83eefc11db72be01db75078b1e83eefc" },	//	autoPot2	
	{ "0x00410000",	"1bc0408d4dfc33d2e8efa1ffff8b55fc8b4514e88457ffff33db33c05a595964" },	//	Projectx Engine 3.0	
	{ "0x0041004e",	"00000f94c18bf985ff750f8b44240c85c074078bcee878fdffff8bc75f5ec204" },	//	RecKey.exe	
	{ "0x00410003",	"002573202d68000000736f6674776172655c6d6963726f736f66745c77696e64" },	//	hidetoolz v2.1.exe	
	{ "0x00410000",	"e6f2ec5aaea7c9fc8bdbdbdb399ddf15fbf3ae72d8cde599a8c8e77215596c83" },	//	PrOhack 5.0	
	{ "0x00410009",	"64ff306489208d55fca1ccc44f00e8506cffff8b4dfcb201a120fc4000e855ce" },	//	trainer mu v2.1	
	{ "0x00410000",	"e8af52ffff8b55ec8bc6e8514cffff33c05a5959648910682c0041008d45f0e8" },	//	celite	
	{ "0x0041003f",	"008b45fc8b4008d900e8e72cffff50c1f81f3bc2587405e80d34ffff8945f8e9" },	//	MSL cheat	
	{ "0x00419c3f",	"140b28000d0000000d00000088241c000d000000cdabbadc00000000b8f61200" },	//	rundll32.exe	
	{ "0x00410000",	"3bc772f48a458a84c0c6859803000020742b8d5d8b0fb6c80fb6033bc877162b" },	//	clickergui.exe	
	{ "0x004b32a9",	"83ec10a1543778008365f8008365fc005357bf4ee640bb3bc7bb0000ffff740d" },	//	MHS	
	{ "0x00410000",	"b374d7772ced5001a263c6861dde410e9556eb6806014100e9cfa2ffff68e101" },	//	dllloader.exe	
	{ "0x00410000",	"d6d823c2bc60f9604001d64c01f26877212f3127e08180e1c270129818c17fea" },	//	eviluser.exe	
	{ "0x00410000",	"0394090fd06b524a0066dfd1fb9b603d19d7d3fc43ff8040c2cc616c7cd6f6af" },	//	hack.exe	
	{ "0x00410000",	"f4f152fc4af8f9218d23797a33aa24bfee7ab575f6df673f83fa4faffda7f47a" },	//	Hacker Mu Connect	
	{ "0x00410000",	"008bcee8e418ffff508d8d00ffffffe89c1cffff8bcee8a818ffff8bcee8ca18" },	//	red.exe	
	{ "0x00410029",	"8bcee89771ffff6a0158e9940100008d45fc8bcf508d45fd508d45fe508d45ff" },	//	joytokey.exe	
	{ "0x00411068",	"6896e6bbb01eb5e501002900a89ae9bb30c207e31100893d7867e7bb786c71e4" },	//	oasisbuff.exe	
	{ "0x00410000",	"88ffff8b55fc8bc3e80753ffffeb268d45f08b13e87f4cffff8b45f08d55f4e8" },	//	autokeyboard.exe	
	{ "0x00410000",	"e8e711000083e07f8945fceb0c668b1366b90300e8b7f3ffff33c05a59596489" },	//	winspeeder.exe	
	{ "0x00410000",	"184d00e8846fffff8b4dfcb201a10cfc4000e85dcfffffe8804affff33c05a59" },	//	xpadder.exe	
	{ "0x0041008b",	"00002074388d54240c5256ff1530b343006a018b44241c8b5424148b4c24182b" },	//	keytext.exe	
	{ "0x00410000",	"8bc6e8594a000084c0740c8bd38b04248b08ff5124eb0b53e807eaffffe856fc" },	//	DH Hack	
	{ "0x00410000",	"8b43088bd08bc6e864fbffffeb3e8d55908bc3e874f9ffff8b55908bc6e8da46" },	//	autokeyboard.exe	
	{ "0x00410000",	"d6ea35af817d6405cc61890a54c21e566cd81e8cc1bd47cc6017ed8410bf38c5" },	//	hack mu.exe	
	{ "0x00410020",	"505268d83aec60555356578d742410ff760c5589e55152648b1d380e00008b7b" },	//	ping spiker lagger.exe	
	{ "0x004140f2",	"3c6080ba2864fcc2286400102664fcc228640cdc2864001026640c7fd15f1889" },	//	lagger1.exe	
	{ "0x00410000",	"ffffeb1985c97f158bc1b9ffff000099f7f985d275078bc3e817feffff5a5bc3" },	//	cheat engine.exe	
	{ "0x004531a0",	"75078b1e83eefc11db72edb80100000001db75078b1e83eefc11db11c001db73" },	//	pinnacle2	
	{ "0x4ad05055",	"ff151c10d04a6681384d5a0f85f30000008b483c03c88139504500000f85e200" },	//	speedplus	
	{ "0x00437000",	"426f726c616e6420432b2b202d20436f70797269676874203139393620426f72" },	//	OMATIC.EXE	
	{ "0x0041004c",	"83f84075068b1510446d008b45ec83e0037c3d85c07408487416487424eb318b" },	//	cheatenginei386.exe (Ver 6.0)	
	{ "0x00410000",	"a4030e5518fc4ea01d05cb2769608d140c9ce8fa4b67e46f66674b3865ec67f0" },	//	hastymuforvn.exe	
	{ "0x00454180",	"60be008045008dbe0090faff57eb0b908a064688074701db75078b1e83eefc11" },	//	Chaos Bot 2.1.0	
	{ "0x00410000",	"cbb201a148bf4000e89b95ffffe8a634ffff5bc3a1085c4700e8deffffffc390" },	//	dc cheat v1.0.exe	
	{ "0x00410046",	"00740433c05ec3b0015ec3e8a7ddffffc3558bec6a005356578bf033c05568d4" },	//	omatic.exe	
	{ "0x00410000",	"45fce81954ffffc3e9a74cffffebf08bc35b595dc2100090ff254c104c008bc0" },	//	Snd.Bot 3 for AE (Build 3.0.2.5)	
	{ "0x00410033",	"80d3ea09108b550c8b4dfc8d4432fc8908894c01fceb038b550c8d46018942fc" },	//	muautoclicker.exe	
	{ "0x004100b9",	"ff15585048008d54242c8d44240c5268aca1490050e8254e06008b4c241883c4" },	//	macromaker.exe	
	{ "0x0041501d",	"95410064954100666f726d4d6163726f000000666f726d4d6163726f45646974" },	//	macro.exe	
	{ "0x00410000",	"0cff73088d45e8e8c4f4ffff8b55e88bc6e8164cffffe969030000568d45e48b" },	//	x1nject.exe	
	{ "0x006d1e8d",	"e80e92f6ff8b45cc8d55d0e8130ee8ff8b45d089f2e8b960d3ff85c07e128b55" },	//	Cheatengin60	
	{ "0x00410000",	"0b740643433bd87ef1804d09028b7d1883ffff7546f64509028bfb740e33c980" },	//	speed_v12.exe	
	{ "0x00410000",	"d04c99b4ed2a2918ed944698824bde469af7bcb00d6c1068ab097848c21e8fc0" },	//	Hack Mu.exe	
	{ "0x0041003b",	"e89446ffff8d45f0ba04000000e8873fffffc3e96139ffffeb905e5b8be55dc3" },	//	Cheatah inject v1.1	
	{ "0x004211dc",	"74798bc2c1e81033db8bb53905000003b522040000833e0074618b4e0483e908" },	//	xspeed new	
	{ "0x0047f5d1",	"be005045008dbe00c0faff5783cdffeb109090909090908a064688074701db75" },	//	combo	
	{ "0x0041081a",	"0000d04740005c6c4273286c427313ea4273585348732c964e730e9f4e73aa9f" },	//	hack Mu.exe (pro ver)	
	{ "0x0041001a",	"7508dc3578144000eb11ff357c144000ff3578144000e87f14ffff89952cfeff" },	//	hack Mu.exe (pro ver) 2	
	{ "0x0041001b",	"33f63bc5897424100f8eb5020000578d7b0489442418eb068b74241433ed8b8c" },	//	tsearch_korean.exe	
	{ "0x0041034f",	"0064284000746c9472406c947259ea947295e8a172d197a072b3a0a0724fa1a0" },	//	keypresser.exe	
	{ "0x0041005b",	"33c08b0b8b098904b18b45f88b4d0803c88d45dc508b0366c745dc0c40894de4" },	//	auto_combo_by_bl.exe	
	{ "0x004102e3",	"008b7c24208d44241c8b4e206a00f7d81bc023c7506a2751ff15c46a43008b3d" },	//	godlike.exe	
	{ "0x0041001c",	"909090905156578bf933f68b470c85c07e3053558b2dcc8143008d5f048d4424" },	//	godlike.exe	
	{ "0x004100b5",	"8958ff885804668950f905200100004975e95bc3cccccccccccccc32c0833dac" },	//	autohotkey.exe	
	{ "0x00410005",	"33c0668b46085033c08a461250e8ea31000083c40c3ac38845f8741a385d1374" },	//	autopots(w).exe	
	{ "0x00410000",	"09c648b8ffffffffffffff7f4821c64889d84885c0740d4889f0489948f7fb48" },	//	cheatenginex86_64.exe	
	{ "0x0041081b",	"009c474000746c9472406c947259ea947295e8a172d197a072b3a0a0724fa1a0" },	//	hack mu.exe ver 2.0	
	{ "0x0041092b",	"00e427e0030c02d07610fecf76c4fccf762c02d076b49fcf76d4fccf76d89fcf" },	//	automousekey.exe	
	{ "0x00410000",	"65ac682c514d00e8ade30600898530ffffff8b9530ffffff89952cffffffc645" },	//	khotkeys.exe	
	{ "0x00410000",	"5f5e5b595dc2080053565784d2740883c4f0e82941ffff8bf18bda8bf88d5704" },	//	keyboard.exe	
	{ "0x00000050",	"69732070726f6772616d2063616e6e6f742062652072756e20696e20444f5320" },	//	hack1	
	{ "0x00032c40",	"ff7424048f4500ff742404686a11288a8d642410e9a6f5ffffe970f7ffff9c9c" },	//	hack2	
	{ "0x00407000",	"cb9bd83c7fd1605831ba4a424f15400f0f89e71fca374a7ed053412b2eaa7d25" },	//	hack3	
	{ "0x00465a80",	"3a762d4eaa53a3d5d6e575baee925ba5d7ec25f63b2e9b67d3f51b4dad7be475" },	//	hack4	
	{ "0x00464c19",	"2404686a11288a8d642410e9a6f5ffffe970f7ffff9c9c8f04249ce92cedffff" },	//	hack5	
	{ "0x00436000",	"7177dbe19976c9064178c230be24c3b166920244ddb5cbb38eb5d71715d78c79" },	//	hack 6	
	{ "0x00401600",	"e857160000e899150000e8ed0400008975d08d45a450ff1548604000e82a1500" },	//	speedkr	
	{ "0x00410000",	"e8df44ffffeb5b6681ff0101751366893b8b46088943088bc3ff151c384e00eb" },	//	HyM	
	{ "0x00413714",	"c889a5fe7894b1ff11002001f88da3fed88d1bfe0100060048c8a6fed8ddfcfd" },	//	cheatfoni	
	{ "0x00412148",	"285aa9fed8dd52fe010017004857a9fec82262fe020011002877a7fee85892fe" },	//	cheatfoni3	
	{ "0x00410000",	"63000084c0740c8bd38b04248b08ff5124eb0b53e82be9ffffe856fcffff5a5e" },	//	xpe_repacked.exe	
	{ "0x00411000",	"558bec83ec0c8b451050e8208a020083c4048945f88b4df8894dfc8b550c528b" },	//	speedwiz.exe	
	{ "0x00410016",	"0606060618181818181818181818181818180606060606181818181818180618" },	//	HD	
	{ "0x0041039f",	"00010003138fdfdcdbdfdfdfdfdfdfdfdfdddbdddfdfdfdfd7dfd98a1a000202" },	//	cbo.exe	
	{ "0x00419c3f",	"620881000d00000013000000f02439000d000000cdabbadc00000000b8f61200" },	//	micro auto 4.6.exe	
	{ "0x00410000",	"4c8d0539ffffff4889f24889d9e8aefdffffeb434c8d0525ffffff4889f24889" },	//	CheatEngine6.1	
	{ "0x00410021",	"ff3580e97a00e81413ffffc9c300005589e5a180e97a0083f8ff751ee8de12ff" },	//	CheatEngine6.1modded	
	{ "0x00410000",	"ffff83e07f8b1c856014560033c05a595964891068290041008d45fce8af48ff" },	//	speeder.exe	
	{ "0x0041010b",	"9090909090535556578bf933f68b470450ff1594b544008b6c241885c07e3d8b" },	//	speeder.exe	
	{ "0x00410112",	"6892e84300685cfc43006854fc43008d4c242c518bc8e847910200508bcfc644" },	//	gamespeed.exe	
	{ "0x00410000",	"2952b2a7847c1ecb1a4135bdae327d9c153ead63ebdab7360ac4c825a8308ce0" },	//	SpeedMUVN	
	{ "0x00406180", "4C769C57ECA99E316B0730E1108A90148794C50F4FD7DDA9013772226F3DF835" },	// MSGS_V1.00.82
	{ "0x004CD3E8",	"558BEC83C4F4B8B8D04C00E88893F3FFA188F84C008B00E84415F8FFA188F84C" },	// name

	/*
	{ "0x0041003a",	"5f5f7662614650457863657074696f6e000000005f5f76626153747256617256" },	//	autokeystroke.exe
	{ "0x00775af8",	"7555c70601000000568d45d4e837edc8ffc745d4000000008d55d489f8e8c626" },	//	cheatengine61
	{ "0x00410000",	"fff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ec" },	//	fcspeed
	{ "0x0041002d",	"2c4d00881dcb2d4d00881dca2d4d00668915cc2d4d00881dc92d4d00881dc82d" },	//	autohotkey
	{ "0x00410000",	"8b1033c989088bc2e8c741ffffc38bc05356578bf98bf28bd885db740b575653" },	//	pfat.exe
	{ "0x004135a3",	"000ec301c76fa864000004a049444154484bb596d9535a6718c6f32ff5b217ed" },	//	Solid Proxy 1.15
	{ "0x00410000",	"f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9" },	//	speddfc
	{ "0x00410000",	"5151ff515151ff515151ff515151ff515151ff515151ff515151ff515151ff51" },	//	Spe3dH4ck
	{ "0x0041006d",	"8b1083c2203bca7e0583c1e0890883c8ff33d28d7de8e832340000834dfcffff" },	//	mu_macro.exe
	{ "0x004100cb",	"00eb298bd38bc6e809feffffeb1ef6c4207410b908ff40008bd38bc6e830fbff" },	//	mu lite trainer
	{ "0x00410000",	"0101750a8bc3ff1514c84a00eb3466f7c6002074098bc3e834feffffeb248bd4" },	//	CE Lite
	{ "0x00410083",	"e8984c00006a048d4c240c518d54242c52e86722000083c414535556c7442414" },	//	auto combo 2010.exe
	{ "0x00411800",	"a8c0e6bb28281be10100010018922be3b826a3e20300a91288c1e6bb28281be1" },	//	mu editor.exe
	{ "0x00410000",	"ff3580e97a00e81413ffffc9c300005589e5a180e97a0083f8ff751ee8de12ff" },	//	CheatEngine6.1modded
	{ "0x00410112",	"2952b2a7847c1ecb1a4135bdae327d9c153ead63ebdab7360ac4c825a8308ce0" },	//	SpeedMUVN
	{ "0x00415230",	"5e1f1f5f620a0609610a081a5e2d12060706580818641f105e19581f1f5f6461" },	//	solidproxy.exe
	{ "0x004154a0",	"5e1f1f5f620a0609610a081a5e2d12060706580818641f105e19581f1f5f6461" },	//	Solidproxy.exe
	{ "0x0041002d",	"00740d66ba020066b80100e8e3e7ffff33dbeb7a8b5dfc668b5b08eb718b5dfc" },	//	musniff.exe
	{ "0x00410000",	"558bec83c4e4535633c9894dec894de8894de48bf28bd833c055688f00410064" },	//	sniffer.exe
	{ "0x00410000",	"ffc3e9b53bffffeb905e5b8be55dc3905356578bd98bf28bf866f707e8bf7407" },	//	simplemodulustool.exe
	{ "0x00410000",	"80faffff84c075148d55908bc3e856f9ffff8b55908bc6e81c49ffff33c05a59" },	//	MUGAY Player loader
	{ "0x004109b1",	"220a0a222ae3e3230a0a0a0a0a0a232ce36f0a222be3e36e2be375757575e375" },	//	MUModz
	{ "0x00410338",	"236f6f2c6f6f220a0a0a0a0a0a0a0a0a1d1d6ee3e3e323230a2323757575e375" },	//	MUModz2
	{ "0x004107bf",	"04003168ff046cff6c68ff4650fffb9430fffcf66cff0466ff6462ff1000fd95" },	//	z.exe (Knigh ver 2)
	{ "0x004103cb",	"04003168ff046cff6c68ff4650fffb9430fffcf66cff0466ff6462ff1000fd95" },	//	z.exe (Knigh ver 3)
	{ "0x0041008e",	"b6808c094100ff24858009410032db885c2417ebd684c00f8477ffffffe96dff" },	//	autohotkey.exe
	{ "0x00410819",	"000000a8474000c21143738e1143738f954373b9644f73c8644f73e69d4473a2" },	//	hack mu_2.exe
	{ "0x004100b7",	"6a00535657894dfc8bfa8bd88b750833c05568cf01410064ff30648920f6450c" },	//	unlimited_engine
	{ "0x004129fc",	"236f6f2c6f6f220a0a0a0a0a0a0a0a0a1d1d6ee3e3e323230a2323757575e375" },	//	season6.exe
	{ "0x00410000",	"58fcffff8d85a4fdffff52506818714000e87af90100a58d9584fdffff8d4de0" },	//	season6.exe
	{ "0x00410862",	"0000904e40005c6c4273286c427313ea4273585348732c964e730e9f4e73aa9f" },	//	seasont.exe
	{ "0x00410864",	"904e4000746c9472406c947259ea947295e8a172d197a072b3a0a0724fa1a072" },	//	seasont.exe
	{ "0x00410000",	"ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6ecfff9f6" },	//	hack l3rol3ro
	{ "0x00410093",	"6a00535657894dfc8bfa8bd88b750833c05568ab01410064ff30648920f6450c" },	//	xtreme pro hack
	{ "0x00410000",	"4773e198bc67a65e4da169171af3e8768b25f88b4fb468e19a71bd7e695932aa" },	//	maximumss22.exe
	{ "0x00410020",	"66b9080066ba0700e8f7f8ffff5b5dc208008bc0558bec33c95151515153568b" },	//	ghostproxy.exe
	{ "0x00410000",	"828282ff828282ffa9a9a9ffffffffffffffffffffffffff959595ff959595ff" },	//	iF4st4Gily
	{ "0x0041000f",	"0000000000696969fff4f4f4fff2fbfdfff2fbfdff1ebfffff3f86cdff3f86cd" },	//	im4n4h4k
	{ "0x0041001e",	"00005589e583ec10895df08b5d08e81fffffff89d88b108955f48b50048955f8" },	//	cheatenginei386
	{ "0x00416bd3",	"00f032a24fe437cc01f032a24fe437cc01f032a24fe437cc0132686270a46a41" },	//	1.17.exe
	{ "0x0041000f",	"40eb4753576a0d68b4aa450056e8128f030083c40c85c075518b750833ff397e" },	//	xpadder.exe
	{ "0x00410000",	"6b63f15742b30eb30f9535a87185bb8475ce7efa8e87dab95f8aba96a9e03f1f" },	//	ss2.exe
	{ "0x0041002c",	"8079054883c8f040c1e0048885dcfeffff8b8daefeffff81e1ffff000083f91f" },	//	gshack
	{ "0x00411fff",	"00de3c7409de3c7409de3c7409de3c7409de3c74094d5e33044d5e33044d5e33" },	//	hastymuv0.exe
	{ "0x00410000",	"ffa9a9a9ffffffffffffffffffffffffff959595ff959595ffffffffffffffff" },	//	if4st 4gily
	{ "0x0041000b",	"008b4c241089015ec20c00558bec8b451c85c0535657750433ffeb038b781cff" },	//	dkaemultistrikebydude.exe
	{ "0x00404642",	"f0414200e8f2440000a380294200e84644000085c07d086a08e88dfeffff59e8" },	//	DKAEMultiStrikeByDude.exe
	{ "0x00410026",	"008d4c2424e8d022ffff508d4c2438e8d66c03008d442418508d4c242051e887" },	//	expressor.exe
	{ "0x00415078",	"5e1f1f5f620a0609610a081a5e2d12060706580818641f105e19581f1f5f6461" },	//	solidproxy.exe
	{ "0x00410000",	"9af79df7d9fdda6bf97c49fb4e78d7e1fd8eb7e2ef0caeb378daa783bc53ac78" },	//	deathcouncil.exe
	{ "0x00143f30",	"006e0061006c00460069006c0065006e0061006d00650000006e006f0068006f" },	//	nohopess2_ss6.exe
	{ "0x00000400",	"5278dd773243de77276cdd77bb7add77bf9bdf7700000000ccd1f3773286f177" },	//	nohopess2_sss6.exe
	{ "0x00411c7a",	"ffffff00ffffff00ffffff00ffffff00ffffff001666a5751666a5ff1666a5ff" },	//	solidproxy1.8
	{ "0x00410000",	"ffffff00ffffff00ffffff00ffffff00ffffff001666a5751666a5ff1666a5ff" },	//	deathcouncil.exe
	{ "0x00419c3f",	"600c1e000d0000000f000000982932000d000000cdabbadc00000000b8f61200" },	//	solidproxy17
	{ "0x00410ebf",	"00e8ac40002642f47408889204674c00087ee42bb7fd57cd5f275b66f9d7deb6" },	//	solidproxy17
	{ "0x004105bb",	"0066333835366164333634653335222f3e0d0a090909093c616464206e616d65" },	//	solidproxy17
	{ "0x00419c3f",	"121a0e43121a0e1e121a0e1e021a0e7c02210e7d12210e7e12210e7b12230e43" },	//	solidproxy17
	{ "0x00410593",	"9ba8aab89bdb9ec39b0c91c69b0c91c69b0c91c69b0c91c69b0c91c69b0c91c6" },	//	solidproxy1.8
	{ "0x00410004",	"1a32dc1f0b8d60000001131311131a11059c11131b11069c11131c11079c1113" },	//	solidproxy14
	{ "0x0041003e",	"6a046a01ffd16a05e91604000083c304871c245c81c30469ee2de9c9feffff4b" },	//	mgs_v1.0.0.80_pack.exe
	{ "0x00410000",	"450001f15ea0889338ec3cfc496a2a1d494f4588cfe498371a225d16fa22b289" },	//	nohopess2_ss6.exe demo
	{ "0x00411869",	"000000a44b40005c6c4273286c427313ea4273585348732c964e730e9f4e73aa" },	//	seasont.exe
	{ "0x00410000",	"3d47f64dbbbf6f8d5e38d3a23732cbe23f85bafd9a32a057d42dd5ad6f55d63c" },	//	1.07.08.0.exe
	{ "0x00410000",	"4f41b731ec885cdb25c5e7da238c1f311af091e55b4cb6de59f993c1c16730c7" },	//	ulimates6.exe
	{ "0x00410017",	"00551000465669737461556e694c6162656c313400ff1f004656556e69636f64" },	//	automu.dat
	{ "0x0041196f",	"00e82f1474102912742c051374c00c1474900c1474a80c1474d804137428b547" },	//	solidproxy 1.18
	{ "0x00410124",	"8b53108d44243c83ca085056895310ff15c84b43008d4c242ce8e0640100896c" },	//	speedgear.exe 7.1
	{ "0x00410113",	"0a000013191d1528300f2c3b1439501e2e380b293f283037231f1f1f1f1f3534" },	//	cheatparaprocessomu.exe
	{ "0x00410003",	"60867a00ffffffffc9c30000005589e583ec0c895df48975f8897dfc89c3e8da" },	//	GH Engine 32
	{ "0x0041002d",	"eb684889d9e8f999ffff48c70300000000eb574c8d0539ffffff4889f24889d9" },	//	GH Engine 64
	{ "0x00410000",	"ffffff959595ff959595ffffffffffffffffffffffffffffffffffffffffffff" },	//	trainer Dkr1zt1aN
	{ "0x00410001",	"66ffff85c0743b8bd68bc3e88b00000085c0742e8975f4c645f80b8d45f4506a" },	//	tradebug.exe
	{ "0x00410005",	"000000905bf177c561f177986ef177e161f177b26ff1770060f1772d6cf17737" },	//	muautoclicker.exe
	{ "0x00410d18",	"1d1515151715151516121519151115150d0d0d0d0d0d0d0d0d0d151519191915" },	//	theeye.exe
	{ "0x0041000d",	"c1410085c0740aff742408ffd0894424088b4424085ec36a00e896ffffff59c3" },	//	muautoclicker.exe
	{ "0x00410000",	"a0022760322753168c305c02f4d54c3adc4e2a63269f5680e9cf48d9aa49a5b4" },	//	ping spiker lagger.exe
	{ "0x00410000",	"1f7a3ee971e1ffff01d1e961dfffffe94425000029c857bfa7494e1dc1ef07e9" },	//	MGS_v1.0.0.82_Pack.exe
	{ "0x00410024",	"0000000000848484ff848484ff848484ffffffffffffffffffffffffffffffff" },	//	dkr1zt1ann
	{ "0x00410000",	"ffdaf6f0ffd5f7f0ffc6efe7ffcdfff5ffc9fff4ffa8e6d8ff74b5a6ff428778" },	//	sd33p
	{ "0x004100d0",	"008b42308b4ddc51d90488d91c2468ef4e49006a008b550883c20452e8aff4ff" },	//	procexp.exe
	{ "0x00410017",	"0087fdf7d7e9fd120000f7d781ef8151359ce91c2c000081f391a95b82e9ef1d" },	//	MGS_v1.0.0.88_Pack.exe
	{ "0x00410000",	"5694c2e5476980fe49627dfe1b497bfe0c2952fe06145afe030e62fe030c71fe" },	//	ss2.exe
	{ "0x00410017",	"5e5bc38bc0538bd8807b1400741ce80230ffff8b1558984000e8bf3fffff84c0" },	//	injector
	{ "0x00410000",	"558bec83ec18894dec8b450c508d4dfc518b4dece8370300008d55f4528b4dec" },	//	main_cheats.exe
	{ "0x00419c3f",	"0e00000050262c007b16e574cdabbadc00000000000000007b16e5742cf61800" },	//	procexp64.exe
	{ "0x00410000",	"1048894c24084883ec380fb644244885c07502eb5b488b442440488378201072" },	//	procexp.exe
	{ "0x004108a2",	"4100c0b0eaf9d426d011bbbf00aa006c34e4571d2573141425730b1a2573c719" },	//	muautoclicker.exe
	{ "0x0041000c",	"a011a1fed89df3fd1100320388d4bbff1887aaff01400100282cb9ff58c9bbff" },	//	mugenscript.exe
	{ "0x004121dd",	"0000007d1d27114227732276237a2855604277306c226a236b04d4bf28633c25" },	//	hoalong.exe
	{ "0x00410000",	"83ec085355568b742418578bd98b4614f7d0a80174108b4b08518bcee8fac305" },	//	ym2ldp.dll
	{ "0x77090194",	"895c2408e98d9b02008d49008bd40f34c38da424000000008d6424008d542408" },	//	1.hackmuthanlong
	{ "0x770901cd",	"070000e7070000e00101009c210100384101008cb40a0028b50a0051b00a00e5" },	//	2.hackmuthanlong
	{ "0x76f97168",	"565733c033db33f633ffff742420ff742420ff742420ff742420ff742420e808" },	//	Loder.exe
	{ "0x00410f80",	"e8de470000eb2b8b45ec8b088b09894ddc5051e8025c00005959c38b65e88b7d" },	//	Injector.exe
	{ "0x00410f80",	"ff2514510b008bc0ff2510510b008bc0ff250c510b008bc0ff2558510b008bc0" },	//	gay.dll
	{ "0x00410d10",	"1d1515151715151516121519151115150d0d0d0d0d0d0d0d0d0d151519191915" },	//	theeye.exe
	{ "0x00413484",	"85cbc45c02000400ffffffffffff0000ffffffffc899485cd699485cce99485c" },	//	solidproxy.exe
	{ "0x00410cd6",	"4e01c853aefeb8d47dfd01003e005851b2fe682555fe02003d01885c83fe4832" },	//	cheathappens.exe
	{ "0x0041003e",	"000092979d0294989d0695979a0b9091920f9a9b9d197f83862c8a90963b7f85" },	//	deathcouncil.exe
	{ "0x00410000",	"8b4308ff7004ff308d4594e87080ffff8b55948bc6e8fa47ffffeb4c8b43088b" },	//	cheetah_injector_v1.4.exe
	{ "0x0041010b",	"0d508bcde80c9900008b5c24248b6c24184683fe090f8cb3fdffff8b7c241483" },	//	xmousebuttoncontrol.exe
	{ "0x00410007",	"02c3cccccccccccccca170794d005633f63bc6740f50e8493e080083c4048935" },	//	autohotkey.exe
	{ "0x00410000",	"6c24248b742420eb988b06ebba8b36ebcfa1f8224e008b480451b9e0224e00e8" },	//	automousekey.exe
	{ "0x00410014",	"7507b803400080eb15ff751c8b0883ec108bfc8d750ca5a5a550a5ff51285f5e" },	//	keypresser.exe
	{ "0x0041123c",	"f0c3fcb9888b0be81100322f5861feb92054a8e40100760088ba27baa8bae3e2" },	//	autokeyboard.exe
	{ "0x004100b6",	"00008b45fc8b4008d900e86f2cffff50c1f81f3bc2587405e89533ffff8945f8" },	//	trainer lider tux
	{ "0x00410000",	"ffa8e6d8ff74b5a6ff428778ff236a59ff155c4bff1a5f50ff155849ff0e4f40" },	//	trainer s6
	{ "0x00410000",	"fdff3f86cdff3f86cdff3f86cdff3f86cdfff2fbfdfff2fbfdfff2fbfdff7b7b" },	//	ju@c traine
	{ "0x00419c3f",	"111aa1750c003500000040000b000000020000000200000030f61800ab41a175" },	//	procexp.exe
	{ "0x004108ae",	"4863400ceb32eb0948c7c0ffffffffeb27eb254c8b8c24400300004c8b842438" },	//	procexp.exe
	{ "0x004146b0",	"2d1b014500000000d8190182ffffffffffffffffffffffffffffffffffffffff" },	//	procexp64.exe
	{ "0x00410000",	"5e29b6f1beb5f15b59fb1c1f123c6d7fa5cd1dd68f15b450acb1e9d67673c6b7" },	//	deathcouncil.exe
	{ "0x00410000",	"3ac3741584c074dc3ae3740684e474d4eb965e5f8d42ff5bc38d42fe5e5f5bc3" },	//	muautoclicker.exe
	{ "0x00410012",	"ba230000008bc3e852e3ffff8b45c433d2e814abffff85c0753f8d45c050b9e8" },	//	cheatengine.exe
	{ "0x00410000",	"ffc38bc05356578bf98bf28bd885db740b5756538b03ff1085c0740433c0eb02" },	//	anastasiyak.exe
	{ "0x00410000",	"eb04c64613a1885e10381d99734600743533c0668b4608663bc3741250e8183c" },	//	jpnflood.exe
	{ "0x00411cf8",	"10bca1feb8b85dfe010001008821a5fef88417fe1100ad0318bda1feb8b85dfe" },	//	mg dump32.exe
	{ "0x00419c3f",	"00384cc7fca40d000010011040600f2900a84bc7fca40d000010011040480f29" },	//	mg dump32.exe
	{ "0x00418ba2",	"236f6f2c6f6f220a0a0a0a0a0a0a0a0a1d1d6ee3e3e323230a2323757575e375" },	//	hghinfomu.exe
	{ "0x004100c7",	"00005c5d5e5f6061626364656667686900004e4f505152535455565758595a5b" },	//	deathcouncil.exe
	{ "0x004100c3",	"c160ba4df96b38c685f910031054f868c2f561d7e9130000005ecc79ed3cceaf" },	//	nohopeashp.exe
	{ "0x00410cdf",	"002c774000746c9472406c947259ea947295e8a172d197a072b3a0a0724fa1a0" },	//	megahacke v2.0.exe.exe
	{ "0x00410000",	"a0156d938b3ad88483c6f7914d7ad2bbd94b70bf69fb3eedcde6ca549f322676" },	//	injector de dll.exe
	{ "0x00410000",	"85fcfcffffe846feffff8b85fcfcffff66c7000c208b85fcfcffff8b95ecfcff" },	//	mg bypass
	{ "0x00410001",	"1004001004004e1902c6995ca166298b4c178b4c178b4c17a16629a16629d5b2" },	//	vblaster.exe
	{ "0x00410000",	"eb2f8bd66681e2ff0f6683fa14731b566a0068000400005357e856e3ffff668b" },	//	allc.exe
	{ "0x0041005c",	"c745fcffffffff8b45ec8b4df464890d00000000598be55dc3cccccccccccccc" },	//	wtfast.exe
	{ "0x00410000",	"895424108b44241c0bc07d14478b542418f7d8f7da83d8008944241c89542418" },	//	mgs_v1.0.0.95.exe
	{ "0x00411560",	"f86c81fed8115bfe01000100781268ffd8cd4dff11001c01106e81fed8115bfe" },	//	muautoclicker.exe
	{ "0x00410000",	"e979ffffff8d76008b5514890231f6ebb28d76005589e557565383ec3c8d5dc8" },	//	openvpntray.exe
	{ "0x00410000",	"8a084084c975f92bc2c333c0c3cccccc8b442404c3cccccccccccccccccccccc" },	//	fbw.exe
	{ "0x00410000",	"0bfa33f8037dd48db437144301a3c1c60f03f28bf8f7d70bfe33fa037df08dbc" },	//	auto keybot trial.exe
	{ "0x00410000",	"8b40088945d48b45308d4dd08945d08b06518bceff506485c0750e8b068bceff" },	//	macromanager.exe
	{ "0x00410074",	"00eba283658c006a0259eb998ac880e9318975a880f90876a98b4d248b098b89" },	//	macroservicewnd.exe
	{ "0x00419c3f",	"a20036000d00000018000000402521000d000000cdabbadc00000000b8f61200" },	//	xmousebuttoncontrol.exe
	{ "0x00410000",	"e8a8f7ffff8b5d18837b0c007626807d1c000f8529feffffff7524ff7520ff75" },	//	muautoclicker.exe
	{ "0x00410000",	"8d4dace9383affffb8083f4100e94beeffffcccccccccccccccccccccccccccc" },	//	muautoclicker.exe
	{ "0x0041000d",	"00000001619e7761869e77a6709e77cd689e77a0629e774f669e77375a9e77f4" },	//	muautoclicker.exe
	{ "0x00410000",	"43088b0033d252508d459ce8ec82ffff8b559c8bc6e8f249ffffeb688b4308ff" },	//	csemu
	{ "0x00419c3f",	"0f000000102729007b16a375cdabbadc00000000000000007b16a3752cf61800" },	//	solidproxy
	{ "0x00410000",	"d056ffff43eb308a441eff2c5974042c20750e8bc7babc004100e8b556ffffeb" },	//	iptools
	{ "0x00410186",	"7413ff35fcbf5600e8a7d70d0033d28915fcbf56005dc3909090558bec81c46c" },	//	ilovecookiez.exe
	{ "0x00419c3f",	"640608000d00000012000000a8257a000d000000cdabbadc00000000b8f61200" },	//	macrorecorder.exe
	{ "0x00410000",	"2effff8b4de48b514083ca018b45e48950408d4d0851e8d543000083c4048ad8" },	//	wtfast.exe
	{ "0x00410067",	"000d6a3f8d5424395752c644244000e8d518040083c40c8bff85ff7e155768a4" },	//	xmousebuttoncontrol
	{ "0x004124fc",	"c82de7bbb0ac30e305003c0e3869e8bb28f8c6e11100a2008838c8e16879d8e2" },	//	autoclicker.exe
	{ "0x004124fc",	"c82de7bbb0ac30e305003c0e3869e8bb28f8c6e11100a200187db5e16879d8e2" },	//	autoclick by nio_shooter.exe
	{ "0x0041035b",	"00000000007f817f817f817f817f817f817f817f817f817f817f817f817f817f" },	//	nfovwiere
	{ "0x00410000",	"4864008b400450a1f8776400e86b71ffff50e89d8dffff8d95a8fbffff8b06e8" },	//	hvkhack
	{ "0x00410000",	"00595f5e83c410c3cccccccccccccccc568bf18b4604578b7c240c3b4704751c" },	//	automousekey.exe
	{ "0x00410000",	"653a203c25733e206e6f7420666f756e642e0d0a49732070726f736573732072" },	//	winject.exe
	{ "0x00419c3f",	"18000000c02603004f35f775cdabbadc00000000000000004f35f7752cf61800" },	//	xmousebuttoncontrol.exe
	{ "0x00410000",	"08740af6c108c6442422017404885c2422a810740af6c110c644241d01740488" },	//	auto_heal_by_bl.exe
	{ "0x00410000",	"881d6a5e4d006689156c5e4d00881d695e4d00881d685e4d00891d645e4d0088" },	//	autohotkey.exe
	{ "0x00419c3f",	"1800000010273b007b16e776cdabbadc00000000000000007b16e7762cf61800" },	//	xmousebuttoncontrol.exe
	{ "0x00419c3f",	"08000000102756007b16e776cdabbadc00000000000000007b16e7762cf61800" },	//	cmd.exe
	{ "0x00419c3f",	"18000000102738007b16b874cdabbadc00000000000000007b16b8742cf61800" },	//	xmousebuttoncontrol.exe
	{ "0x00410003",	"00807de80074078b45e4836070fd33c05b5f5ec9c38bff558bec83ec10535657" },	//	kernel detective.exe
	{ "0x00419c3f",	"b20603000d0000001a000000382528000d000000cdabbadc00000000b8f61200" },	//	speed hack simplifier.exe
	{ "0x00419c3f",	"00a8299bfef40b00000a360a4020104700a0543dfef40b00000a3b0a40402c48" },	//	autokeyboard.exe
	{ "0x0041002f",	"000083c8ff5f5e5dc36a0c68606e4100e814d5ffffff7508e868d4ffff598365" },	//	ahk2exe.exe
	{ "0x00410000",	"5d14ff75248b4d0c8946108b45288946148b452c8946188b453089461c8b4508" },	//	autome.exe
	{ "0x00410032",	"0056e889f7ffff5984c00f8582000000e88187ffffe87c87ffffe87787ffff89" },	//	muautoclicker.exe
	{ "0x2575cc90",	"68ab030e75e818c9010043b6e564b316a5bc5b96e5102d404715c99314ca7936" },	//	Mu_Macro
	{ "0x56c542c6",	"60be00c041008dbe0050feff5783cdffeb109090909090908a064688074701db" },	//	lord.speed
	{ "0x00410ffb",	"0000000000f767f74af767f74af767f74af767f74af767f74a18a6647f18a664" },	//	hastumunew.exe
	{ "0x0041001b",	"609c000000505268583cb95f555356578d742410ff760c5589e55152648b1d38" },	//	doitagain.exe
	{ "0x00410001",	"598bc6c3ff742404e88c1704008946044083f8105989460873036a105833c96a" },	//	autocombo.exe
	{ "0x00410000",	"9339b86a032413ee3854005c20a9bff64a0b26b9faf85154228c00a271a70a27" },	//	badboy.exe
	{ "0x00410000",	"c4f053568bf28bd88d45f050e8ffe4ffff33c055685200410064ff306489208b" },	//	sndremoteclient.exe
	{ "0x00410000",	"e83b54ffffc3e9c94cffffebf08bc35b595dc214008d4000558bec6a00538b45" },	//	xpadder.exe
	{ "0x00410000",	"688b4308ff7004ff308d4594e85788ffff8b55948bc6e88948ffffeb4c8b4308" },	//	xpadder.exe
	{ "0x00412528",	"1d1515151715151516121519151115150d0d0d0d0d0d0d0d0d0d151519191915" },	//	launcher.exe
	{ "0x00410000",	"000074728bc6e87dbaffff8904248bc5e873baffff8bf88bd58bc6e854bcffff" },	//	am738.exe
	{ "0x00410275",	"32c0c9c208008bff558bec56ff75088bf18d4e04c70690e53f00e86335feff8b" },	//	DJCheat Hack 3.0
	{ "0x00418bd9",	"e1ad04e8e0ad04b086ae042857b304f855af044857b3047866af04a866af0448" },	//	Hack Pro S6
	{ "0x0041559e",	"0000433a5c50726f6772616d4461746100414d4441505053444b524f4f543d43" },	//	Hack Pro S6 2.0
	{ "0x00419c3f",	"006d00280057006900811ae96fdd000080720822002000730068006500650074" },	//	Capotecheat
	{ "0x00419c3f",	"0800000080273f007b16b076cdabbadc00000000000000007b16b0762cf61800" },	//	Hack Pro S6 2.0
	{ "0x00419c3f",	"1800000028285a007b16b275cdabbadc00000000000000007b16b2752cf61800" },	//	xmousebuttoncontrol.exe
	{ "0x00419c3f",	"0b000000282854007b161975cdabbadc00000000000000007b1619752cf61800" },	//	axmrec.exe
	{ "0x00410000",	"0c2bc88a14018810404e75f75ec390908b4c240c85c976268a442408538ad88b" },	//	25000+(+.exe
	{ "0x0041001a",	"3d31ff004336ff004f40ff035c4cff006654ff0a826aff149078ff3aa995ff6e" },	//	b3nnu.exe
	{ "0x0041001e",	"fcffff8945f8eb278b45fce824fbffff8945f8eb1a8d55f88b45fce8b4fbffff" },	//	trainer mu on line season 6 by tuxito.exe
	{ "0x00410019",	"00007408538bcfe8fbedffff807def007408538bcfe85de8ffff8b55e052568b" },	//	xmousebuttoncontrol.exe
	{ "0x00410000",	"c8ff5dc204008bc0558bec83c8ff5dc204008bc0558bec538b5d088b4d108b55" },	//	auto pots.exe
	{ "0x00410883",	"010818204456da9ddfb2d18065ccb33e4457e08c9de1c19e7156b32718000001" },	//	wmphotkeys.exe
	{ "0x004101a3",	"0014000000536574466f726567726f756e6457696e646f7700436d6452656769" },	//	macro recorder.exe
	{ "0x0041003b",	"0b0c013f4022c80000038e49444154484bad96dd4f537718c7fb572c6388484b" },	//	solidproxy.exe
	{ "0x00419c3f",	"1a0332000d0000000f00000078251e000d000000cdabbadc00000000b8f61200" },	//	solidproxy.exe
	{ "0x0041007c",	"83f84075068b1500446d008b45ec83e0037c3d85c07408487416487424eb318b" },	//	Felipe Engine.exe
	{ "0x00410000",	"10eb48488b442428488b08e820d6ffff488b4c2430e8e6d5ffff488b44242848" },	//	cheatenginex86_64.exe
	{ "0x0041003b",	"008d55d4528b45bc8b088b55bc0351048bcae83e4f00008945b88b45b88945b4" },	//	wtfast.exe
	{ "0x00419c3f",	"00706909fd00000000089d084000000000e8889bfe9c08000010e91040000000" },	//	autokeyboard.exe
	{ "0x0041009e",	"6685c07e18b8b059a300e89302000089d8e80cfbffff89d8e895fbffff8b33eb" },	//	smoll_ice tgh.exe
	{ "0x00410000",	"ae381c475f27d15d36bbe7a5f3dfb725c00c1a2bb37ffddad8c4e6ad5db62554" },	//	deathcouncil.exe
	{ "0x00410000",	"5a62dd168c57c0db31213bb677b1002faf0459be6253a0cef0b12c79d63fce93" },	//	ulimates6.exe
	{ "0x00410017",	"80e89316ffff8b108bc88b420cffd083c0108944242056c644243001ff15a443" },	//	macrokeys.exe
	{ "0x00410190",	"d1e62bfe83ff64750c535368d49c4200e83fd4000083ff0a750c535368909c42" },	//	auto.exe
	{ "0x00410003",	"bd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5abd8c5ac193" },	//	xspeednet.exe
	{ "0x00410000",	"58008b4e3451e8a92e05008d461c33d2897e04897e08897e0c897e34897e1066" },	//	qmacro6.exe
	{ "0x00419c3f",	"c20510000d0000000e00000030251d000d000000cdabbadc00000000b8f61200" },	//	doitagain.exe
	{ "0x00410931",	"87eabbb07e9de20100030018fae8bb687d42e811008ebaa8e4e7bbd0bb73e211" },	//	mega macro by francohhh.exe
	{ "0x0041772e",	"4100666f726d4d6163726f000000666f726d4d6163726f456469746f7200546f" },	//	macro.exe
	{ "0x004131f7",	"130a2b41110b11045a110a58195a130c021109110c1858911109110c17589111" },	//	macrorecorder.exe
	{ "0x00410007",	"004d656e7553686f7274437574000000004d656e753737373737373737373737" },	//	macrowhiz.exe
	{ "0x00419c3f",	"17000000582880007b164776cdabbadc00000000000000007b1647762cf61800" },	//	Auto Clicker Typer.exe
	{ "0x00410022",	"c64424201b8bcee8ce441400c706e07d59008b7c242883c9ff33c0c74500c8b3" },	//	autoclicker.exe
	{ "0x00419c3f",	"0f00000058283c007b164776cdabbadc00000000000000007b1647762cf61800" },	//	keypresser.exe
	{ "0x00410000",	"c3cccccccccccccccccccccccccccccc558bec51894dfc8b45fcc64044008b4d" },	//	wtfast.exe
	{ "0x00410738",	"00000000ffffffffffffffffffffffffffffffffffffffffffffc1fffffc007f" },	//	rsclient.exe
	{ "0x004123a0",	"88e8a1fed8ad37fe01000200a84238fe283791fe1000420678e7a1fed8ad37fe" },	//	autotyper.exe
	{ "0x00410ba6",	"00001f000000576f77363444697361626c65576f773634467352656469726563" },	//	hijackthis.exe
	{ "0x00410161",	"10e84a0f00005f5e5b5dc3518b44240c53a3889c01108b4424185556a38c9c01" },	//	hotspot shield.exe
	{ "0x00417da6",	"00009803486f3a0113489f250fd04e696dda18dccf9555963442bfc7781c0764" },	//	macrorecorder.exe
	{ "0x00410001",	"00eb138bc685f674168b4808ff75088b018b36ff502c85f675e95e5dc20400e8" },	//	hotkeyb.exe
	{ "0x00419c3f",	"17000000f8278d007b16fa76cdabbadc00000000000000007b16fa762cf61800" },	//	mouse recorder pro.exe
	{ "0x00419c3f",	"0b000000f82733007b16fa76cdabbadc00000000000000007b16fa762cf61800" },	//	mrplay.exe
	{ "0x00410000",	"fc8bc3e8dc03000084c0743b8d85fcfeffff508d95fcfdffff8b45fc8b00e839" },	//	heal ran.exe
	{ "0x00410017",	"7951a17951a17951a17951a17951a17951a17951a17951a17951a17951a17951" },	//	xspeed.net_demo.exe
	{ "0x00419c3f",	"17000000582803007b160676cdabbadc00000000000000007b1606762cf61800" },	//	mouse recorder pro.exe
	{ "0x00419c3f",	"17000000582850007b160676cdabbadc00000000000000007b1606762cf61800" },	//	mouse recorder pro.exe
	{ "0x00410190",	"d1e62bfe83ff64750c535368d49c4200e8ffd5000083ff0a750c535368909c42" },	//	auto.exe
	{ "0x0041062b",	"121a0e43121a0e1e121a0e1e021a0e7c02210e7d12210e7e12210e7b12230e43" },	//	mouse recorder pro.exe
	{ "0x00410002",	"0056e889f7ffff5984c00f8582000000e88187ffffe87c87ffffe87787ffff89" },	//	muautoclicker.exe
	{ "0x00419c3f",	"0e00000058282b007b163776cdabbadc00000000000000007b1637762cf61800" },	//	tgh m4cr0.exe
	{ "0x00410000",	"57ffd1885dfc8b45083bc374088b10508b4208ffd0c745fcffffffff8b45f03b" },	//	fbw.exe
	{ "0x004104b5",	"18000039531f86d6197348b3507b03228bda7c1ca2b94ab6bd0010230d3ce1bc" },	//	autotyper.exe
	{ "0x00410001",	"000033c08d7e08f3ab5f5ec3909090535556578bd9e8a5ffffff8b6c241c33ff" },	//	qmacro6.exe
	{ "0x00410000",	"feffff03ca3bc873028bc88b74243851e8fb1100008b460485c0740289188346" },	//	openvpntray.exe
	{ "0x00419c3f",	"13000000582824007b16d276cdabbadc00000000000000007b16d2762cf61800" },	//	mgs_v1.0.0.160.exe
	{ "0x00419c3f",	"18000000582824007b161b76cdabbadc00000000000000007b161b762cf61800" },	//	xmousebuttoncontrol.exe
	{ "0x00410075",	"8d55fca120034a00e8ae6cffff8b4dfcb201a17cfa4000e807cdffffe89645ff" },	//	yobbgsm huawei calc.exe
	{ "0x00410000",	"72ff7373ff7474ff7575ff7676ff7777ff7878ff7979ff7a7aff7c7cff7d7dff" },	//	autoclick.exe
	{ "0x00419c3f",	"0b000000f82f7a007b164a75cdabbadc00000000000000007b164a752cf61800" },	//	axmrec.exe V2
	{ "0x00417c50",	"01010101010101010101daffdadadaffdadadaffd9d9d9ffd9d9d9ffd8d8d8ff" },	//	axmrec.exe V3
	{ "0x00419c3f",	"e80f410000000000f00f410000000000f80f4100000000000000000000000000" },	//	axmrec.exe V4
	{ "0x00410000",	"fc6bd2308b45f48d8cc288064300894df8eb098b55f883c2028955f88b45f833" },	//	convertor.exe
	{ "0x0041035b",	"267e01017f808101016e016f707172737475767778797a010161016263646566" },	//	season2ep3.exe
	{ "0x00410000",	"227f242c9185d111b16a00c0f0283628217f242c9185d111b16a00c0f0283628" },	//	macrorecorderlite.exe
	{ "0x00410000",	"c6e8f247ffffe98e0100008b4308d90083c4f4db3c249b8d45b8e8619cffff8b" },	//	lnclick.exe
	{ "0x00410009",	"6848c94600ff15a07246008bf08d45d450ff15ac7246008d55e452c645fc058b" },	//	fbw.exe
	{ "0x00410000",	"ee6ac7ee271999924b75ffb6d23e59b02a1cbe9e78f1e505175f5f72f86ecff4" },	//	ems autopotter v56.exe
	{ "0x00410016",	"8b015e5dffa08c0000008bff558bec568b750c833e01578bf97516ff7614e86f" },	//	autokeyboardpresser.exe
	{ "0x00410000",	"811153e490cd0e8ce3afce7086aa4c69b90b14705b24da89dcce9222a8d4ab46" },	//	speed.exe
	{ "0x00410015",	"00008bf133ff897c2424897c2418e8f1da080033c93bc70f95c13bcf750a6805" },	//	automacro.exe
	{ "0x004360f0",	"fcffff8945f8eb278b45fce824fbffff8945f8eb1a8d55f88b45fce8b4fbffff" },	//	trainer mu on line season 6 by tuxito.exe
	{ "0x00410000",	"ffc9efe9ffd0f2ecffd2f2edffd4f2edffd6f4efffd7f5f0ffdaf5f1ffdbf6f2" },	//	juackteam trainer mu s6.exe
	{ "0x00410000",	"ce8b45fce89f5bffff8b45ec8945f08bf385f6740583ee048b368b7df085ff74" },	//	hvk.exe
	{ "0x00410021",	"030c33010002110304211231054151611322718132061491a1b14223241552c1" },	//	propresser.exe
	{ "0x00410008",	"e827feffff59a3e8474e0055bac0fc4000b83c014100e811feffff59a3ec474e" },	//	clickermann.exe
	{ "0x00410000",	"ff7f8b45f8e8fe59ffff837df8000f8566ffffff33c05a595964891068360041" },	//	PortalxD.exe
	{ "0x004100b0",	"c6842424fc000007e9b10400008d4c2458895c242ce8462fffff51c6842428fc" },	//	gamech1.exe
	{ "0x00410008",	"e8abfeffff59a3d0b74f0055baa8fa4000b860014100e895feffff59a3d4b74f" },	//	clickermann.exe
	{ "0x00410006",	"e869feffff59a3dc674e0055baa8fb4000b84c014100e853feffff59a3e0674e" },	//	clickermann.exe
	{ "0x00410039",	"3840009c384000144556617269616e744e6f74496d706c4572726f728d4000a4" },	//	clickermann.exe
	{ "0x00410030",	"d03840000c394000154556617269616e7454797065436173744572726f728bc0" },	//	clickermann.exe
	{ "0x00410a70",	"5443410058f34000f4f4400058434100e9e9e9e9cccccccccccccccccccccccc" },	//	autoclick blue2 by roki64.exe
	{ "0x00410028",	"0083ec285356578965f4c745f8301340008b75088bc683e0018945fc83e6fe56" },	//	autoclick brather.exe
	{ "0x00410000",	"5ede7bab5fef5b33ec1d0756d5b49b58757f125fdd69f6b3e2dac7c8361f6abd" },	//	autoclick interacter by roki64.exe
	{ "0x00410000",	"56b685e49245035fbeb779892019a68edf6c5e7c802b4c506dde76a92a01afed" },	//	autoclick j_9 by roki64.exe
	{ "0x00411074",	"5b5b5b00cbcbcb00f1f1f100ffffff00ffffff00c6c6c6ff959595ffa5a5a5ff" },	//	autoclick noche 1.0 by roki64.exe
	{ "0x00419c3f",	"880301000d00000014000000182536000d000000cdabbadc00000000b8f61200" },	//	autoclick rosa.exe
	{ "0x0041006a",	"05ff008309ff029715ff06b01fffffff00ffffff04ffffff43ffffff47ffffff" },	//	autoclick roxer by roki64.exe
	{ "0x00410000",	"bfdbacaf343e4844fa044e4cc52768d99035ac5752fd48b8e7db0e3b8e3a5862" },	//	autoclick vaciador.exe
	{ "0x00410009",	"af75ef7eebdd7bdfbaf75ef7eebdd7bdfbaf75ef7eebdd7bdfbaf75ef7eebdd7" },	//	autoclick animation.exe
	{ "0x0041045b",	"0000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffff" },	//	autoclick azuray.exe
	{ "0x00419c3f",	"980315000d0000001b000000182517000d000000cdabbadc00000000b8f61200" },	//	g autoclicker mejorado.exe
	{ "0x00419c3f",	"000001003f030000000000000000010000000000000000000000010000000000" },	//	mutilidades 1.0.exe
	{ "0x00410104",	"0300598943206a245368b42e4f00e8c57e040083c40c5e5b8be55dc3558bec83" },	//	muclick.exe
	{ "0x00410054",	"66b9080066ba0700e8f7f8ffff5b5dc208008bc0558bec33c95151515153568b" },	//	injector mu s6 by handsoner.exe
	{ "0x00410014",	"00000000ffffff00ffffffffffffffffffffffffffffffffffffffffffffffff" },	//	autoclick ninja.exe
	{ "0x00410000",	"4d0ce81d37ffffeb50807df400744a8d85e4feffff50ffd68d85e4feffff680c" },	//	pinnacle.exe
	{ "0x0041037b",	"a6a6a6a6a6a6a6a6a6a641b9bf36335b345d356d6d5d355c5d6d5d6d6d355c6d" },	//	pinnacle.exe
	{ "0x00419c3f",	"03282753fe9c040000010e01407005150540d276fefc0500000a9a0a4048fd35" },	//	autoclick.exe
	{ "0x00419541",	"f47c55041ad3119a730000f81ef32eb53c6bb92807d3119d7b0000f81ef32e9c" },	//	autoclicker by poloro93.exe
	{ "0x0041002c",	"8b442414837c243800745c8b5c241c0bd8833db0384c0000740d558bc6e85204" },	//	combo.exe
	{ "0x00419c3f",	"12000000982f3f007b168476cdabbadc00000000000000007b1684762cf61800" },	//	speed max tgh.exe
	{ "0x0041000b",	"00ffcc31000cd303777bd0ccf040b96d58b88697a1fd7e70d99db64b5b4ca698" },	//	orions.exe
	{ "0x0041014b",	"e804fdffffc3909090558bec83c4d4538bd8b8d0306e00e841b42b0066c745e4" },	//	clicker
	{ "0x00410007",	"50a1188b4e008b00ffd0668b1366b90800e8eff0ffff568d45ec8b55f8e8c749" },	//	caption.exe
	{ "0x004100be",	"6685c07e18b8b069a300e89302000089d8e80cfbffff89d8e895fbffff8b33eb" },	//	cheatenginei386.exe
	{ "0x00410082",	"0074343d0006000074243bc27429e8dfa7ffff8918830effe8c2a7ffff6a165e" },	//	tgh m4cr0.exe
	{ "0x004102ab",	"53565733ff8bf157e8ae97050083c4046894094d006a0157ff153c244b008bd8" },	//	am.exe
	{ "0x00410002",	"a1682a5f0033d28910a1642e5f0033d28910c38d400081c46cffffffc7042494" },	//	hotkeyz.exe
	{ "0x00410966",	"8bc0ff25c81d66008bc06820606600e8aebaffff595a870424c350525168b861" },	//	TheEye_Nebula
	{ "0x00410000",	"2d8bf78d7dbca5a58d45f8a5508d45bc50a5ff15ac53460051d945f8518bf3dd" },	//	hpclicker v2.0.exe
	{ "0x00419c3f",	"0f000000882834007b16c674cdabbadc00000000000000007b16c6742cf61800" },	//	solidproxy.exe
	{ "0x004135ad",	"0000006aecd52bf2a4000a22433a5c55736572735c5461695c446f776e6c6f61" },	//	solidproxy.exe
	{ "0x00410000",	"568b35e0c24d00576a60ffd68b7c240c0fb6c03bf875055fb07e5ec36a31ffd6" },	//	macromaker.exe
	{ "0x004100bf",	"ffff020090c80041000f17494f6c65496e506c6163654163746976654f626a65" },	//	mouserobot.exe
	{ "0x00410024",	"38534000a4c4410048c54100e8c44100124545787465726e616c457863657074" },	//	mouserobotservice.exe
	{ "0x00419c3f",	"0d00000078276f004f35f475cdabbadc00000000000000004f35f4752cf61800" },	//	injector
	{ "0x0041002d",	"00000083ec04891c2489c3e87349ffffe81e49ffffe8c9fdffffa19cfa7a0085" },	//	cheatenginei386.exe
	{ "0x00410000",	"5656565656563d162915111d1d1d1d1d211d1d1b15151b252b1e3e5c5c5c5c5c" },	//	damnpooh.exe
	{ "0x00410011",	"0fb6c885c90f84a80000008d4ddce82c26ffff8b108955d833c0668945e88b4d" },	//	procexp.exe
	{ "0x00410000",	"8bfc09008d45c4508bcfe880fc0900538bcee8bfe7ffff834dfcff8d4dc4e8f4" },	//	qm.exe
	{ "0x00410048",	"5c39400078394000b4394000154556617269616e744f766572666c6f77457272" },	//	proxy.exe
	{ "0x00419c3f",	"0c000000a82626004f35fd75cdabbadc00000000000000004f35fd752cf61800" },	//	smsniff.exe
	{ "0x00412fc3",	"00ffffffffffffffffffffffff542d4100d42c4100542c4100142e4100d42b41" },	//	asd.exe
	{ "0x00410000",	"ffffff8bd833c05a595964891068220041008d45fce8aa84ffffc3e9987affff" },	//	theeye_viridis.exe
	{ "0x0041004b",	"e8504affff8d45f0ba04000000e86f43ffffc3e9213dffffeb905e5b8be55dc3" },	//	extiny.exe
	{ "0x00410147",	"00546f6f6c626172496d6167654c697374000000004d656e75496d6167654c69" },	//	macrolauncher.exe
	{ "0x00414b63",	"00000000007b9e1685157b3449af43278f597b1c3b81498afddf135a4e82c38e" },	//	macrorecorder.exe
	{ "0x004102d3",	"007368656c6c33322e646c6c00120000005368656c6c5f4e6f7469667949636f" },	//	macro recorder.exe
	{ "0x00410bed",	"0000003c3f786d6c2076657273696f6e3d22312e302220656e636f64696e673d" },	//	autoclicker.exe
	{ "0x0041001a",	"000089f389d88b5c24048b7424088b7c240c83c410c383ec10895c2404897424" },	//	chupa.exe
	{ "0x0041201f",	"08549cd462781f41006cd4d4620060a25df862a25d0010855de8ccf46848cff4" },	//	num1.exe
	{ "0x00410000",	"ff558bec5356578b7d0833db8bf13bfb7d05e8ddebfbff8b450c3bc37c038946" },	//	total.exe
	{ "0x00419c3f",	"d40357000d0000000a000000b02559000d000000cdabbadc00000000b8f61200" },	//	m4cr0.exe
	{ "0x0041698a",	"000000e0e1e2e3e4e5e6e7e8e9eaebecedeeeff0f1f2f3f4f5f600f8f9fafbfc" },	//	xmousebuttoncontrol.exe
	{ "0x00405b28",	"e8033d0000e979feffff8bff558bec8b4508a39cc041005dc38bff558bec81ec" },	//	MUAutoClicker.exe
	{ "0x0041002c",	"8b442414837c243800745c8b5c241c0bd8833df0384c0000740d558bc6e85204" },	//	ahk2exe.exe
	{ "0x00410003",	"0083c40c33d26689563eeb298bcf0fb70183f820740583f809750583c102ebee" },	//	autohotkey.exe
	{ "0x00419c3f",	"00808640fe5804000005d70540000000006b0a00000000000008fc0040000000" },	//	au3_spy.exe
	{ "0x00413fe0",	"9d9a264b5cfc0088082c2801c82c2801882d2801482e2801082f2801c82f2801" },	//	autokeyboardpresser.exe
	{ "0x00410037",	"80e8d337ffff8b108bc88b420cffd083c010894424048d4c2404518b4c2420c7" },	//	scheduledtasks.exe
	{ "0x0041005e",	"090083c404893b8b7c242c8b43048b0b893c08834304048b430485ff76668b73" },	//	automacro.exe
	{ "0x00410018",	"8d956cffffff880240423d0001000075f58d856cffffff8d956afeffff526888" },	//	120
	{ "0x00419c3f",	"0000d02cfd00000000050205400000000008ed72fe0000000008070840000000" },	//	356
	{ "0x004100b2",	"5bc9c38bff558bec568b750885f60f8481010000ff7604e88772ffffff7608e8" },	//	muautoclicker.exe
	{ "0x00410000",	"c28d235b3dccf5ae6b80ea038f34f1eee619175d9d7c4e63afe7df62afbd13fa" },	//	main.exe
	{ "0x00410002",	"4dfc8b118b45fc8b088b128b422cffd085c074168b4dfc8b118b45fc8b088b12" },	//	wtfast.exe
	{ "0x00405b2d",	"e979feffff8bff558bec8b4508a39cc041005dc38bff558bec81ec28030000a1" },	//	MUAutoClickerEliteV3.0.5
	{ "0x10001007",	"6a00682c20001068482000106a00ff150020001033c040c20c00c30000000000" },	//	Autoclicker3.5
	{ "0x00419c3f",	"07000000802965007b160d77cdabbadc00000000000000007b160d7738f81800" },	//	sh.exe
	{ "0x00410000",	"5bc38bc0558bec6a005356578bf98bf28bd833c055687b00410064ff30648920" },	//	revised memory.exe
	{ "0x00410012",	"89d829f801420c8b420c3b420476068b420c894204c6442408018a4424088b5c" },	//	teamgh engine.exe
	{ "0x00419c3f",	"0000000000b831ff0000000000509c4100310000006a23ff007123ff008023ff" },	//	nettools5.exe
	{ "0x00419c3f",	"1b000000802925007b164d76cdabbadc00000000000000007b164d762cf61800" },	//	perfect macro recorder.exe
	{ "0x00419c3f",	"1100000080297c007b162275cdabbadc00000000000000007b1622752cf61800" },	//	automousekey.exe
	{ "0x00410021",	"e8de6b00005153568bf1578975f0e86b9101008b4508834e28ff33ff8d4e5889" },	//	gamespeed.exe
	{ "0x00410000",	"5d5f5e5bc38d4000558bec83c4f8e87534ffff8855fb8945fc6824a84600e819" },	//	ratioply
	{ "0x00410000",	"5e33cd5be84f2bffffc9c38bff558bec8b451483f865745f83f845745a83f866" },	//	sh.exe
	{ "0x0a5c3d3c",	"436c69636b6572457865634d757465785f5f00004465746563746564205b2573" },	//	v3.0400.1202.100021003
	{ "0x0d48877b",	"005468616e6b20796f7520666f722074657374696e670000004d55204175746f" },	//	v3.0500.1203.24000
	{ "0x0d474f4a",	"00004d65657420706c617965720020202020202020436f756e74206f66204f62" },	//	v3.0500.1203.24001
	{ "0x0d4870ae",	"6b6f76000000202d204d55204175746f436c69636b6572205625642e25303464" },	//	v3.0501.1204.05000
	{ "0x0a4e3d3c",	"436c69636b6572457865634d757465785f5f00004465746563746564205b2573" },	//	click2
	{ "0x0a4f3d3c",	"436c69636b6572457865634d757465785f5f00004465746563746564205b2573" },	//	click3
	{ "0x0d4870ae",	"436c69636b6572457865634d757465785f5f00004465746563746564205b2573" },	//	click1
	{ "0x004107f9",	"dca3fe381da3ff01001700e87fa2fed8dda4ff1100a003a834a2fed88d9bfe01" },	//	temelkov
	{ "0x0015164c",	"4175746f436c69636b65722e6578650000000000000000000000000000000000" },	//	muautoclicker.exe
	{ "0x092e953b",	"4b616c696e2054656d656c6b6f76200000000000000000000000000000090025" },	//	Kalin Temelkov
	{ "0x08bdc3ef",	"4b616c696e2054656d656c6b6f76200000000000000000000000000000090025" },	//	Kalin Temelkov
	{ "0x07726f15",	"4b616c696e2054656d656c6b6f76202d00000000000000000000000000000000" },	//	Kalin Temelkov
	{ "0x0b88425e",	"4100750074006f0043006c00690063006b006500720020005300650074007400" },	//	Kalin Temelkov2 AutoClick settings
	{ "0x0b88425e",	"4175746f436c69636b65722053657474696e6773004d6167696320476c616469" },	//	Kalin Temelkov
	{ "0x0b57425e",	"4175746f436c69636b65722053657474696e6773004d6167696320476c616469" },	//	Kalin win7
	{ "0x0b8a425e",	"4175746f436c69636b65722053657474696e6773004d6167696320476c616469" },	//	Kalin Temelkov
	{ "0x0b7f600b",	"286329204b616c696e2054656d656c6b6f76000000202d204d55204175746f43" },	//	(c) Kalin Temelkov
	{ "0x001515ec",	"800000002000000040000000000000000000000000002a000000000000001400" },	//	kalin
	{ "0x001515dc",	"0800000002000000040000001000000080000000200000004000000000000000" },	//	kalin
	{ "0x001615c0",	"0100000000000000010000000100000000000000000000010000000800000002" },	//	kalin win7
	{ "0x001615c0",	"0100000000000001000000010000000000000000000000010000000800000002" },	//	kalin win7
	{ "0x001615c0",	"0100000000000000010000000100000000000000000000000100000008000000" },	//	kalin win7
	{ "0x00410000",	"e853fdffff8b85fcfcffff66c7000c208b85fcfcffff8970088b9df0fcffff4b" },	//	Sky Team Launcher
	{ "0x00410000",	"026603f8d1e78bc74e668941fe75eb8b44243085c07c368b74242c8d780133c9" },	//	launcher1
	{ "0x0041000b",	"00730a33db8a9fe8aa4300eb0d8bcfc1e90733db8a99e8ab43008b6c24248b88" },	//	launcher2
	{ "0x00410032",	"2bd657be0f000000668b3c0a83c1026603f8d1e78bc74e668941fe75eb8b4424" },	//	launcher3
	{ "0x1d151515",	"1d1515151715151516121519151115150d0d0d0d0d0d0d0d0d0d151519191915" },	//	TheEye.exe
	{ "0x00410000",	"55b828004100e889f7ffff598d9500ffffff8bc68b8dfcfeffffe8c957ffff5e" },	//	ckeys.exe
	{ "0x00410082",	"00680041000663614e6f6e6506636148696465066361467265650a63614d696e" },	//	loader.exe
	{ "0x00410220",	"d1e62bfe83ff64750c535368e09c4200e88fd7000083ff0a750c5353689c9c42" },	//	auto.exe
	{ "0x00410000",	"4889d9e8e8feffffeb1e4c8d056fffffff4889f24889d9e844feffffeb0a4889" },	//	cheatenginex86_64.exe
	{ "0x00419c3f",	"0e000000402767007b16dc75cdabbadc00000000000000007b16dc7538f81800" },	//	tgh m4cr0.exe
	{ "0x00419c3f",	"0f000000402793007b16dc75cdabbadc00000000000000007b16dc7538f81800" },	//	game skinn.exe
	{ "0x00410000",	"41ffff83c4148bc6e985000000395d0c76dd8b55103bd3881e7e048bc2eb0233" },	//	58.exe
	{ "0x00419c3f",	"f4f51200b0f51200ff8cce75000000000c000000f4f51200d05991000d000000" },	//	XMouseButtonControl
	{ "0x00419c3f",	"11000000802976007b166b75cdabbadc00000000000000007b166b752cf61800" },	//	speedbysanek.exe
	{ "0x00410000",	"8df4feffff8bda8bf033c08985fcfeffff33c08985f8feffff85db740b558bc3" },	//	ckeys.exe
	{ "0x00410053",	"00ffca6690ffc24863c24889c148ffc148c1e1024c8d0d52c07e00428b0c0981" },	//	cheatenginex86_64.exe
	{ "0x00419c3f",	"0900000080293b007b16e376cdabbadc00000000000000007b16e37638f81800" },	//	HACK.exe
	{ "0x00410035",	"000a7a162d9f070dde5d023840ffffff0a3844ffffff053843ffffff023842ff" },	//	ap e ac.exe
	{ "0x0041001c",	"00c9c20800ff7648ff15b4974f00ebe2e83f17ffff84c075d98b470c3b460473" },	//	qm.exe
	{ "0x00410035",	"3c40004c3c4000883c4000144556617269616e744e6f74496d706c4572726f72" },	//	uopilot_v2.17.exe
	{ "0x00419c3f",	"0f00000080295c007b160a77cdabbadc00000000000000007b160a772cf61800" },	//	nakngputa.exe
	{ "0x0041000c",	"000000004883ec4848895c242048897c242848897424304c896424384c896c24" },	//	cheatenginex86_64.exe
	{ "0x00410aca",	"000053484765745370656369616c466f6c6465724c6f636174696f6e00008cfb" },	//	macro recorder.exe
	{ "0x00410000",	"68150041008d45fce8e74effffc3e98548ffffebf08bc784db740fe8a044ffff" },	//	WP506F
	{ "0x00410000",	"8d45f050e813deffff33c055684a00410064ff306489208bd38d45f0e8abf6ff" },	//	agility hack by topgun
	{ "0x00419c3f",	"0d00000048268c004f356275cdabbadc00000000000000004f35627538f81800" },	//	ProcessX
	{ "0x00410000",	"750c578bf98b1e53ff15245842000fb7c08945fc8b4608683d154000b9d82442" },	//	prog test
	{ "0x00419c3f",	"14000000982883007b16d275cdabbadc00000000000000007b16d2752cf61800" },	//	ac_ap_smoll_3.0
	{ "0x004113a7",	"8867611e5b0a02b349aca7af1f695ddeaf4404004b22000088904e8b63389d3d" },	//	max junior and skinn
	{ "0x078503a3",	"3e3e204d554175746f436c69636b65722076332e303430302000c700d4c3ecbf" },	//	Mk10021003
	{ "0x078503a3",	"2d3e204d554175746f436c69636b65722076332e303530302000c700d4c3ecbf" },	//	MK2004
	{ "0x078503a3",	"203e204d554175746f436c69636b65722076332e303530302000c700d4c3ecbf" },	//	MK24001
	{ "0x078503a3",	"203e204d554175746f436c69636b65722076332e303530312000c700d4c3ecbf" },	//	MK3501
	{ "0x00410018",	"8d956cffffff880240423d0001000075f58d856cffffff8d956afeffff526880" },	//	Mini Proxer
	{ "0x00419c3f",	"0d00000048266f004f359d76cdabbadc00000000000000004f359d7638f81800" },	//	rundll32.exe
	{ "0x00419c3f",	"08000000283f3d0001000000ecb3437e24f713003487417ec80305000d000000" },	//	cmd.exe
	{ "0x00412020",	"8b4104648b157c0e00000342483b424c77098942482b41048908c3e9d1a18e6e" },	//	ac_ap_smoll_3.0.exe
	{ "0x00410044",	"52e81a1b19008b5e0483c4043bdf8944241c8be874145355e8af01000083c304" },	//	smc.exe
	{ "0x005ee000",	"8042de77c3bcdf775dbbdf77f3d6e0776ec7df774c7ddd779c9ede77d917e177" },	//	aaaa
	{ "0x005ee001",	"42de77c3bcdf775dbbdf77f3d6e0776ec7df774c7ddd779c9ede77d917e17751" },	//	ssssss
	{ "0x00419c3f",	"08000000283f3d0001000000ecb3437ef4f813003487417e440213000d000000" },	//	cmd.exe
	{ "0x00410000",	"8d956cffffff880240423d0001000075f58d856cffffff8d956afeffff526880" },	//	Mini Proxer
	{ "0x00410019",	"956cffffff880240423d0001000075f58d856cffffff8d956afeffff52688000" },	//	Mini Proxer
	{ "0x00411394",	"70000000433a5c446f63756d656e747320616e642053657474696e67735c4164" },	//	cports.exe
	{ "0x00410024",	"ff750881c10d01000051578d750ce8c2feffff83c41485ff7507668b450c6689" },	//	CPorts
	{ "0x00492bda",	"8d45f050e813deffff33c055684a00410064ff306489208bd38d45f0e8abf6ff" },	//	agility hack by topgun
	{ "0x0041004e",	"8d956afeffff66833a020f94c1880d253a4a0084c9753683c2024875e9eb2e6a" },	//	Mini Proxer
	{ "0x0041008f",	"68dc00410064ff306489208d45fc508d55f88bc6e81873ffff8b45f88b550c8b" },	//	WP506F
	{ "0x00410003",	"50e813deffff33c055684a00410064ff306489208bd38d45f0e8abf6ffff8d45" },	//	Agility Hack By TopGun
	{ "0x00410327",	"e8a85bffffb854c15600e88a50ffffb8906757008b1510984000e81a65ffffb8" },	//	ip_tools.exe
	{ "0x00410000",	"8ddcfeffff8b510452e87622ffff83c4048b85dcfeffff8b0851e865b1000083" },	//	wireshark.exe
	{ "0x0577d8d4",	"3e20436f70797269676874203230313220286329204b616c696e2054656d656c" },	//	MUAutoClicker
	{ "0x078070e8",	"202d204841434b20444554454354454400000000000000000000000000000000" },	//	MUAutoClicker
	{ "0x0040231f",	"8965f4c745f8b01040008b5d0c8d4dbc33ff8b03897ddc5051897dcc897dc889" },	//	misyio
	{ "0x73d65016",	"8b8d980100005f5e33cd5be8c1d0ffff81c59c010000c9c21000b8a1000780eb" },	//	acapa
	{ "0x001e951d",	"0800011281dd1281dd040001011c060002011c1002062001011281e906070312" },	//	acpape
	{ "0x0577d8aa",	"3e204d554175746f436c69636b65722076332e303430302000000000c1360d01" },	//	muclicker12
	{ "0x0041007d",	"00000083ec0c891c2489742404897c240889d38b13c1ea0c89d929d189ce8b56" },	//	sach
	{ "0x0577d8b3",	"203e20436f70797269676874203230313220286329204b616c696e2054656d65" },	//	MuAutoClicker
	{ "0x00406d8f",	"558bec83ec0c680611400064a100000000506489250000000083ec1453565789" },	//	baate
	{ "0x00406d8f",	"8965f4c745f8a81040008b75088bc683e0018945fc83e6fe568975088b0eff51" },	//	baate2
	{ "0x004109c0",	"7e7d0100041111195f19621f1f5f63d261d28120000001111117581311111111" },	//	solidproxy 1.22
	{ "0x00412f7b",	"128100322f13128100582f1a1239006a2f1d02f101792f21123900832f261239" },	//	2 n 1
	{ "0x00410000",	"9b83f063528133d493a59782cb43af47b283fb73d0e3e3c7994a73b95363b743" },	//	season 6 ep3 firefull.exe
	{ "0x00410014",	"7507b808010180eb21ff75288b4008ff75248b08ff7520ff751cff7518ff7514" },	//	keypresser.exe
	{ "0x00410049",	"83c40c0173048b4424208b48f08b43048b7b0883c0043bf8894c24307d4285ff" },	//	automousekey.exe
	{ "0x00410000",	"895f203977247503895f248b4e483bcb74088b01ff5050895e488b4e4c33db43" },	//	mouseclicker.exe
	{ "0x00410000",	"11508b4204ffd0c7442414ffffffff8b460c83e810c70668674a008d480c83ca" },	//	autohotkey.exe
	{ "0x0041101f",	"0000000000e6ffe6ffe6ffe6ffe6ffe6ffe6ffe6ffe6ffe6ffe6ffe6ffe6ffe6" },	//	SolidSTEALTH2
	{ "0x00419c3f",	"0000000000000000f8f5120000000000ccf6fd7f11010000b8f51200b210d16b" },	//	Another Solid Proxy
	{ "0x0041005c",	"83f84075068b1510346d008b45ec83e0037c3d85c07408487416487424eb318b" },	//	doug tgh
	{ "0x00410089",	"eb7a413bc8750403d8eb408b0f03cef641044874244383f8028851057c098a13" },	//	proxy
	{ "0x00410000",	"558bec51568b7510578b7d1c3bf774703b7d28746b8b452085c0740c8b0085c0" },	//	hotspotshield
	{ "0x00419c3f",	"0c000000c0297c007b163975cdabbadc00000000000000007b1639752cf61800" },	//	win all.exe
	{ "0x0041002b",	"568b770c85f67413ff36e8e8e6030056e8e2e6030083670c0059595ec3558bec" },	//	autohp.exe
	{ "0x00410000",	"751b2206ab6e7a76b86d9aa81ca95e2a50014ad014579d2b2046494b10b332c4" },	//	merrychristmas hackfree by frozen.exe
	{ "0x00419c3f",	"12000000c0297c007b163975cdabbadc00000000000000007b1639752cf61800" },	//	super trainer.exe
	{ "0x00419c3f",	"10000000c0297c007b163975cdabbadc00000000000000007b1639752cf61800" },	//	auto potion.exe
	{ "0x00419c3f",	"08000000c0297c007b163975cdabbadc00000000000000007b1639752cf61800" },	//	wge.exe
	{ "0x00419c3f",	"08000000c0296d007b163975cdabbadc00000000000000007b1639752cf61800" },	//	asd.exe
	{ "0x00419c3f",	"08000000c02936007b163975cdabbadc00000000000000007b1639752cf61800" },	//	asd.exe
	{ "0x00408060",	"50726f6a656374735c4176617461722046697850726f4d7553696e6768615c41" },	//	avatars
	{ "0x00446020",	"74696f6e3e4175746f497420333c2f6465736372697074696f6e3e0d0a3c6465" },	//	autoposion
	{ "0x004d71e0",	"1d500842fe87ee6a91eb0c849f81447b20d05a062d08a61bfda351710a2f5b0a" },	//	wpewut
	{ "0x078070eb",	"436f70797269676874203230313220286329204b616c696e2054656d656c6b6f" },	//	muck35
	{ "0x05775140",	"3e20506c656173652073776974636820636861726163746572206e6f772e0000" },	//	muck36
	{ "0x078071f0",	"436f70797269676874203230313220286329204b616c696e2054656d656c6b6f" },	//	muck102103
	{ "0x05775142",	"506c656173652073776974636820636861726163746572206e6f772e00000000" },	//	antifixagi
	{ "0x004ac480",	"5750452d43313436373231312d374338392d343963352d383031412d31443034" },	//	wpewut
	{ "0x078071f0",	"20436f70797269676874203230313220286329204b616c696e2054656d656c6b" },	//	copy
	{ "0x00419c3f",	"0800000018403c0001000000ecb33b7e24f712003487397ea00404000d000000" },	//	cmd.exe
	{ "0x0041005f",	"006a006a018b45f4508b4de42b4dd4518b4dd0e80928ffff508b55f0528b45ec" },	//	DupeItem
	{ "0x00419c3f",	"0e000000182a6e007b166375cdabbadc00000000000000007b1663752cf61800" },	//	PingIpSpeed
	{ "0x00410007",	"00ffffffffe851d200008b44241883c0013b442420894424180f8cf4fcffff8b" },	//	HackTarde
	{ "0x00410001",	"00008d7d04686cf868008971088bcfe84bc3ffff8b5424106aff89420c8b4424" },	//	TardeHack
	{ "0x0041000f",	"00008b7e048bcf2b0eb889888888f7e903d1c1fa068bc2c1e81f03c23bd87612" },	//	SandBox
	{ "0x00419c3f",	"0d000000182a6e007b166375cdabbadc00000000000000007b1663752cf61800" },	//	FasterTobo
	{ "0x00419c3f",	"0003000000020000000000000002000000020000000300000001000000030000" },	//	HackDamage
	{ "0x0041014a",	"2b5424483b5424440f8c530100008b4c244883e10f8bd1f7da83c21085c90f45" },	//	CopyTrade
	{ "0x004150f8",	"5e1f1f5f620a0609610a081a5e2d12060706580818641f105e19581f1f5f6461" },	//	solidproxy
	{ "0x0041001c",	"7e770100041111195f19621f1f5f63d261d28120000001111117581311111111" },	//	solidproxy
	{ "0x00415f5c",	"5e1f1f5f620a0609610a081a5e2d12060706580818641f105e19581f1f5f6461" },	//	solidproxy
	{ "0x00410018",	"1a62081b636108581104061104195f945861590b11051758130511051f2033bf" },	//	solidproxy
	{ "0x00410036",	"1a62081b636108581104061104195f945861590b11051758130511051f2033bf" },	//	solidproxy
	{ "0x00410000",	"c1e6080bf70fb678fec1e6080bf7893183c10483c0044a75d75f5ec3cccccccc" },	//	pssixautocombo.exe
	{ "0x00000000",	"751b2206ab6e7a76b86d9aa81ca95e2a50014ad014579d2b2046494b10b332c4" },	//	merrychristmas
	{ "0x0041008c",	"00000b3840fdffff06383ffdffff033844fdffff0c3848fdffff033847fdffff" },	//	rbt
	{ "0x00410000",	"e442ffff84db7e078bc6e88d46ffff5e5bc38bc08b401050e86f7dffffc38bc0" },	//	bad engine
	{ "0x00410003",	"00000000939393004d4d4d3a747474dc626262ff5d5d5dff5a5a5af93838388c" },	//	apac
	{ "0x0041026e",	"e801cc10e8012011e8017411e801c811e8011c12e8012812e8013812e8015412" },	//	dip.exe
	{ "0x00419c3f",	"5bfddf3140be0003900041009000410038004100380041000010410000f00300" },	//	ap c.exe
	{ "0x00417a9a",	"0000910000006c53797374656d2e5265736f75726365732e5265736f75726365" },	//	blackbox v1.exe
	{ "0x00410fc4",	"f03f737807000680ca04000423ffffffffffffefff23ffffffffffffefff23ff" },	//	solidproxy.exe
	{ "0x00000000",	"0000910000006c53797374656d2e5265736f75726365732e5265736f75726365" },	//	blackbox v1 cheats season 6 epi 3
	{ "0x05775140",	"3e20436f70797269676874203230313220286329204b616c696e2054656d656c" },	//	Allclicker
	{ "0x00410051",	"000052508bc6e8903a0000eb448bd38bc6e891fcffffeb398bd38bc6e8d2fcff" },	//	otnemrot
	{ "0x00413d03",	"0000008efdffffa0fdffffb7fdffffccfdffffddfdffff01feffff0cfeffff14" },	//	gaara.exe
	{ "0x00410000",	"fdfd837f8009a5d9f58231a41e549a91a4244c2deca01ef2690f5e3308056e72" },	//	simplerhack.exe
	{ "0x00419c3f",	"0d00000040291d007b16a876cdabbadc00000000000000007b16a8762cf61800" },	//	autopoterr.exe
	{ "0x00410000",	"ed3f78ffd7f8ef96ffe1e1275f5dfeabbfc67ff49bfdb3ffe70f9e3e3dfe63ff" },	//	ac_ap_smoll_3.0.exe
	{ "0x00000000",	"0000008efdffffa0fdffffb7fdffffccfdffffddfdffff01feffff0cfeffff14" },	//	shine multi
	{ "0x00419c3f",	"aa35dea100000040103790000d00000024000000010000000000000000000000" },	//	steelseriesengine.exe
	{ "0x00417389",	"ffffffffffffff0000ffffffffffffffffffffffffffc0000003ffffffffffff" },	//	rzsynapse.exe
	{ "0x0041086f",	"0c263131313131313131313131313131313131312b180400032b390000321603" },	//	rzsynapse.exe
	{ "0x00410000",	"d67be80d96ef55cd4c96931ddf206bc6e37d374c76ae96a34a02c4a8083654d6" },	//	max junior and skinn.exe
	{ "0x00410000",	"6f1cfe26bffcefff9ffed9dfe168f4effc3d77fff4bff3bffa8beffc2ebff24f" },	//	ac_ap_smoll_3.0.exe
	{ "0x00410007",	"8b068b40048b55f803c685d274658b480c0bca83783800750383c90483e11789" },	//	steelseriesengine3client.exe
	{ "0x00410000",	"0289442404b860b1de0089442408e82db9ffff8b5c24108b542418899a403c00" },	//	steelseriesengine3.exe
	{ "0x00410000",	"f03a490ac63039f41eea40a29ef097133a3a8810285ae697b318a375de699bae" },	//	smarttechnology.exe
	{ "0x00410058",	"c745fc000000008b4d08518d55e8528b4ddce8a1fdffffc645fc018d4de8e885" },	//	lcore.exe
	{ "0x00410017",	"008965f08b7508e85ff210008945ec33c08946088946108946148945fcbffc43" },	//	ryos mk config.exe
	{ "0x00410066",	"75133b4808750e8bc8894d088b40048078390074ed894508528d55fc5257e887" },	//	ryos mk monitor.exe
	{ "0x00410067",	"8b4508f6400466741f837e0400746f837d1c0075696aff56ff7514ff750ce81c" },	//	iskufxmonitor.exe
	{ "0x00410000",	"8bcde8385c06008d4c24348d54242c518d442428528d4c2424508b8424b80000" },	//	iskufxoption.exe
	{ "0x00410000",	"3c8b6c24348b4c24388b7c24308b54245c2bc52bcf505152c68424c000000003" },	//	iskuoption.exe
	{ "0x00410001",	"750857ff152c7742005980fb67750c85f6750857ff152477420059803f2d7508" },	//	iskumonitor.exe
	{ "0x00410009",	"0189742434e8dd1affff8d4c2444c68424500200000089742444e8c81affff8d" },	//	arvocfg.exe
	{ "0x0041000f",	"400080eb18ff75208b0883ec108bfcff750c8d7510a5a5a550a5ff515c5f5e5d" },	//	arvohid.exe
	{ "0x00410021",	"0002f7d81bc023c550ffd7508d4c2424e87fde03008b6c245c8d442458f7d81b" },	//	valooption.exe
	{ "0x00410000",	"ff8bf88d855cfeffff83e83b6a0303f8685411420057e815b8ffff83c4108d85" },	//	valomonitor.exe
	{ "0x004104d1",	"0c02022d5f1e022b5958563f18080081040c2e352f5e675d5c57413d26052424" },	//	valoosd.exe
	{ "0x004100d1",	"ff431c8b005a59e8439a08008d45e0e8bb5423008b55a88902ff4b1c8d45e0ba" },	//	oscareditor.exe
	{ "0x0041000e",	"0050e857feffff83c4105dc39090558bec8b45088b551452668b4d1003c95166" },	//	gxstandard16in1.exe
	{ "0x00410000",	"8b45d8880c18ff45cc837dcc0272e78b55dc648915000000008b45d85b8be55d" },	//	screencapture.exe
	{ "0x00410006",	"66c743101800ba823264008d45e4e84fe02200ff431c8b0033d28955fc8d55fc" },	//	oscareditor.exe
	{ "0x00410000",	"3c006a016a2c8b4d0c5133c08945e88d55e852ff431ce8c1f7ffff83c4108d45" },	//	oscareditor.exe
	{ "0x00410000",	"420c3b420476068b420c8942048b04248b5c24048b7424088b7c240c83c410c3" },	//	frib
	{ "0x0041011b",	"6a00518bc48964242057508d4e04889c24ac040000e8bbaeffff8d4c2424c684" },	//	asdpot
	{ "0x00412776",	"0000910000006c53797374656d2e5265736f75726365732e5265736f75726365" },	//	smilehoney v.0.1 season 6 epi 3.exe
	{ "0x004100c0",	"30584100145a4100c8584100bc5841001254437573746f6d56617269616e7454" },	//	amu speedhack.exe
	{ "0x00419c3f",	"1a000000702626007b16de75cdabbadc00000000000000007b16de7538f81800" },	//	season 6 ep3 firefull.exe
	{ "0x00419c3f",	"000000000000000000000000005c9c4100851d4b619e1d4b6132000000849c41" },	//	season 6ep3firefull.exe
	{ "0x00410002",	"89d829f801420c8b420c3b420476068b420c894204c6442408018a4424088b5c" },	//	enginedllmus6.exe
	{ "0x00419c3f",	"9bd63ff10000004080f094000d00000024000000010000000000000000000000" },	//	season 6 ep3 firefull.exe
	{ "0x00419c3f",	"0038d45100000000003cd05100000000002b00cb762300000023000000000000" },	//	season 6 ep3 firefull.exe
	{ "0x00419c3f",	"1f2fb8cd0000004090d082000d00000024000000010000000000000000000000" },	//	SoulMuonline Season6 EP3
	{ "0x00419c3f",	"a14c701c0000004090f393000d00000024000000010000000000000000000000" },	//	season 6 ep3 firefull.exe
	{ "0x00410000",	"5356488d6424d84889cb4889d64883fe007e0f4889d94889d8488b00ff909000" },	//	cheatenginex86_64.exe
	{ "0x00419c3f",	"413f47a800000040c01a98000d00000024000000010000000000000000000000" },	//	solidproxy.exe
	{ "0x00410000",	"5589e583ec20895de08975e4897de88945ec8955f0894dfc8b45fc83c02489c6" },	//	cheatenginei386.exe
	{ "0x00419c3f",	"0309367ad3340003900041009000410038004100380041000010410000f00300" },	//	solidproxy.exe
	{ "0x00419c3f",	"00000000160c0977ce0608000e000000000000000000000058ad9400f36dd574" },	//	ac_ap_smoll_3.0.exe
	{ "0x00419c3f",	"00000000160c0977ce0414000e0000000000000000000000884ba600f36dd574" },	//	AP AC TGH SmoLL V 3.0
	{ "0x0041279a",	"0000910000006c53797374656d2e5265736f75726365732e5265736f75726365" },	//	Smiley
	{ "0x004ca831",	"8955fc8b45fce8c8a3f3ff33c0556896a84c0064ff306489208b45fce8c2a1f3" },	//	Catastrophe v1.2
	{ "0x00512014",	"b800000000600bc07468e8000000005805530000008038e9751361eb45db2d37" },	//	WildProxy v1.0 Public
	{ "0x00591fc0",	"e80723f0ff8d45ece81f4bffffe87699fcff8b03ba18215900e8e61ef0ff8b03" },	//	Cheat Engine 5.2
	{ "0x005cf440",	"e837a3fcffe88e96f9ff8b03baa8f55c00e82abdecff8b0383c050bac4f55c00" },	//	Chear Engine 5.4
	{ "0x005cf43d",	"8d45ece837a3fcffe88e96f9ff8b03baa8f55c00e82abdecff8b0383c050bac4" },	//	Cheat Engine 5.4
	{ "0x00432360",	"008d55bc52ba0c9c6e008d5decb90100000089d8e8b78cfdff8b55f88b9a5407" },	//	Cheat Engine 6.0
	{ "0x00432320",	"5589e5b810304300a3b0e74300b860304300a3b4e74300b810234300a3b8e743" },	//	Cheat Engine 6.0 Main
	{ "0x006d2080",	"c60520807d0000e8b4ffffffb850f77d00e84af9d3ffc3000000000000000000" },	//	Cheat Engine 6.0 i386
	{ "0x006d2040",	"5589e5b810306d00a350f77d00b850356d00a354f77d00b830206d00a358f77d" },	//	Cheat Engine 6.0 i386 2
	{ "0x0045aa70",	"8945b88b45b885c07526448b45c0488b55e8488b4de0e8b5d8ffff8b55a8488b" },	//	Cheat Engine 6.0 x64
	{ "0x00775bd0",	"c60520509d0000e8b4ffffffb830ce9d00e80ac6c9ffc3000000000000000000" },	//	Cheat Engine 6.1 i386
	{ "0x00434460",	"a1b00f8a008b1db00f8a008b1bff93040400008b45fc8b55fc8d78448d722cfc" },	//	Cheat Engine 6.2
	{ "0x007be660",	"c6052050a30000e8b4ffffffb8f0d1a300e82a45c5ffc3000000000000000000" },	//	Cheat Engine 6.2 i386
	{ "0x00401c29",	"e8501f0000e916feffff558bec81ec28030000a300d44100890dfcd341008915" },	//	Minimize nuevo
	{ "0x00405110",	"558bec83c4ec535633c08945eca1ac604000c60001b8d0504000e869eeffff8b" },	//	Minimizer
	{ "0x0040e04e",	"536861646f7742656173742e415341462d463231343942333135355c4d792044" },	//	Speed Hack Simplifier 1.3
	{ "0x0040e290",	"e82b610000e917feffffcccc6850cb400064ff35000000008b442410896c2410" },	//	MuAutoClickerElite v2.0700.1104.09000E
	{ "0x0048ec3e",	"75193b7b4475148b450c3b4348750c8b45083b434c0f84a40000008bc3e8380b" },	//	Test
	{ "0x0047a078",	"e0c7b2006200000063000000000000000200000000000000fa09000002000000" },	//	Kiasu B
	{ "0x00415c80",	"4881ec88000000c60592e3500000e87dffffff4881c488000000c30000000000" },	//	Cheat Engine 6.0 (x86_64 executable)
	{ "0x00416670",	"4881ec88000000c605a249770000e86dffffff4881c488000000c30000000000" },	//	Cheat Engine 6.1 (x86_64 executable)
	{ "0x00416cf0",	"4883ec28c605158d520000e8a0eeffff4883c428c30000000000000000000000" },	//	Cheat Engine 6.2 (x86_64 executable)
	{ "0x00434d90",	"c6054055430000e8b4ffffffb8f0174400e8ba92fdffc3000000000000000000" },	//	Cheat Engine 6.3 (main executable)
	{ "0x0081e810",	"c6053009820000e8b4ffffffb8403da400e83a46bfffc3000000000000000000" },	//	Cheat Engine 6.3 (i386 executable)
	{ "0x004174c0",	"4883ec28c60525fb550000e8a0eeffff4883c428c30000000000000000000000" },	//	Cheat Engine 6.3 (x86_64 executable)
	{ "0x004066ee",	"4e8b45fc85c074038b40fc01d8e800f3ffff8945f48b55fc85d274038b52fc01" },	//	Cheat Engine 6.3
	{ "0x007782f5",	"e8c695e8ffc9c3000000005589e583ec088945f88955fc8b45fc8b8018050000" },	//	Cheat Engine 6.3 i386
	{ "0x0041008b",	"c7462c64000000eb0233f68d4710508d4e10c744241cffffffffe8161bffff8b" },	//	automousekey.exe
	{ "0x0041001a",	"00e848f4ffff598b078038000f857cf8ffff8b4508ff88f8feffff33c05a5959" },	//	hvk
	{ "0x00419c3f",	"0c00000040274f007b168b75cdabbadc00000000000000007b168b752cf61800" },	//	hotkeyb
	{ "0x00410000",	"47657446696c6541747472696275746573457841000000006b65726e656c3332" },	//	keyedit
	{ "0x00419c3f",	"0e000000b02a27004f359276cdabbadc00000000000000004f3592762cf61800" },	//	procexp64.exe
	{ "0x00419c3f",	"0c000000b02a27004f359276cdabbadc00000000000000004f3592762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"23000000b02a5a004f359276cdabbadc00000000000000004f3592762cf61800" },	//	privado autopot .exe
	{ "0x00410000",	"028bd652ff1594954600e972f5ffff8b0d18e047005351ff15e89546008b5424" },	//	procexp.exe
	{ "0x004100d6",	"448d41408bd0ff158e350800488bcbf7d889442450ff1577310800488d0dd422" },	//	procexp64.exe
	{ "0x00410015",	"008b35d49546006a0dffd6992bc20fbf1524f94900d1f803c26a0e89442438ff" },	//	procexp.exe
	{ "0x0041005f",	"4d8bec41837d0003755b83e9018d45014863fd890db0e30b002bcd4863d84c63" },	//	procexp64.exe
	{ "0x00419c3f",	"0c000000982a57004f359276cdabbadc00000000000000004f3592762cf61800" },	//	procexp.exe
	{ "0x00411fe0",	"c0c0c000e0cac000fffff5dbffffffffffffffffffffffffffffffffc0d5eab6" },	//	procexp64.exe
	{ "0x00419c3f",	"00e90020006400650020004d006f006e00610063006f00000002004d00430000" },	//	procexp.exe
	{ "0x00410000",	"eb23488b0dcfa309004c8d0d78f1fdff488d1539ea07004533c048896c2420ff" },	//	procexp.exe
	{ "0x00419c3f",	"90009741000000000080da41000000000020e641000000000000000000000000" },	//	procexp64.exe
	{ "0x00419c3f",	"0c000000982a27004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"000000310034003600380038000000500072006f0074006f0063006f006c0020" },	//	procexp64.exe
	{ "0x00410000",	"9cfbffff8d4c2424c644244801e80efbffff8b96f0010000528d4c2428e87ed7" },	//	procexp.exe
	{ "0x00410013",	"4889bc24880000004883c6184c8d35dafffeff660f7f74246066666690486346" },	//	procexp64.exe
	{ "0x00410013",	"00000000007d7d7ddddcdcdcfee6921dffe6b15affeec982ffecb558ffce8627" },	//	procexp64.exe
	{ "0x00419c3f",	"0c000000982a4d004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"00e10700009ee80000a5e8000020be0000ace80000de9000002dbe000031be00" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000982a7f004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000982a2a004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000982a51004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000982a88004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000982a35004f356c75cdabbadc00000000000000004f356c752cf61800" },	//	procexp.exe
	{ "0x00410070",	"8d4ddcc745fcffffffffe8011dd9ff8b4df464890d00000000595f5e8be55dc2" },	//	ripe.exe
	{ "0x00419c3f",	"007400650064000000310034003300300030000000430061006c006c00730020" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a4d004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a26004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a77004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a2b004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00410e6f",	"006324bc66abd30008ac17f976c4004100414c4c555345525350524f46494c45" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a3d004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"001c014200091801840bc8e0039026b00164302000000004000a982036181410" },	//	procexp.exe
	{ "0x0041000f",	"68041000005546ffd33bf07cd4e960fdffff57e8e971fdff83c404e952fdffff" },	//	procexp.exe
	{ "0x0041798f",	"20c868a14100a161f95b7ec6a385060184e908012800e121f94b7ec6c3f2b7fc" },	//	procexp.exe
	{ "0x00418826",	"00009c799760df99324cbf88a32958c6421af20a5e63cbdb00089c799760df99" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a28004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"007000610063006b0065007400730020007300630068006500640075006c0065" },	//	procexp.exe
	{ "0x004100e8",	"4533c94533c0488d153b940800488d0dd4da0800e837e4ffff33c9e8b0ccffff" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a80004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a03004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a7f004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a84004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"001970222c8f39000000020007900000420ba8b0181121400154202000000004" },	//	procexp.exe
	{ "0x00419c3f",	"201d0000000100e007f0034100000000201d0000000100c0f7ff8d0100000000" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a59004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x0041883d",	"0000000904e4043c617373656d626c7920786d6c6e733d2275726e3a73636865" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a50004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a33004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a6e004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a39004f354476cdabbadc00000000000000004f3544762cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a3d004f350277cdabbadc00000000000000004f3502772cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"264dd507d4b80003900039009000390038003900380039000040410000c00700" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a2d004f350277cdabbadc00000000000000004f3502772cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"10ce9b477fc5040390000300e88f030038003e0038003e000090410000700c00" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a30004f350277cdabbadc00000000000000004f3502772cf61800" },	//	procexp.exe
	{ "0x00419c3f",	"0c000000b02a54004f350277cdabbadc00000000000000004f3502772cf61800" },	//	procexp.exe
	{ "0x00410002",	"208d04808b44821085c0740e8b5510528b550c5251ffd083c40c5dc3cccc558b" },	//	verifier.exe
	{ "0x00419c3f",	"09000000b02a28004f353175cdabbadc00000000000000004f3531752cf61800" },	//	RiPE.exe
	{ "0x00410001",	"ff1588444d008945ec837dec00750432c0eb6c8b4dec516a00ff157c444d0089" },	//	procexp.exe
	{ "0x00419c3f",	"0a000000402774007b163f75cdabbadc00000000000000007b163f7538f81800" },	//	2 n 1.exe
	{ "0x00419c3f",	"12000000402787007b163c75cdabbadc00000000000000007b163c752cf61800" },	//	macrorecorder.exe
	{ "0x00419c3f",	"12000000b02a64004f35ad75cdabbadc00000000000000004f35ad752cf61800" },	//	privatetunnel.exe
	{ "0x00412021",	"000059588d401affe0ff742408526870a7ea66555356578d742410ff760c5589" },	//	zmu helper.exe
	{ "0x00410000",	"0075098bc3e832feffffeb1985c97f158bc1b9ffff000099f7f985d275078bc3" },	//	cheat engine.exe
	{ "0x004100ca",	"00000d294812041021d3072f48ff2760a0ff81a3e5ffc9e4feffbbffffffbdff" },	//	zmu helper1.exe
	{ "0x00419c3f",	"0a000000c82787007b169075cdabbadc00000000000000007b1690752cf61800" },	//	ac_ap.exe
	{ "0x00410868",	"48122d0211034812b50319034812b50321034812b50329034812ee0b39034812" },	//	newestspeed
	{ "0x00410000",	"048b1b43538b45fc0345f850576a006a008bc6e8b4b8ffff8bc80fb7450833d2" },	//	heal
	{ "0x00410000",	"64496e666f006765745f4973537461746963006765745f4669656c6454797065" },	//	season3hack
	{ "0x00413d9e",	"fa14de062903c11283033103c11283033903c11283034103c11283034903c112" },	//	shseason3
	{ "0x00410015",	"0000a99e9800443c320d97918a72bcb6b1dfd2cfccffd2d2d0ffd1d2d0ffd0d1" },	//	shbmd
	{ "0x00419c3f",	"000000000000000000000100904044e1f846d6e203000f000000000000000000" },	//	autopotionsoft
	{ "0x00410000",	"d6bd4b474a61d220b4359f6930a356ef7ad566d9f7f19a20bef0bc8b7e3b7ce2" },	//	apac2
	{ "0x00410000",	"9ebf43401c65b7fafb9ffae86a516c2f7fd4fe34a608af6c4f983de811b08c76" },	//	wow
	{ "0x0041002f",	"9401000000433a5c55736572735c73616e73756e675c417070446174615c4c6f" },	//	tzher
	{ "0x00419c3f",	"00610063006f00000002004d00430000000f004600720065006e006300680020" },	//	ac_ap2.exe
	{ "0x00419c3f",	"00009c4100000000000000000000000000000000000000000000000000000000" },	//	zmu702.exe
	{ "0x00410404",	"000000ff00ffffffffffffffffffffffffffffffffffffffff00ffffffffffff" },	//	DarkTerroa.exe
	{ "0x00410026",	"0626061f2058061f20584a061f28584a5854061f20584a061f1c584a3297061f" },	//	d4rkt3err0.exe
	{ "0x004134de",	"2316150c210456161c0c21047516830131048c16250c3904a3162a0c2104b216" },	//	wew
	{ "0x0041000d",	"8b43048947048b45fcff888800000089d8e89dfbffffeb0989df8b5b0485db75" },	//	str?r tgh.exe
	{ "0x00410168",	"061f1858064a1f18635406064a061f18584a1f18625954064a207b7a7d00409a" },	//	darkterro zhypermu v1.3.exe
	{ "0x00410000",	"d35605ee8f33ae54a1244335528677485d6ecca0e31a39d5abfedf7d58c49ba8" },	//	zeus project by darkterro.exe
	{ "0x00419c3f",	"ff01000e0000000000f09366c300f9ffff10708dc300f9ffff0f003200000000" },	//	Hasty Variant
	{ "0x00419c3f",	"111a9f750c004100000040001d000000070000000700000030f61800ab419f75" },	//	cheat ghost mu ex702 + s8.exe
	{ "0x004110b7",	"00002a0a388fffffff02388effffff0b389bffffff07389affffff022ba3062b" },	//	cheat ghost mu ex702 + s8.exe
	{ "0x0041000c",	"8b15c8104000e84d58ffffb8a8665000e82f4dffffb8a4665000e8254dffffb8" },	//	fafaeg
	{ "0x00419c3f",	"60003d000000000060003d0000000000003041000000000000d0030000000000" },	//	dq3rqaf
	{ "0x00419c3f",	"22000000902833007b165376cdabbadc00000000000000007b1653762cf61800" },	//	fg4wgws
	{ "0x00419c3f",	"1e000000c0282f007b162e75cdabbadc00000000000000007b162e752cf61800" },	//	tg4wgt
	{ "0x00410000",	"22722b8e4366bdcba9ae1381e5bbb5c001b6853849695422f68ba6375f04e29e" },	//	bhgetrgrws
	{ "0x00410639",	"0000ffff00ff0000ffffffffffffffffffffffffffffffffffffffffffffffff" },	//	hnbtew12
	{ "0x004101e1",	"3f5f7f11d50a3aacd4c53961000088b77a5c561934e089aed4c53964000088b7" },	//	hbte67le
	{ "0x00410000",	"ffffe805fbffff8d85f4fcffff508d4701508b85e8fcffff50e806edffffe8e9" },	//	ZhyperMUx.exe
	{ "0x00410046",	"3b500c7c0333c0c3b001c38d4000e8d7ffffffc38bc05356578bf98bf28bd88b" },	//	pingzapper.exe
	{ "0x00401000",	"a163704300c1e002a367704300575133c0bf4cc74300b9ac0744003bcf76052b" },	//	Cheat O Matic
	{ "0x00401380",	"68dc1c4000e8f0ffffff000000000000300000004000000000000000007fbc7c" },	//	ByAnonGr
	{ "0x006d28c0",	"c60520107e0000e8b4ffffffb830877e00e83af1d3ffc3000000000000000000" },	//	Fire Final
	{ "0x00401308",	"68c8e04300e8f0ffffff000000000000300000004000000000000000a5b52430" },	//	Project1
	{ "0x00451e40",	"a4cffcff8b40403b45fc7d0643ff4de475e18d47013bd875218b45f08b55ec8d" },	//	SpeedHack
	{ "0x00457d88",	"e836810000e978feffffcccccccccccccccccccccccccccc518d4c24082bc883" },	//	Process Explorer
	{ "0x00401b2c",	"68c0354000e8eeffffff000000000000300000004000000000000000a3f5ed6e" },	//	FireCheats By PiR@DeX FREE Vers
	{ "0x00458378",	"e837810000e978feffffcccccccccccccccccccccccccccc518d4c24082bc883" },	//	Process Explorer
	{ "0x00458da5",	"e8d6bb0000e978feffffcc518d4c24082bc883e10f03c11bc90bc159e9bac7ff" },	//	Process Explorer
	{ "0x004430eb",	"e84bb50000e916feffff565733f6bfe0004b00833cf52c30490001751e8d04f5" },	//	Process Explorer
	{ "0x00409844",	"83eefc11db72edb80100000001db75078b1e83eefc11db11c001db73ef75098b" },	//	a
	{ "0x004047b0",	"5bc38bc084d27f01c350528b10ff52e85a58c390803d18405e000176116a006a" },	//	Desconhecido
	{ "0x0040e110",	"00209163f60f6b1641166f06a16606a46ff60a6600001066005c4e9ef666b166" },	//	Desconhecido
	{ "0x00415014",	"b800000000600bc07468e8000000005805530000008038e9751361eb45db2d37" },	//	Desconhecido
	{ "0x004035e0",	"a07f4600e86be2030083c40c85c07519a1a47f4600803800750fa1ac7f460080" },	//	Desconhecido
	{ "0x00404300",	"66c745f000008d45f0e896ffffff33c055683f43400064ff306489208d55f08b" },	//	Desconhecido
	{ "0x004d5014",	"46696c6500014f70656e50726f63657373000143726561746546696c654d6170" },	//	Desconhecido
	{ "0x00400e20",	"17dde4317512bea98d0ab902fe5f205264a6807de72e75058845e7eb03230cdb" },	//	Desconhecido
	{ "0x00405680",	"0000894424048b550c891c2489542408e85bfcffff83c4145b5dc39090909090" },	//	Desconhecido
	{ "0x00405330",	"02008b44245833ff85c07e3b8b44245c33f685c07e288b442428565750ffd53b" },	//	Desconhecido
	{ "0x0067ce00",	"60be00705b008dbe00a0e4ff5783cdffeb109090909090908a064688074701db" },	//	Aspeeder
	{ "0x00403132",	"81ec7c01000053555633f65789742418bd40924000c644241020ff1530704000" },	//	Aspeeder
	{ "0x00100100",	"6a286870204000e87402000033ff57ff15009019016681384d5a751f8b483c03" },	//	Auto Life Pro
	{ "0x00401254",	"6814d24100e8f0ffffff0000000000003000000040000000000000008ef02423" },	//	Hack All Mu Minimized
	{ "0x0040f832",	"8d85f0fdffff508d45f850e88ae1ffff8d45f850e889e1ffff8bd885db750583" },	//	HideToolz
	{ "0x00419c3f",	"0c00330064f61200089790770c00330000004000200000000000000000000000" },	//	cheat skydark(argenmu)
	{ "0x00410030",	"8b00ffd08bd081ea05000280740a81eafbfffd7f752beb358d45f48b55f8e8d5" },	//	zhypermubew.exe
	{ "0x00410000",	"db7c6b4333ff8db500fdffff8bc68985dcfcffff8b85dcfcffff83c004508d47" },	//	bypas2015.exe
	{ "0x00419c3f",	"0c00480164f61200089766770c00480100004000120000000400000004000000" },	//	muaway ap + ac.exe (argenmu)
	{ "0x00419c3f",	"0c00480164f61200089766770c004801000040001d0000000700000007000000" },	//	zeus project (argenmu)
	{ "0x004100eb",	"5c7ccaaa5cd42daa5cacd8215d8c60ab5c34f6a95c44eda95c908de45d000000" },	//	cheat4fun.exe (argenmu)
	{ "0x00410000",	"fcffff0fb7008985f0fcffff8b9df0fcffff4b85db7c6b4333ff8db500fdffff" },	//	gear.exe (argenmu)
	{ "0x004ca8aa",	"c785c4b5ffff642b6b00c785c8b5ffff00000000c785ccb5ffff00000000c785" },	//	msh 6.1
	{ "0x008a8132",	"416c69676e6d656e74070d74614c6566744a757374696679084d696e57696474" },	//	a.bat
	{ "0x00998bbe",	"416c69676e6d656e740708746143656e74657207416e63686f72730b05616b54" },	//	b.bat
	*/
	
}; 
//-----------------------------------------------------------------------------------------------------------*/