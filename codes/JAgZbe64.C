! Exports for c:\mx\mm_mlib.m module: mm_mlib

importmodule mm_mlib =
	[0..255]u32 allocupper
	i32 alloccode
	i32 allocbytes
	i32 fdebug
	i32 rfsize
	i32 memtotal
	i64 smallmemtotal
	i32 smallmemobjs
	i32 maxmemtotal
	function pcm_alloc(i32 n)ref void
	proc pcm_free(ref void p,i32 n)
	proc pcm_freeac(ref void p,i32 alloc)
	proc pcm_copymem4(ref void p,ref void q,i32 n)
	proc pcm_clearmem(ref void p,i32 n)
	proc pcm_init()
	function pcm_getac(i32 size)i32
	function pcm_newblock(i32 itemsize)ref u32
	function pcm_round(i32 n)i32
	function pcm_array(i32 n)i32
	proc pcm_printfreelist(i32 size,ref u32 p)
	proc pcm_diags(ichar caption)
	function pcm_allocz(i32 n)ref void
	function pcm_copyheapstring(ichar s)ichar
	function allocmem(i32 n)ref void
	function reallocmem(ref void p,i32 n)ref void
	proc abortprogram(ichar s)
	function getfilesize(ref void handlex)i32
	proc readrandom(ref void handlex,ref u8 mem,i32 offset,i32 size)
	proc writerandom(ref void handlex,ref u8 mem,i32 offset,i32 size)
	function readfile(ichar filename)ref u8
	function writefile(ichar filename,ref u8 data,i32 size)i32
	function checkfile(ichar file)i32
	proc readlinen(ref void handlex,ichar buffer,i32 size)
	proc iconvlcn(ichar s,i32 n)
	proc iconvucn(ichar s,i32 n)
	proc convlcstring(ichar s)
	proc convucstring(ichar s)
	function changeext(ichar s,ichar newext)ichar
	function extractext(ichar s,?i32 period=0)ichar
	function extractpath(ichar s)ichar
	function extractfile(ichar s)ichar
	function extractbasefile(ichar s)ichar
	function addext(ichar s,ichar newext)ichar
	function alloctable(i32 n,i32 size)ref void
	function zalloctable(i32 n,i32 size)ref void
	proc checkfreelists(ichar s)
	function pcm_alloc32()ref void
	proc pcm_free32(ref void p)
	proc outbyte(ref void f,i32 x)
	proc outword16(ref void f,u32 x)
	proc outword(ref void f,u32 x)
	proc outdword(ref void f,u64 x)
	function myeof(ref void f)i32
	function pcm_smallallocz(i32 n)ref void
	function pcm_fastalloc(i32 n)ref void
end importmodule
!--------------------------------------------------------------------------------