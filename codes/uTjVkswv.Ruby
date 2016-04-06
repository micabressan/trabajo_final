#!/usr/bin/env ruby

require 'prime'

def count_p(a,b)
  c = 0
  i = a

  while i <= b do
    combs = i.to_s.split(//).combination(2).to_a.delete_if {|c| c[0] == "0"}
    combs.each {|comb|
      if Prime.prime?(comb.join.to_i)
        c += 1
      end
    }
    i += 1
  end

  return c
end

result = count_p(ARGV[0], ARGV[1])

puts 'There are %s primys between %s and %s' % [result, ARGV[0], ARGV[1]]