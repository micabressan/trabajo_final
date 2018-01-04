// kio.d
module kio;

enum VGA_START = cast(ubyte *) 0xB8000;

struct vga_buffer {
    align (1):
    ubyte* address = VGA_START;
    ushort pointer = 0;
}

shared vga_buffer vb;

enum : ubyte
{
    BLACK, BLUE, GREEN, CYAN,
    RED, MAGENTA, BROWN, GRAY,
    DARK_GRAY, BRIGHT_BLUE, BRIGHT_GREEN, BRIGHT_CYAN,
    BRIGHT_RED, BRIGHT_MAGENTA, YELLOW, WHITE
}

enum COLOR = (BLACK << 4) | GRAY;

void kwritec_with_color(char output, ubyte color)
{
    ushort vtmp = cast(ushort) (vb.pointer * 2);
    vb.address[vtmp] = cast(ubyte) output;
    vb.address[vtmp + 1] = color;
    if (vb.pointer + 1 == 2000)
    {
        vb.pointer = 0;
        return;
    }
    vb.pointer++;
}

void kwritec(char output)
{
    kwritec_with_color(output, COLOR);
}

void kwrites(string output)
{
    foreach (c; output)
    {
        kwritec(c);
    }
}

// kmain.d
import kio;
extern(C):

void kmain()
{
    /* works
    ubyte *video = cast(ubyte *) 0x000B_8000;
    video[0] = cast(ubyte) 'T';
    video[1] = (BLACK << 4) | GRAY;
    video[2] = cast(ubyte) 'e';
    video[3] = (BLACK << 4) | GRAY;
    video[4] = cast(ubyte) 's';
    video[5] = (BLACK << 4) | GRAY;
    video[6] = cast(ubyte) 't';
    video[7] = (BLACK << 4) | GRAY;
    */

    kwrites("test"); // nothing prints
}