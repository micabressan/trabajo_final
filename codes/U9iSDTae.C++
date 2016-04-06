##
## copy this file to /var/etc/multics.cfg
## to run multics with debug type $# multics -v
## to run multics in background type $# multics -b
## to run multics with another config file type $# multics -C /var/etc/newconfig.cfg
##

##########################################################
## WEB INTERFACE
##########################################################

HTTP PORT: 5500

## web user/pass protection
#HTTP USER: admin
#HTTP PASS: admin

##########################################################
## CLUSTERED CACHE (Compatible with CSP cache)
##########################################################

CACHE PORT: 4444    # cache listen port(udp)
CACHE TIMEOUT: 300  # timeout to wait dcw from cache servers if a cacherequest was received.

# friend cacheline (host port)
CACHE PEER: myfriend.dns.org 12345
CACHE PEER: localhost 5555


##########################################################
## SERVERS CONNECTIONS (CCCAM+NEWCAMD+MGCAMD)
##########################################################

## CCcam Client version
CCCAM VERSION: 2.1.1 # Select cccam client version "2.0.11", "2.1.1", "2.1.2", "2.1.3", "2.1.4" (default: 2.0.11)

## Change you clientid (in hex) by default it is Generic
#NEWCAMD CLIENTID: 4343 # Mgcamd(6D67).newcs(6E73).Evocamd(6576).CCcam(4343)...


C: localhost 12000 user pass # get all local cards with reshare or not.
C: 192.168.1.100 12000 user pass
C: mydyndns.no-ip.org 12000 user pass

N: localhost 10001 dummy dummy 01 02 03 04 05 06 07 08 09 10 11 12 13 14
N: 192.168.1.100 10003 dummy dummy 01 02 03 04 05 06 07 08 09 10 11 12 13 14
N: mydyndns.no-ip.org 10002 dummy dummy 01 02 03 04 05 06 07 08 09 10 11 12 13 14


##########################################################
## PROFILES
##########################################################

## Default des-key for all profiles
DEFAULT KEY: 01 02 03 04 05 06 07 08 09 10 11 12 13 14

## Global Users, must be defined before the first profile
USER: guser1 gpass1  # for all profiles
USER: guser1 gpass1 { 5501, 5502 }  # selected profiles by port list


[Digital+] # Profile name
##############################

# Newcamd config key&port
# KEY : 01 02 03 04 05 06 07 08 09 10 11 12 13 14 # optional, if not set default key is used.
PORT : 5501

# Profile Caid&Providers
CAID: 1810
PROVIDERS: 0, 4001, 4101

ONID: 31 # Operator Network ID (hex value)

## Time/Server Config (all times start from ecm receive time)
DCW MINTIME : 300     # minimum time to send dcw to client.( default=0, max=700ms )
DCW TIMEOUT : 3500    # delay after that if no cw returned from servers, multics would send decode failed to client
# Next options depend on your cards number and speed for this profile
SERVER MAX: 2         # max server to use for decoding one ecm request.
SERVER INTERVAL: 1500 # interval between sending ecm request to servers. first server will be requested at receiving ecm request from client, the second request will be done after "SERVER INTERVAL" has been elapsed and so ...
SERVER TIMEOUT: 2000  # max time for selecting servers to decode one ecm request it must be greater than "SERVER INTERVAL"
SERVER VALIDECMTIME: 2000 # Disable sending ecmrequest to cards with ecmtime greater than 2000ms

## newcamd clients

USER: user1 pass1 # Newcamd client ( nline is like that N: mydns.dns 5502 user1 pass1 01 02 03 04 05 06 07 08 09 10 11 12 13 14 )
USER: user2 pass2


[Canalsat] # Profile 2
##############################

## Deny ecm requests for channels Cine+ 1...11
SID DENYLIST: 1
SID LIST: 20D2,20D3,20D4,20D5,20D6,20D7,20D8,20D9,20DB,20DC

# Newcamd config key&port
KEY : 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E
PORT : 5502

# Profile Caid&Providers
CAID: 0100
PROVIDERS: 3311

ONID: 1

## Time/Server Config
DCW MINTIME : 0
DCW TIMEOUT : 3500
SERVER MAX: 3
SERVER INTERVAL: 1500
SERVER TIMEOUT: 2000
SERVER VALIDECMTIME: 2000

## newcamd clients
USER: user pass


[***it]
##############################

# Newcamd config key&port
PORT : 5503

# Profile Caid&Providers
CAID: 093B
PROVIDERS: 0

ONID: fbff

## Time/Server Config
DCW MINTIME : 0 # if you have many clients and channel freezes increase it to 300..500 ms
DCW TIMEOUT : 1000
SERVER MAX: 2
SERVER INTERVAL: 400  # if channel freezes and your cards have high ecmtime set it to 0
SERVER TIMEOUT: 500
SERVER VALIDECMTIME: 700

## newcamd clients
USER: user pass


[Jsc+9+10]
##############################

## Open only +9 and +10 channels, other channels are not accepted
SID LIST: 0325, 0326, 20FD, 20FE

# Newcamd config key&port
PORT : 5504

# Profile Caid&Providers
CAID: 0500
PROVIDERS: 42400

## Time/Server Config
DCW MINTIME : 300
DCW TIMEOUT : 3500
SERVER MAX: 3
SERVER INTERVAL: 1500
SERVER TIMEOUT: 2000
SERVER VALIDECMTIME: 1500

## newcamd clients
USER: user pass


##########################################################
## CCCAM SERVER
##########################################################

## CCcam server listen port
CCCAM PORT: 12000

## CCcam clients
F: user1 pass1  # no reshare
F: user2 pass2 1 # 1 reshare
F: user2 pass2 2 # 2 reshare