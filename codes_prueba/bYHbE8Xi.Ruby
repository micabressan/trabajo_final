text =
len = 0 

puts "Enter output line length:"
len=gets.chomp.to_i
puts "Enter the text:"
text=gets.chomp.to_s
text.reverse!
puts "="*50
if len >=10 && len <=100 
	puts text.gsub(/(.{1,#{len}})(\s+|\Z)/, "\\1\n")
end