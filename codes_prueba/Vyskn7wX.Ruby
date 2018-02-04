#!/usr/bin/env ruby
RULES = {
  :nomonkey => [:no, /apa/],
  :rhino => [:yes, /rhino/]
}

FILES = {
  "./report/*.txt" => [:nomonkey, :rhino]
}

def file_contains_regexp?(filename,regexp)
  File.foreach(filename) do |line|
    return true if line =~ regexp
  end
  return false
end

def style_negate(style, bool_v)
  if style == :no
    return !bool_v
  end
  return bool_v
end

FILES.each do |filepattern, rulelist|
  Dir.glob(filepattern) do |file|    
    f_result = rulelist.collect do |x|
      style, pattern = RULES[x]
      [file, x, style_negate(style, file_contains_regexp?(file, pattern))]
    end    
    puts f_result.inspect
  end
end