
m = Mutex.new


x = Thread.new() do
  begin
    m.lock
      puts "x sync"
      sleep 5
      raise "x err"
      sleep 5
    m.unlock 
  rescue 
  end
end


y = Thread.new() do
  sleep 0.5
  m.lock
    puts "y sync"
  m.unlock 
end


x.join
y.join