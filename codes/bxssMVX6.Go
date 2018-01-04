package main

import (
	"unsafe"
	"fmt"
	"github.com/AllenDang/w32"
	"syscall"
	"golang.org/x/sys/windows"
	//"github.com/cwchiu/go-winapi"
	"time"
)
//import "unicode/utf16"

const(
	LWA_COLORKEY = 0x00001
	LWA_ALPHA    = 0x00002
)

func main() {


	box := make(chan bool)
	go WinMain(box)




	time.Sleep(100 * time.Millisecond)

	









	//fmt.Println( w32.SetWindowPos(myHWND,myHWND,30,30,30,30, w32.SWP_NOACTIVATE))


	//var lStyle = w32.GetWindowLong(myHWND, w32.GWL_STYLE);
	//lStyle &= ^(w32.WS_CAPTION | w32.WS_THICKFRAME | w32.WS_MINIMIZE | w32.WS_MAXIMIZE | w32.WS_SYSMENU);
	//w32.SetWindowLong(myHWND, w32.GWL_STYLE, uint32(lStyle));

	//fmt.Println("setting bg color:", w32.SetBkColor(w32.GetDC(myHWND),0x3))
	
	myWindowPtr,_ := windows.UTF16PtrFromString("Fonk")
	myHWND := w32.FindWindowW(syscall.StringToUTF16Ptr("WNDclass"),myWindowPtr)

	time.Sleep(100 * time.Millisecond)
	
	fmt.Println("myHWND", myHWND)
	w32.SetWindowPos(myHWND, w32.HWND_TOPMOST, 0, 0, 0, 0, w32.SWP_NOMOVE | w32.SWP_NOSIZE)

	SetLayeredWindowAttributes(myHWND,0xff0000,9, LWA_ALPHA | LWA_COLORKEY)
	<- box

}

type RGB struct {
	byRed   byte
	byGreen byte
	byBlue  byte
}

func WinMain(kill chan bool) int {

	hInstance := w32.GetModuleHandle("")



	lpszClassName := syscall.StringToUTF16Ptr("WNDclass")



	var wcex w32.WNDCLASSEX
	wcex.Size        = uint32(unsafe.Sizeof(wcex))
	wcex.Style         = w32.CS_HREDRAW | w32.CS_VREDRAW
	wcex.WndProc   = syscall.NewCallback(WndProc)
	wcex.ClsExtra    = 0
	wcex.WndExtra    = 0
	wcex.Instance     = hInstance
	wcex.Icon         = w32.LoadIcon(hInstance, MakeIntResource(w32.IDI_APPLICATION))
	wcex.Cursor       = w32.LoadCursor(0, MakeIntResource(w32.IDC_ARROW))
	wcex.Background = w32.COLOR_WINDOW + 0
	wcex.MenuName  = nil
	wcex.ClassName = lpszClassName
	wcex.IconSm       = w32.LoadIcon(hInstance, MakeIntResource(w32.IDI_APPLICATION))
	w32.RegisterClassEx(&wcex)




	hWnd := w32.CreateWindowEx(
		0, lpszClassName, syscall.StringToUTF16Ptr("Fonk"),
		 w32.WS_VISIBLE | w32.WS_EX_LAYERED,
		w32.CW_USEDEFAULT, w32.CW_USEDEFAULT, 400, 400, 0, 0, hInstance, nil)

	w32.ShowWindow(hWnd, w32.SW_SHOWDEFAULT)
	w32.UpdateWindow(hWnd)

	//fmt.Printf("value of area : %d\n", 0)

	var msg w32.MSG
	for {
		if w32.GetMessage(&msg, 0, 0, 0) == 0 {
			break
		}
		w32.TranslateMessage(&msg)
		w32.DispatchMessage(&msg)
	}
	return int(msg.WParam)
}

func MakeIntResource(id uint16) (*uint16) {
	return (*uint16)(unsafe.Pointer(uintptr(id)))
}

func WndProc(hWnd w32.HWND, msg uint32, wParam, lParam uintptr) (uintptr) {
	switch msg {
	case w32.WM_DESTROY:
		w32.PostQuitMessage(0)
	default:
		return w32.DefWindowProc(hWnd, msg, wParam, lParam)
	}
	return 0
}

func SetLayeredWindowAttributes(hwnd w32.HWND, cr w32.COLORREF, alpha byte, flags uint32) bool {
	moduser32                      := syscall.NewLazyDLL("user32.dll")
	procSetLayeredWindowAttributes := moduser32.NewProc("SetLayeredWindowAttributes")
	r0, r1, r2 := syscall.Syscall6(procSetLayeredWindowAttributes.Addr(), 4, uintptr(hwnd), uintptr(cr), uintptr(alpha), uintptr(flags), 0, 0)
	fmt.Println("SetLayered r0:", r0)
	fmt.Println("SetLayered  r1:", r1)
	fmt.Println("SetLayered  r2:", r2)
	fmt.Println("Last Error:", w32.GetLastError())
	return r0 != 0
}