unless ARGV.size == 2
  raise "Bad input"
end

pattern, filename = ARGV

subpattern_counts = []
positions = {}

(0...pattern.size).each do |i|
  # seed array for current number of subpatterns, up to the size of the
  # full pattern
  subpattern_counts << 0

  # Make a lookup table of pattern character to position, assuming unique
  # characters
  positions[pattern[i]] = i
end

# iterate through each character of the input
IO.read(filename).each_char do |c|

  # Get the position in the pattern of the current input character
  char_pos = positions[c]

  # If the pattern doesn't contain the input character, it doesn't affect us
  # at all
  next unless char_pos

  if char_pos == 0
    subpattern_counts[0] += 1
  else
    subpattern_counts[char_pos] += subpattern_counts[char_pos - 1]
  end

end

puts subpattern_counts.last