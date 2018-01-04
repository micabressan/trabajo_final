def intersperse(a, b)
  v = a.length
  f = (b.length) * 1.0/ (v + 1)
  1.upto(v) do |i|
    b.insert((i * f + i - 1).floor, a[i-1])
  end
end
  
a = ("a".."c").zip([6, 2, 2]).map {|x, y| [x] * y}
a.reverse!
b = a.shift
puts b.join(", ")
a.each do |c|
  intersperse(c, b)
  puts b.join(", ")
end