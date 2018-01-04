puts "Choose input filename. Ex: 2016-08-24.txt"
fname = gets.chomp()
fname = "2016-08-24.txt" if fname.length == 0
puts "Using file #{fname}"

puts "Choose output suffix. Ex: .bin"
suffix = gets.chomp()
suffix = ".bin" if suffix.length == 0
puts "Using suffix #{suffix}"

puts "Reading:"
f = File.read(fname)
b = f.gsub(/\s+/m, ' ').strip.split(" ")

puts b[0..4]

puts "Converting:"
b = b.map { |e|
  if /^[0-1]+$/.match(e)
    "%02d" % Integer(e, 2)  # parse as base2 and output zero-padded
  else
    nil
  end
}.compact

puts b[0..4]

puts "Parsing:"

h = [b.join].pack("H*")
a = [b.join].pack("a*")
o = [b.join].pack("B*")

puts h[0..10]
puts a[0..10]
puts o[0..10]

File.open(fname+suffix, 'wb') do |out|
  out.write h
end