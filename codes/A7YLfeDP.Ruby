MOVES = [[0,1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1,1]]
UNVISITED = 1
VISITED = 2

def region_size(m, x, y)
  return 0 if x < 0 or x >= m.size or y < 0 or y > m[0].size
  return 0 if m[x][y] != UNVISITED
  
  m[x][y] = VISITED
  1 + MOVES.map{|i, j| region_size(m, x + i, y + j) }.sum
end

def largest_region(m)
  matrix_indices = (0...m.size).to_a.product((0...m[0].size).to_a)
  matrix_indices.map{ |x, y| region_size(m, x, y) }.max
end