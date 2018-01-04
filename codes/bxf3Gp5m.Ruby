def differentSubstringsTrie(inputString)
    unique_characters = inputString.split(//).uniq.length
    array = Array.new
    x = 0
    y = 1
    z = 0
    
    while (x < inputString.length - 1)
          string = inputString[x]
        
          while (y < inputString.length)
                string = string + inputString[y]
                array[z] = string
                y = y + 1
                z = z + 1
          end
        
          x = x + 1
          y = x + 1
    end
    
    return unique_characters + array.uniq.length
end