
def split_word(s, left, right)
  indices = (left...right+1).to_a
  indices.product(indices).reject{|i,j| i > j}.map{|i,j| s[i..j]}.uniq
end


n,q = gets.strip.split(' ')
n = n.to_i
q = q.to_i
s = gets.strip
for a0 in (0..q-1)
    left,right = gets.strip.split(' ')
    left = left.to_i
    right = right.to_i
    arr = split_word(s, left, right)
    #puts arr.to_s
    puts arr.size
    
end