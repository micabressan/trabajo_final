root@node02:~# ip rule show
0:	from all lookup local 
6:	from all fwmark 0x1 lookup 42 
7:	from all fwmark 0x1 lookup 42 
8:	from all fwmark 0x1 lookup 42 
9:	from all fwmark 0x1 lookup 42 
10:	from 10.0.0.0/8 lookup 42 
10:	from 10.0.0.0/8 lookup 42 
10:	from all to 10.0.0.0/8 lookup 42 
10:	from 10.0.0.0/8 lookup 42 
10:	from all iif br0-mg lookup 42 
10:	from all to 10.0.0.0/8 lookup 42 
10:	from all iif bat0-mg lookup 42 
10:	from all iif br0-mo lookup 42 
10:	from all to 10.0.0.0/8 lookup 42 
10:	from all iif bat0-mo lookup 42 
10:	from all iif br0-kk lookup 42 
10:	from all iif bat0-kk lookup 42 
10:	from 10.0.0.0/8 lookup 42 
10:	from all to 10.0.0.0/8 lookup 42 
10:	from all iif br0-niers lookup 42 
10:	from all iif bat0-niers lookup 42 
32766:	from all lookup main 
32767:	from all lookup default 
root@node02:~# ip route show table main| grep "dev lo"
root@node02:~# ip route show table default| grep "dev lo"
root@node02:~# ip route show table 42| grep "dev lo"
root@node02:~# ip route show table local| grep "dev lo"
broadcast 127.0.0.0 dev lo  proto kernel  scope link  src 127.0.0.1 
local 127.0.0.0/8 dev lo  proto kernel  scope host  src 127.0.0.1 
local 127.0.0.1 dev lo  proto kernel  scope host  src 127.0.0.1 
broadcast 127.255.255.255 dev lo  proto kernel  scope link  src 127.0.0.1 
root@node02:~#