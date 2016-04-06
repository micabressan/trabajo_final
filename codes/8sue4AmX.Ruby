def spiral(n)

       mtx = []
       n.times do |c|
           mtx << []
       end
           row = n.div(2)
           col = n.div(2)
       if (n % 2 == 0)
           col = n.div(2)-1
       end
       count = 1
       step = 1
       while count <= (n * n)
           step.times do |n|
               mtx[row][col] = count % 10
               count += 1
               row -= 1
           end
           p count
           p mtx
           if (count >= n * n)
                return mtx
            end
           
           
           step.times do |n|
               mtx[row][col] = count % 10
               count += 1
               col += 1
           end
           
           step += 1
           p count
           if (count >= n * n)
                return mtx
            end

           down = step
           if (down > mtx.size)
               down = mtx.size - 1
           end
           down.times do |n|
               mtx[row][col] = count % 10
               row += 1
               count += 1
           end
            if (count >= n * n)
                return mtx
            end
            down.times do |n|
               mtx[row][col] = count % 10
               col -= 1
               count += 1
           end
           step += 1
           
           if (count >= n * n)
                return mtx
            end
           
       end
       return mtx
end

def print_spiral(n)
    mtx = spiral(n)
    mtx.each do |row|
        p row
    end
end