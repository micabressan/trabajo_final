a = ("a".."c").zip([6, 2, 2])
k, v = a.shift
b = [k] * v
puts b.join(", ")

a.each do |k, v|
  f = (b.length) * 1.0/ (v + 1)
  1.upto(v) do |i| 
    b.insert((i * f + i - 1).floor, k)
  end
  puts b.join(", ")
end