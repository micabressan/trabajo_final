LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
	OPENFILENAME ofn = { 0 };
	wchar_t czFile[MAX_PATH] = { 0 };
	ClearStruct(ofn);			//Optimization
    switch (message)
    {
    case WM_COMMAND:
        {
            int wmId = LOWORD(wParam);
            // Разобрать выбор в меню:
            switch (wmId)
            {
			//Opening
			case IDM_OPEN_NORMAL:
				//Open normal
				if (FillStruct(ofn, L"Open normal file", hWnd, czFile))
				{
					if (GetOpenFileName(&ofn))
					{
						DWORD iSize = FileSize(czFile);
						if (iSize < 0)
						{
							MessageBox(hWnd, L"Error opening file", L"Error", MB_ICONERROR);
							break;
						}
						if (iSize >= WARN_SIZE_TB && iSize <= MAX_SIZE_TB)
							MessageBox(hWnd, L"Size of file more 10 000 chars. In LEET translate can be not all text!", L"Warning", MB_ICONWARNING);
						if (iSize > MAX_SIZE_TB)
						{
							MessageBox(hWnd, L"File is too big. Size must be less or equals 30 000 chars!", L"Error!", MB_ICONERROR);
							break;
						}
						FILE* f = nullptr;
						_wfopen_s(&f, czFile, L"rb");
						char* cBuf = (char*)calloc(iSize, sizeof(char));
						fread(cBuf, sizeof(char), iSize, f);
						SetWindowTextA(::tbNormal, cBuf);
						fclose(f);
						memset(czFile, 0, MAX_PATH);
					}
					ClearStruct(ofn);
				}
				break;
			case IDM_OPEN_LEET:
				//Open LEET
				if (FillStruct(ofn, L"Open LEET file", hWnd, czFile))
				{
						if (GetOpenFileName(&ofn))
						{
							ClearStruct(ofn);
							DWORD iSize = FileSize(czFile);
							if (iSize < 0)
							{
								MessageBox(hWnd, L"Error opening file", L"Error", MB_ICONERROR);
								break;
							}
							if (iSize > MAX_SIZE_TB)
							{
								MessageBox(hWnd, L"File is too big. Size must be less or equals 30 000 chars!", L"Error!", MB_ICONERROR);
								break;
							}
							FILE* f = nullptr;
							_wfopen_s(&f, czFile, L"rb");
							char* cBuf = (char*)calloc(iSize, sizeof(char));
							fread(cBuf, sizeof(char), iSize, f);
							SetWindowTextA(::tbLEET, cBuf);
							fclose(f);
							memset(czFile, 0, MAX_PATH);
						}

					ClearStruct(ofn);
				}
				break;

			//Save
			case IDM_SAVE_NORMAL:
				//Save normal
				if (FillStruct(ofn, L"Save normal text to file", hWnd, czFile))
				{
					if (GetSaveFileName(&ofn))
					{
						FILE* f = nullptr;
						if (_wfopen_s(&f, czFile, L"wb"))
						{
							MessageBox(hWnd, L"Error creating file! File not create!", L"Error", MB_ICONERROR);
							break;
						}
						char cBuf[MAX_SIZE_TB] = { 0 };
						int iNumber = GetWindowTextA(::tbNormal, cBuf, MAX_SIZE_TB);
						if (iNumber < 0)
						{
							MessageBox(hWnd, L"Error of read text from field with text!", L"Error", MB_ICONERROR);
							fclose(f);
							break;
						}
						fwrite(cBuf, sizeof(char), iNumber, f);
						fclose(f);
					}

					ClearStruct(ofn);
				}
				break;
			case IDM_SAVE_LEET:
				//Save LEET
				if (FillStruct(ofn, L"Save LEET text to file", hWnd, czFile))
				{
					if (GetSaveFileName(&ofn))
					{
						FILE* f = nullptr;
						if (_wfopen_s(&f, czFile, L"wb"))
						{
							MessageBox(hWnd, L"Error creating file! File not create!", L"Error", MB_ICONERROR);
							break;
						}
						char cBuf[MAX_SIZE_TB] = { 0 };
						int iNumber = GetWindowTextA(::tbLEET, cBuf, MAX_SIZE_TB);
						if (iNumber < 0)
						{
							MessageBox(hWnd, L"Error of read text from field with text!", L"Error", MB_ICONERROR);
							fclose(f);
							break;
						}
						fwrite(cBuf, sizeof(char), iNumber, f);
						fclose(f);
					}

					ClearStruct(ofn);
				}
				break;

			//Pressing Buttons
			case BTN_CONVERT_TO_LEET:
				//Convert text to LEET
				break;
			case BTN_CONVERT_TO_NORMAL:
				//Convert LEET to normal text
				break;

			//Another
            case IDM_ABOUT:
                DialogBox(hInst, MAKEINTRESOURCE(IDD_ABOUTBOX), hWnd, About);
                break;
            case IDM_EXIT:
                DestroyWindow(hWnd);
                break;
            default:
                return DefWindowProc(hWnd, message, wParam, lParam);
            }
        }
        break;
    case WM_PAINT:
        {
            PAINTSTRUCT ps;
            HDC hdc = BeginPaint(hWnd, &ps);
            // TODO: Добавьте сюда любой код прорисовки, использующий HDC...
            EndPaint(hWnd, &ps);
        }
        break;
    case WM_DESTROY:
        PostQuitMessage(0);
        break;
    default:
        return DefWindowProc(hWnd, message, wParam, lParam);
    }
    return 0;
}