require 'matrix'

size = 602
m = Matrix.zero(size)

last_num = size ** 2
n = 1

move_by = 1
row = 300
col = 300

current_move = 0
previous_move = 0
moves = 0

while m.find_index(0)
  move_by_tmp = move_by
  while move_by_tmp > 0
    m.send :set_element, row, col, n
    previous_move = current_move
    move_by_tmp -= 1

    case current_move
    when 0
      col = col + 1 # move right
      current_move = 1 if move_by_tmp == 0
    when 1
      row = row - 1 # move up
      current_move = 2 if move_by_tmp == 0
    when 2
      col = col - 1 # move left
      current_move = 3 if move_by_tmp == 0
    when 3
      row = row + 1 # move down
      current_move = 0 if move_by_tmp == 0
    end

    moves += 1 unless previous_move == current_move

    if moves == 2
      move_by += 1
      moves = 0
    end
    n = [
        m[row - 1,col - 1] ? m[row - 1,col - 1] : 0,
        m[row,col - 1] ? m[row,col - 1] : 0,
        m[row + 1,col -1] ? m[row + 1,col -1] : 0,
        m[row - 1,col] ? m[row - 1,col] : 0,
        m[row + 1,col] ? m[row + 1,col] : 0,
        m[row - 1,col + 1] ? m[row - 1,col + 1] : 0,
        m[row,col + 1] ? m[row,col + 1] : 0,
        m[row + 1,col + 1] ? m[row + 1,col + 1] : 0].reject{|elem| elem == 0}.inject(0){ |sum, x| sum + x }
  end
end


result = m.select{ |a| a > 361527 }.sort[0]
puts "Result #{result}"