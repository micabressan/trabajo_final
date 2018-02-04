def isLowerTriangularMatrix(matrix)
    x = 0
    y = 0
    starting = 1
    result = true
      
    while (x < matrix.length)
          y = starting
        
          while (y < matrix.length)
                if matrix[x][y] != 0 then
                   result = false
                end
                    
                y = y + 1
          end 
              
          starting = starting + 1
          x = x + 1
    end
        
    return result
end