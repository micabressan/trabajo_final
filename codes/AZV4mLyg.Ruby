def cross_stitch(amount, interval: 0, **kwarg)
  "x#{' '*interval}" * amount
end

def dash_stitch(amount, interval: 0, dash_type: :vertical, **kwarg)
  dash_types = {vertical: "|", horizontal: "-", slash: "/", back_slash: "\\"}
  "#{dash_types[dash_type]+' '*interval}" * amount if dash_types.has_key?(dash_type)
end

def seagull(stitch_type, stitch_size, amount, **kwargs)
  result = ""
  amount.times { begin result += send("#{stitch_type}_stitch", stitch_size, **kwargs); rescue; result = "Error"; break end }
  result.rstrip!
  result += "\n"
end
print "Чайка 1: "
p seagull :dash, 5, 5, interval: 1, dash_type: :horizontal

def seagull2(stitch_type, stitch_size, amount, line_break_each: 0, **kwargs)
  result = ""
  1.upto(amount) do |i|
    begin result += send("#{stitch_type}_stitch", stitch_size, **kwargs); rescue; result = "Error\n"; break end
    if (line_break_each > 0 && (i.modulo(line_break_each) == 0) || i == amount) then
      result.rstrip!
      result += "\n"
    end
  end
  result
end
print "Чайка 2: "
p seagull2 :dash, 2, 8, interval: 1, line_break_each: 2, dash_type: :horizontal

def seagull3(*stitch_sequence, stitch_size, **kwargs)
  result = ""
  stitch_sequence.each { |stitch_type| result += send("#{stitch_type}_stitch", stitch_size, **kwargs) rescue "Error" }
  result.rstrip!
  result += "\n"
end
print "Чайка 3: "
p seagull3 :dash, :error, :dash, :cross, :dash, 4, interval: 1

def embroidery_machine(*args)
  result = ""
  args.each { |stitch_type, stitch_size, stitch_kwargs| result += send("#{stitch_type}_stitch", stitch_size, **stitch_kwargs) rescue "Error" }
  result.rstrip!
  result += "\n"
end
print "Вышивальная машинка: "
p embroidery_machine [:dash, 7, {interval: 1}], [:dash, 5, {interval: 2, dash_type: :horizontal}], [:error, 3, {}], [:cross, 7, {}]