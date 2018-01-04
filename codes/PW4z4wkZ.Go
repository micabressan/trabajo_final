func TestCloseUdp(t *testing.T) {
    iroutines := runtime.Goroutines()

    conn, _ := net.ListenPacket("udp", ":6666")

    go func() {
        var buf [100]byte
        conn.ReadFrom(buf[:])
    }()

    conn.Close()
    time.Sleep(1e10)

    if nroutines := runtime.Goroutines(); iroutines != nroutines {
        msg := fmt.Sprint("Leaked threads: was ", nroutines, " but expected ", iroutines)
        panic(msg)
    }           
}


====


panic: Leaked threads: was 4 but expected 2

goroutine 41 [running]:
main.TestCloseUdp()
	~/net_test.go:199 +0x291
testing.tRunner(0x187175d0, 0x82797cc, 0x0)
	$GOROOT/src/pkg/testing/testing.go:156 +0x39
created by testing.RunTests
	$GOROOT/src/pkg/testing/testing.go:200 +0x511

goroutine 1 [chan receive]:
testing.RunTests(0x8048c00, 0x82796e8, 0x26)
	$GOROOT/src/pkg/testing/testing.go:201 +0x53f
testing.Main(0x8048c00, 0x82796e8, 0x26, 0x26, 0x8282f30, ...)
	$GOROOT/src/pkg/testing/testing.go:168 +0x49
main.main()
	~/_test/_testmain.go:32 +0x43

goroutine 43 [runnable]:
syscall.socketcall()
	$GOROOR/src/pkg/syscall/asm_linux_386.s:125 +0x38
syscall.recvfrom(0x3, 0x187e4070, 0x64, 0x64, 0x0, ...)
	$GOROOT/src/pkg/syscall/syscall_linux_386.go:159 +0x9d
syscall.Recvfrom(0x3, 0x187e4070, 0x64, 0x64, 0x0, ...)
	$GOROOT/src/pkg/syscall/syscall_linux.go:481 +0x9f
net.(*netFD).ReadFrom(0x1870e680, 0x187e4070, 0x64, 0x64, 0xffffffff, ...)
	$GOROOT/src/pkg/net/fd.go:415 +0x219
net.(*UDPConn).ReadFromUDP(0x187780e0, 0x187e4070, 0x64, 0x64, 0x0, ...)
	$GOROOT/src/pkg/net/udpsock_posix.go:156 +0xb9
net.(*UDPConn).ReadFrom(0x187780e0, 0x187e4070, 0x64, 0x64, 0x0, ...)
	$GOROOT/src/pkg/net/udpsock_posix.go:171 +0x84
main._func_015(0x187780a0, 0x187789e8)
	~/net_test.go:191 +0xbd
created by main.TestCloseUdp
	~/net_test.go:192 +0x91

goroutine 42 [syscall]:
syscall.Syscall6()
	$GOROOT/src/pkg/syscall/asm_linux_386.s:46 +0x27
syscall.EpollWait(0x6, 0x18792148, 0xa, 0xa, 0xffffffff, ...)
	$GOROOT/src/pkg/syscall/zsyscall_linux_386.go:200 +0x9d
net.(*pollster).WaitFD(0x18792140, 0x1874ef30, 0x0, 0x0, 0x0, ...)
	$GOROOT/src/pkg/net/fd_linux.go:141 +0x1b6
net.(*pollServer).Run(0x1874ef30, 0x18700dc0)
	$GOROOT/src/pkg/net/fd.go:228 +0x146
created by net.newPollServer
	$GOROOT/src/pkg/net/newpollserver.go:36 +0x464
gb error: [_test/_testmain]: exit status 2