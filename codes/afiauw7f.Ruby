def addDigits(a, b, n)
    number = 0
    x = 1
    string = a.to_s
    
    while (x <= n)
          append = false
        
          if (string + "9").to_i % b == 0 then
             number = number + 1
             append = true
             string = string + "9"
          elsif (string + "8").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "8"
          elsif (string + "7").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "7"
          elsif (string + "6").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "6"
          elsif (string + "5").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "5"
          elsif (string + "4").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "4"
          elsif (string + "3").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "3"
          elsif (string + "2").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "2"
          elsif (string + "1").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "1"
          elsif (string + "0").to_i % b == 0 then
                number = number + 1
                append = true
                string = string + "0"
          end
                
          if append == true then
             x = x + 1
          else
             break
          end
    end
                
    return string
end