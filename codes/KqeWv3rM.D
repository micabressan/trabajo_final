int bitCount(int a)
{
    int result;
    while (a != 0)
    {
        result += a & 1; // vyber bit uplne vpravo
        a >>>= 1; // to iste ako a /= 2;
    }
    return result;
}