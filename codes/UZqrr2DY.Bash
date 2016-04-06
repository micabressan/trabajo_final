*filter
:INPUT       ACCEPT
:OUTPUT      ACCEPT
:FORWARD     ACCEPT

-A INPUT  -i lo -j ACCEPT
-A OUTPUT -o lo -j ACCEPT

-A INPUT   -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A OUTPUT  -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

-A INPUT   -m conntrack --ctstate INVALID -j DROP
-A OUTPUT  -m conntrack --ctstate INVALID -j DROP
-A FORWARD -m conntrack --ctstate INVALID -j DROP

#INCOMING
:SSH-Throttle -
-A SSH-Throttle -m recent --name ssh_throttle --set
-A SSH-Throttle -m recent --name ssh_throttle --update --seconds 5 --hitcount 2 -j DROP
-A SSH-Throttle -j ACCEPT
-A INPUT -i eth0 -p tcp --dport 22 -m conntrack --ctstate NEW -j SSH-Throttle

-A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -m limit --limit 25/minute --limit-burst 100 -j ACCEPT

-A INPUT -p icmp --icmp-type echo-request -j ACCEPT
-A OUTPUT -p icmp --icmp-type echo-reply -j ACCEPT

#OUTGOING
-A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT
-A INPUT -p icmp --icmp-type echo-reply -j ACCEPT

-A OUTPUT -p udp -o eth0 --dport 53 -j ACCEPT
-A INPUT -p udp -i eth0 --sport 53 -j ACCEPT

-A OUTPUT -p tcp -d www.bolha.com --dport 80 -m conntrack --ctstate NEW -j ACCEPT
-A OUTPUT -p tcp -d www.njuskalo.hr --dport 80 -m conntrack --ctstate NEW -j ACCEPT
-A OUTPUT -p tcp -d www.avto.net --dport 80 -m conntrack --ctstate NEW -j ACCEPT
-A OUTPUT -p tcp -d smtp.gmail.com --dport 465 -m conntrack --ctstate NEW -j ACCEPT
-A OUTPUT -p tcp -d api.github.com  --dport 443 -m conntrack --ctstate NEW -j ACCEPT


#FALLBACKS

-A INPUT -j DROP
-A OUTPUT -j DROP
-A FORWARD -j DROP

COMMIT