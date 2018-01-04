struct Color
{
    float r, g, b, a;
}

Color rgba(ubyte r, ubyte g, ubyte b, float a)
{
    return Color(r / 255.0f, g / 255.0f, b / 255.0f, a);
}