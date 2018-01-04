def circleOfNumbers(n, firstNumber)
    if firstNumber < n / 2 then
       return (n / 2) + firstNumber
    else
       return ((n / 2) - firstNumber).abs
    end
end