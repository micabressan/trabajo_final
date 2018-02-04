int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	


        WNDCLASSEX WndClass;
        HWND hwnd;
        MSG Msg;

        WndClass.cbSize        = sizeof(WNDCLASSEX);
        WndClass.style         = NULL;
        WndClass.lpfnWndProc   = WndProc;
        WndClass.cbClsExtra    = 0;
        WndClass.cbWndExtra    = 0;
        WndClass.hInstance     = hInstance;
        WndClass.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
        WndClass.hCursor       = LoadCursor(NULL, IDC_ARROW);
        WndClass.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);
        WndClass.lpszMenuName  = NULL;
        WndClass.lpszClassName = g_szClassName;
        WndClass.hIconSm       = LoadIcon(NULL, IDI_APPLICATION);

        if(!RegisterClassEx(&WndClass)) {
                MessageBox(0, "Window Registration Failed!", "Error!", MB_ICONSTOP | MB_OK);
                return 0;
        }

        hwnd = CreateWindowEx(
			WS_EX_CLIENTEDGE,
			g_szClassName,
			"easy",
			WS_OVERLAPPEDWINDOW,
			10, 10, 240, 120,
			NULL, NULL, hInstance, NULL);

        if(hwnd == NULL) {
                MessageBox(0, "Window Creation Failed!", "Error!", MB_ICONSTOP | MB_OK);
                return 0;
        }

        ShowWindow(hwnd, SW_HIDE);
        UpdateWindow(hwnd);



        while(GetMessage(&Msg, NULL, 0, 0)) {
                TranslateMessage(&Msg);
                DispatchMessage(&Msg);
        }
        return Msg.wParam;
}