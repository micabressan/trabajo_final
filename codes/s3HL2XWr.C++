#define SCREEN_WIDTH 700
#define SCREEN_HEIGHT 500
#define SNOW_SIZE 1
#define TIMER_ID 1
#define MAP_X 100
#define MAP_Y 80
 
#include <windows.h>
#include <deque>
#include <time.h>
 
TCHAR className[] = TEXT("śnieg iksde");
TCHAR appName[] = TEXT("JAZDA Z KURWAMI HYHY !!!!!!!");
 
HWND hwnd;
MSG msg;
 
const COLORREF backgroundColor = RGB(0, 0, 128);
const COLORREF snowColor = RGB(255, 255, 255);
 
RECT clientRect;
 
struct Snow {
    UINT x, y;
    UINT yVel;
    bool floor;
    UINT time;
};
 
std::deque<Snow> snow;
 
void initNewElement() {
    Snow s;
    s.x = rand() % MAP_X;
    s.y = 0;
    s.yVel = 1;
    s.time = 0;
    s.floor = 0;
 
    snow.push_back(s);
}
 
LRESULT CALLBACK WndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam){
    static PAINTSTRUCT ps;
    static HBRUSH whiteBrush;
    static HPEN whitePen;
 
    switch (msg){
    case WM_CREATE: {
        SetTimer(hwnd, 100, TIMER_ID, 0);
        GetClientRect(hwnd, &clientRect);
 
        srand(time(NULL));
 
        whiteBrush = CreateSolidBrush(snowColor);
        whitePen = CreatePen(PS_SOLID, 0, snowColor);
    }break;
 
    case WM_SIZE:
        GetClientRect(hwnd, &clientRect);
        break;
 
    case WM_TIMER: {
        initNewElement();
 
        if (snow.size() > 0)
            for (std::deque<Snow>::iterator it = snow.begin(); it != snow.end(); ++it)
                if (it->y < MAP_Y - SNOW_SIZE)
                    it->y += it->yVel;
                else
                    it->floor = true;
 
        int x = -1;
 
        if (snow.size() > 0)
            for (std::deque<Snow>::iterator it = snow.begin(); it != snow.end(); ++it)
                if (it->floor) {
                    it->time++;
 
                    if (it->time >= 10) {
                        x = it->x;
                        snow.erase(it);
                        break;
                    }
                }
 
        if (snow.size() > 0)
            for (std::deque<Snow>::iterator it = snow.begin(); it != snow.end(); ++it)
                for (std::deque<Snow>::iterator ite = snow.begin(); ite != snow.end(); ++ite)
                    if (it != ite && it->y + 1 == ite->y && it->x == ite->x)
                        it->yVel = 0;
 
        if (snow.size() > 0 && x > -1)
            for (std::deque<Snow>::iterator it = snow.begin(); it != snow.end(); ++it)
                if (it->x == x)
                    it->yVel = 1;
 
        InvalidateRect(hwnd, NULL, 1);
    }break;
 
    case WM_PAINT: {
        HDC hdc = BeginPaint(hwnd, &ps);
 
        SetMapMode(hdc, MM_ANISOTROPIC);
        SetViewportExtEx(hdc, clientRect.right, clientRect.bottom, NULL);
        SetViewportOrgEx(hdc, 0, 0, NULL);
        SetWindowExtEx(hdc, MAP_X, MAP_Y, NULL);
        SetWindowOrgEx(hdc, 0, 0, NULL);
 
        SelectObject(hdc, whiteBrush);
        SelectObject(hdc, whitePen);
 
        if (snow.size() > 0)
            for (std::deque<Snow>::iterator it = snow.begin(); it != snow.end(); ++it)
                Rectangle(hdc, it->x, it->y, it->x + SNOW_SIZE, it->y + SNOW_SIZE);
 
        EndPaint(hwnd, &ps);
    }break;
 
    case WM_LBUTTONDOWN:
        snow.clear();
    break;
 
    case WM_CLOSE:
        DestroyWindow(hwnd);
        break;
 
    case WM_DESTROY: {
        DeleteObject(whiteBrush);
        DeleteObject(whitePen);
 
        KillTimer(hwnd, TIMER_ID);
        PostQuitMessage(0);
        }break;
 
    default:
        return DefWindowProc(hwnd, msg, wParam, lParam);
    }
 
    return 0;
}
 
INT WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow){
    WNDCLASSEX wc;
    wc.cbSize = sizeof(WNDCLASSEX);
    wc.style = 0;
    wc.cbClsExtra = 0;
    wc.cbWndExtra = 0;
    wc.hInstance = hInstance;
    wc.hbrBackground = (HBRUSH)CreateSolidBrush(backgroundColor);
    wc.lpfnWndProc = WndProc;
    wc.lpszClassName = className;
    wc.lpszMenuName = NULL;
    wc.hIcon = LoadIcon(NULL, IDI_APPLICATION);
    wc.hIconSm = LoadIcon(NULL, IDI_APPLICATION);
    wc.hCursor = LoadCursor(NULL, IDC_ARROW);
 
    if (RegisterClassEx(&wc) == 0) {
        MessageBox(NULL, TEXT("Some problem with RegisterClassEx"), className, MB_OK);
        return 1;
    }
 
    hwnd = CreateWindowEx(WS_EX_APPWINDOW | WS_EX_CLIENTEDGE, className, appName, WS_OVERLAPPEDWINDOW, CW_USEDEFAULT, CW_USEDEFAULT, SCREEN_WIDTH, SCREEN_HEIGHT, 0, 0, hInstance, 0);
    if (hwnd == NULL) {
        MessageBox(NULL, TEXT("Some problem with CreateWindowEx"), className, MB_OK);
        return 1;
    }
 
    ShowWindow(hwnd, nCmdShow);
    UpdateWindow(hwnd);
 
    while (GetMessage(&msg, NULL, 0, 0) > 0){
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
 
    UnregisterClass(className, hInstance);
 
    return msg.wParam;
}