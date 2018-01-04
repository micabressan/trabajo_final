#s=TCPSocket.open('64.85.163.94','6114')
# sudo tcpick -i wlan0 -C -yR 
require "socket"
ARGV.each


data=(rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0] + (rand(122-97) + 97).chr.unpack("H*")[0]
s=TCPSocket.open(ARGV[0],ARGV[1]) # renew bot

s.print(["f71e2d00c50d00300000000000e01709000000#{data}000100020017d7c0a8016b0000000000000000"].pack("H*"))
while b = s.gets
	
data=(b.unpack("H*"))
		
	if data.to_s.include?("f7010800") == true
	puts"handshakje"
	puts data
	ping=data.to_s.index("f7010800")
	
	puts"ping #{data.to_s[ping..ping+16]} PONG"
	s.gets.shutdown(Socket::SHUT_RD)
	s.print(["#{data.to_s[ping..ping+14]}"].pack("H*"))
	
	else
	
	puts data
	puts""
end
end