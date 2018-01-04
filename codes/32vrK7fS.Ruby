
class CRC_algorithm
  attr_accessor :d, :g, :gama
  
  def initialize (message, g = "1011")
    @d = message.unpack('b*').to_s.split("")
    @g = g.to_s.split("")
    @gama = init_gama(@g.length).to_s.split("")
  end

  def init_gama l
    s = []
    while s.length != l-1
      s << "0"
    end
    s
  end

  def start_
    _0_ = init_gama(@g.length + 1).to_s.split("")
    str = @d
    str += @gama
    i = @g.length
    t = i
    print str
    while i <= str.length
      gets
      (i-t).times { print " " }
      if str[i-t] == "0"
        print "#{str[(i-t) .. (i-1)]} xor\n"
        (i-t).times { print " " }
        print "#{_0_}\n"
        str[(i-t) .. (i-1)] = xor(str[(i-t) .. (i-1)], _0_)
      else
        print "#{str[(i-t) .. (i-1)]} xor\n"
        (i-t).times { print " " }
        print "#{@g}\n"
        str[(i-t) .. (i-1)] = xor(str[(i-t) .. (i-1)], @g)
      end
      print "#{str[0 .. (i-1)]}\n"
      i += 1
    end
    return str[(i-t) .. (str.length)]
  end

  def xor(a, b)
    s, i = [], 0
    while i != a.length
      if a[i] == b[i]
        s << "0"
      else
        s << "1"
      end
      i += 1
    end
    s
  end

end