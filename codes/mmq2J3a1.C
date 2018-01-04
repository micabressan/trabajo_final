BOOL FillStruct(OPENFILENAME& ofn,
	const wchar_t* wcHeader,
	const HWND& hWnd,
	wchar_t* szFile)
{
	if (wcHeader == nullptr || wcHeader[0] == '\0' || szFile == nullptr)
		return FALSE;

	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hWnd;
	ofn.lpstrFile = szFile;
	ofn.nMaxFile = MAX_PATH;
	ofn.nFilterIndex = 3;
	ofn.lpstrTitle = wcHeader;
	ofn.lpstrDefExt = L"";
	ofn.lpstrFilter = L"Text files(*.txt)\0*.txt\0All files(*.*)\0*.*";
	ofn.Flags = OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_PATHMUSTEXIST | OFN_OVERWRITEPROMPT;
	return TRUE;
}