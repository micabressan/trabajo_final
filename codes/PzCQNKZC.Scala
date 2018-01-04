val input = 347991

def distance(n: Int) = {
    val level = ((sqrt(n) - 1) / 2).ceil.toInt
    val br = pow(level * 2 + 1, 2).toInt
    val offset = br - n
    val length = level * 2 + 1
    val k = length - 1

    val (x, y) =
        if (offset < k) (k / 2 - offset, -level)
        else if (offset < k * 2) (-level, offset - k / 2 - k)
        else if (offset < k * 3) (offset - k / 2 - 2 * k, level)
        else (level, 2 * k - offset + level * 3)

    abs(x) + abs(y)
}

distance(input)