#!/usr/bin/ruby

require 'optparse'
def ComputeChecksum(s)
  accum = 0
  s *= 10
  accum += 3 * ((s / 10000000) % 10)
  accum += 1 * ((s / 1000000) % 10)
  accum += 3 * ((s / 100000) % 10)
  accum += 1 * ((s / 10000) % 10)
  accum += 3 * ((s / 1000) % 10)
  accum += 1 * ((s / 100) % 10)
  accum += 3 * ((s / 10) % 10)
  digit = (accum % 10)
  return (10 - digit) % 10
end
def F(n)
  if n==1 or n==2 or n==0
    return 1
  end
  return F(n-1) + F(n-2)
end
def FibGen(num)
  return F(num);
end
def GenerateWPS(strMac)
  fibnum = Array.new(6)
  fibsum=0;
  seed=16
  count=1
  offset=0
  counter=0
  arrayMacs =  strMac.split(":").map { |s| s.hex }
  tmp = arrayMacs.dup
  for i in 0..5
    if tmp[i] > 30
      while tmp[i] > 31 do
        tmp[i] -= 16
        counter += 1
      end
    end
    if counter == 0
      if tmp[i] < 3
        tmp[i] = tmp[0]+tmp[1]+tmp[2]+tmp[3]+tmp[4]+tmp[5]-tmp[i]
        if tmp[i] > 0xff
          tmp[i] = tmp[i] & 0xff
        end
        tmp[i] = (tmp[i]%28) + 3
      end
      fibnum[i] = FibGen(tmp[i])
    else
      fibnum[i] = FibGen(tmp[i])+FibGen(counter)
    end
    counter = 0
  end

    for i in 0..5
    fibsum += (fibnum[i]*FibGen(i+seed))+arrayMacs[i]
  end
  fibsum = fibsum%10000000
  checksum = ComputeChecksum(fibsum)
  fibsum = (fibsum*10) + checksum
  return fibsum.to_s
end

if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
      opts.banner = "Usage: arriswps.rb OPTIONS"
      opts.separator ""
      opts.separator "Options"
      opts.on('-m', '--mac 00:00:00:00:00:00', 'HFC MAC ADDRESS') { |v| options[:mac_address] = v }
  end.parse!
  raise OptionParser::MissingArgument if options[:mac_address].nil?
  puts GenerateWPS(options[:mac_address])
end