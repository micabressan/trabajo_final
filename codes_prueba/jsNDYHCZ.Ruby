def squareDigitsSequence(a0)
    array = Array.new
    array[0] = a0
    y = 0
    z = 0
    string = a0.to_s
    result = 0
    counter = 1
      
    while (1)
          while (y < string.length)
                result = result + (string[y].to_i ** 2)
                y = y + 1
          end 
          
          counter = counter + 1
          
          while (z < array.length)
                if array[z] == result then
                   return counter
                end
                      
                z = z + 1
          end
          
          array.push(result)              
          string = result.to_s
          y = 0
          z = 0
          result = 0
    end
end