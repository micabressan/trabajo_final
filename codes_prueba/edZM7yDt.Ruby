characters = [:a, :b, :c]

for i in 1..(characters.size)
  characters.combination(i).each do |el|
    p el.join
  end
end