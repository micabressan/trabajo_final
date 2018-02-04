print "\nEnter array elements: "
a = gets.split(" ").map{|s| s.to_i}

print "Enter partition value: "
x = $stdin.gets.to_i

puts "\nInput array: " + a.to_s
print "Output array: " + a.partition {|i| (i <= x)}
puts "\nPartition Index: " + b.length.to_s