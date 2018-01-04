sqrt(n, guess)
{
    if(n <= 1)
        return n

    newGuess = ((n / guess) + guess) / 2

    if newGuess == guess
        return newGuess

    return sqrt(n, newGuess)
}