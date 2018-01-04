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