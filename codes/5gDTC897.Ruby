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
i=0
b = b.map { |e|
  if /^[0-1 ]+$/.match(e)
    int = Integer(e, 2)
    puts "Parsing #{e} as #{int}" if i < 10

    # handle numbers larger than 8 bytes by splitting them up
    if int > 256
      iarr = [int/256, int%256]
    else
      iarr = [int]
    end

    pk = iarr.pack("C*")  # parse as base2 and output zero-padded
    pkout = pk.unpack("B*")[0]
    puts "Saving #{int} as #{pkout}" if i < 10
    i += 1
    pk
  else
    nil
  end
}.compact

puts b[0..4]

File.open(fname+suffix, 'wb') do |out|
  out.write b.join
end