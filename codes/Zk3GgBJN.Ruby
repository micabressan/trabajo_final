require "socket"
ARGV.each

data="693869676d6163" # i8igmac
s=TCPSocket.open(ARGV[0],ARGV[1]) 
s.print(["f71e2d00c50d00300000000000e01709000000#{data}000100020017d7c0a8016b0000000000000000"].pack("H*"))
s.print(["f7420d000100000001219e1f00"].pack("H*"))
s.print(["f74608003b983d47"].pack("H*"))
s.print(["f7281a000201020310706f6f6f6f6f6f6f6f6f6f6f6f6f6f7000"].pack("H*"))#pooooooop or hello world example
s.read