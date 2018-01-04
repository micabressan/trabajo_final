/**
 * dmd -m32 test10.d /usr/include/d/dmd/druntime/lib/libdruntime.a
 *
 * test10.o: In function `_Dmain':
 * test10.d:(.text._Dmain+0xc): undefined reference to `_D4core3sys5posix6dirent6dirent6__initZ'
 * collect2: ld returned 1 exit status
 * --- errorlevel 1
 */

private import core.sys.posix.dirent;

int main()
{
    dirent entry;
    return 0;
}