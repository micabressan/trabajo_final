#!/bin/ruby

def minimumAbsoluteDifference(n, arr)
    arr.sort!
    return arr.zip(arr.rotate(1)).map{|x| (x[0] - x[1]).abs}.min
end

n = gets.strip.to_i
arr = gets.strip
arr = arr.split(' ').map(&:to_i)
result = minimumAbsoluteDifference(n, arr)
puts result