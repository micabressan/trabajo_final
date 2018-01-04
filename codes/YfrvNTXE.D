// this TAKES REALLY REALLY long time to compile.
enum int[102400] array = [0]; 
int foobar(int i)
{
    return (array[i] ^ array[i] ^ array[i] ^ array[i] ^ array[i]);
}