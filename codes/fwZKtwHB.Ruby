command, = s.read(1).unpack("C")

case command
when 0
  len, = s.read(2).unpack("n")
  device_token = s.read(len)
  len, = s.read(2).unpack("n")
  payload = s.read(len)

  # do something with payload et cetera
end