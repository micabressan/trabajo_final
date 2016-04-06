bool inicjalizacja_cmd()
//Initialize cmd
{
	int error{};
	error = _setmode(_fileno(stdin), _O_U16TEXT);
	if(error==-1)return false;
	error = _setmode(_fileno(stdout), _O_U16TEXT);
	if(error==-1)return false;
	//Set cmd output codepage to UTF16
	SetConsoleOutputCP(10000U);
	//Set cmd input codepage to UTF16
	SetConsoleCP(10000U);
	//You have to change font to TrueType in order to be able to type and display UTF16
	CONSOLE_FONT_INFOEX cfi;
    cfi.cbSize = sizeof cfi;
    cfi.nFont = 0;
    cfi.dwFontSize.X = 0;
    cfi.dwFontSize.Y = 16;
    cfi.FontFamily = FF_DONTCARE;
    cfi.FontWeight = FW_NORMAL;
    wcscpy_s(cfi.FaceName, L"Consolas");
    SetCurrentConsoleFontEx(GetStdHandle(STD_OUTPUT_HANDLE), FALSE, &cfi);
	return true;
}

//Output to file is done by using imbune to wfstream to convert utf16 to utf8 on the fly during saving anything to it
file_descriptor.imbue(std::locale(std::locale::classic(), new std::codecvt_utf8<wchar_t>));