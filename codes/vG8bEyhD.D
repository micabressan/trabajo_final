/**
 * time dmd -c static_array.d -m32
 * 
 * real   0m8.136s
 * user   0m8.100s
 * sys    0m0.010s
 */
private enum uint[256] array = [0]; 
private size_t state = 0;
private void foobar()
{
    uint i = 4;
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ array[state >> 24] ^ array[(state >> 16)] ^ array[(state >> 8)] ^ array[ state];
    state = array[i++] ^ (array[state >> 24] << 24) ^ (array[(state >> 16)] << 16) ^ (array[(state >> 8)] << 8) ^ array[ state];
    state = array[i++] ^ (array[state >> 24] << 24) ^ (array[(state >> 16)] << 16) ^ (array[(state >> 8)] << 8) ^ array[ state];
    state = array[i++] ^ (array[state >> 24] << 24) ^ (array[(state >> 16)] << 16) ^ (array[(state >> 8)] << 8) ^ array[ state];
    state = array[  i] ^ (array[state >> 24] << 24) ^ (array[(state >> 16)] << 16) ^ (array[(state >> 8)] << 8) ^ array[ state];
}

/+
execve("/usr/bin/dmd", ["dmd", "-c", "static_array.d", "-m32"], [/* 44 vars */]) = 0
[ Process PID=6969 runs in 32 bit mode. ]
brk(0)                                  = 0x81ee000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff77de000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=128640, ...}) = 0
mmap2(NULL, 128640, PROT_READ, MAP_PRIVATE, 3, 0) = 0xfffffffff77be000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib32/libstdc++.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340B\4\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=930044, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff77bd000
mmap2(NULL, 959532, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfffffffff76d2000
mmap2(0xf77b1000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xde) = 0xfffffffff77b1000
mmap2(0xf77b6000, 25644, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfffffffff77b6000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib32/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20M\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=116994, ...}) = 0
mmap2(NULL, 98824, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfffffffff76b9000
mmap2(0xf76ce000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xfffffffff76ce000
mmap2(0xf76d0000, 4616, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfffffffff76d0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib32/libm.so.6", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2604\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=149392, ...}) = 0
mmap2(NULL, 151680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfffffffff7693000
mmap2(0xf76b7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x23) = 0xfffffffff76b7000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib32/libgcc_s.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\37\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=108040, ...}) = 0
mmap2(NULL, 111148, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfffffffff7677000
mmap2(0xf7691000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19) = 0xfffffffff7691000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib32/libc.so.6", O_RDONLY)      = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220o\1\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1417796, ...}) = 0
mmap2(NULL, 1427976, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xfffffffff751a000
mprotect(0xf7670000, 4096, PROT_NONE)   = 0
mmap2(0xf7671000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x156) = 0xfffffffff7671000
mmap2(0xf7674000, 10760, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7674000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7519000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7518000
set_thread_area(0xffef6f58)             = 0
mprotect(0xf7671000, 8192, PROT_READ)   = 0
mprotect(0xf7691000, 4096, PROT_READ)   = 0
mprotect(0xf76b7000, 4096, PROT_READ)   = 0
mprotect(0xf76ce000, 4096, PROT_READ)   = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff7517000
mprotect(0xf77b1000, 16384, PROT_READ)  = 0
mprotect(0x81b6000, 4096, PROT_READ)    = 0
mprotect(0xf77fc000, 4096, PROT_READ)   = 0
munmap(0xf77be000, 128640)              = 0
set_tid_address(0xf7518738)             = 6969
set_robust_list(0xf7518740, 0xc)        = 0
futex(0xffef7050, FUTEX_WAKE_PRIVATE, 1) = 0
futex(0xffef7050, FUTEX_WAIT_BITSET_PRIVATE|FUTEX_CLOCK_REALTIME, 1, NULL, ffef7060) = -1 EAGAIN (Resource temporarily unavailable)
rt_sigaction(SIGRTMIN, {0xf76bd6e0, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xf76bd760, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=-4286578688, rlim_max=-617855217605541872}) = 0
uname({sys="Linux", node="chrono", ...}) = 0
brk(0)                                  = 0x81ee000
brk(0x820f000)                          = 0x820f000
stat64("dmd.conf", 0xffef6e0c)          = -1 ENOENT (No such file or directory)
stat64("/root/dmd.conf", 0xffef6e0c)    = -1 ENOENT (No such file or directory)
stat64("dmd.conf", 0xffef6e0c)          = -1 ENOENT (No such file or directory)
getcwd("/usr/src/test9", 4096)          = 15
lstat64("/usr/src/test9/dmd", 0xffef6e8c) = -1 ENOENT (No such file or directory)
stat64("/usr/local/sbin/dmd", 0xffef6dcc) = -1 ENOENT (No such file or directory)
stat64("/usr/local/bin/dmd", 0xffef6dcc) = -1 ENOENT (No such file or directory)
stat64("/usr/sbin/dmd", 0xffef6dcc)     = -1 ENOENT (No such file or directory)
stat64("/usr/bin/dmd", {st_mode=S_IFREG|0755, st_size=1970352, ...}) = 0
stat64("/usr/bin/dmd.conf", 0xffef6e0c) = -1 ENOENT (No such file or directory)
open("/etc/dmd.conf", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=181, ...}) = 0
read(3, "[Environment]\nDFLAGS= -I/usr/inc"..., 181) = 181
close(3)                                = 0
mmap2(NULL, 8392704, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS|MAP_STACK, -1, 0) = 0xfffffffff6d16000
mprotect(0xf6d16000, 4096, PROT_NONE)   = 0
clone(child_stack=0xf7516484, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|CLONE_SYSVSEM|CLONE_SETTLS|CLONE_PARENT_SETTID|CLONE_CHILD_CLEARTID, parent_tidptr=0xf7516bd8, tls=0xf7516bd8, child_tidptr=0xffef6ee0) = 6970
unlink("static_array.o")                = 0
futex(0x81f486c, FUTEX_WAIT_PRIVATE, 1, NULL) = 0
futex(0x81f4850, FUTEX_WAIT_PRIVATE, 2, NULL) = 0
futex(0x81f4850, FUTEX_WAKE_PRIVATE, 1) = 0
stat64("object.di", 0xffef6dac)         = -1 ENOENT (No such file or directory)
stat64("object.d", 0xffef6dac)          = -1 ENOENT (No such file or directory)
stat64("/usr/include/d/dmd/phobos/object.di", 0xffef6dac) = -1 ENOENT (No such file or directory)
stat64("/usr/include/d/dmd/phobos/object.d", 0xffef6dac) = -1 ENOENT (No such file or directory)
stat64("/usr/include/d/dmd/tango/object.di", 0xffef6dac) = -1 ENOENT (No such file or directory)
stat64("/usr/include/d/dmd/tango/object.d", 0xffef6dac) = -1 ENOENT (No such file or directory)
stat64("/usr/include/d/dmd/druntime/import/object.di", {st_mode=S_IFREG|0644, st_size=11757, ...}) = 0
open("/usr/include/d/dmd/druntime/import/object.di", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11757, ...}) = 0
read(3, "/**\n * Contains all implicitly d"..., 11757) = 11757
close(3)                                = 0
brk(0x8230000)                          = 0x8230000
time(NULL)                              = 1317133959
open("/etc/localtime", O_RDONLY)        = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=2309, ...}) = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=2309, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff77dd000
read(3, "TZif2\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\10\0\0\0\10\0\0\0\0"..., 4096) = 2309
_llseek(3, -28, [2281], SEEK_CUR)       = 0
read(3, "\nCET-1CEST,M3.5.0,M10.5.0/3\n", 4096) = 28
close(3)                                = 0
munmap(0xf77dd000, 4096)                = 0
brk(0x8251000)                          = 0x8251000
brk(0x8280000)                          = 0x8280000
brk(0x82a1000)                          = 0x82a1000
brk(0x82c3000)                          = 0x82c3000
brk(0x82e5000)                          = 0x82e5000
brk(0x8307000)                          = 0x8307000
brk(0x8329000)                          = 0x8329000
brk(0x834a000)                          = 0x834a000
brk(0x836c000)                          = 0x836c000
brk(0x838e000)                          = 0x838e000
brk(0x83b0000)                          = 0x83b0000
brk(0x83d2000)                          = 0x83d2000
brk(0x83f4000)                          = 0x83f4000
brk(0x8416000)                          = 0x8416000
brk(0x8438000)                          = 0x8438000
brk(0x845a000)                          = 0x845a000
brk(0x847c000)                          = 0x847c000
brk(0x849e000)                          = 0x849e000
brk(0x84c0000)                          = 0x84c0000
brk(0x84e2000)                          = 0x84e2000
brk(0x8503000)                          = 0x8503000
brk(0x8525000)                          = 0x8525000
brk(0x8547000)                          = 0x8547000
brk(0x8569000)                          = 0x8569000
brk(0x858b000)                          = 0x858b000
brk(0x85ad000)                          = 0x85ad000
brk(0x85cf000)                          = 0x85cf000
brk(0x85f1000)                          = 0x85f1000
brk(0x8613000)                          = 0x8613000
brk(0x8635000)                          = 0x8635000
brk(0x8657000)                          = 0x8657000
brk(0x8679000)                          = 0x8679000
brk(0x869b000)                          = 0x869b000
brk(0x86bd000)                          = 0x86bd000
brk(0x86de000)                          = 0x86de000
brk(0x8700000)                          = 0x8700000
brk(0x8722000)                          = 0x8722000
brk(0x8744000)                          = 0x8744000
brk(0x8766000)                          = 0x8766000
brk(0x8788000)                          = 0x8788000
brk(0x87aa000)                          = 0x87aa000
brk(0x87cc000)                          = 0x87cc000
brk(0x87ee000)                          = 0x87ee000
brk(0x8810000)                          = 0x8810000
brk(0x8832000)                          = 0x8832000
brk(0x8854000)                          = 0x8854000
brk(0x8893000)                          = 0x8893000
brk(0x8883000)                          = 0x8883000
mmap2(NULL, 524288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xfffffffff6c96000
brk(0x8863000)                          = 0x8863000
brk(0x8886000)                          = 0x8886000
brk(0x88a8000)                          = 0x88a8000
brk(0x88ca000)                          = 0x88ca000
brk(0x88ec000)                          = 0x88ec000
brk(0x890e000)                          = 0x890e000
brk(0x8940000)                          = 0x8940000
brk(0x892f000)                          = 0x892f000
brk(0x895d000)                          = 0x895d000
open("static_array.o", O_WRONLY|O_CREAT|O_TRUNC, 0644) = 3
write(3, "\177ELF\1\1\1\3\0\0\0\0\0\0\0\0\1\0\3\0\1\0\0\0\0\0\0\0\0\0\0\0"..., 94704) = 94704
close(3)                                = 0
exit_group(0)
+/