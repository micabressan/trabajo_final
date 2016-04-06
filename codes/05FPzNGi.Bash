auth --enableshadow --passalgo=sha512

install

cdrom

rootpw --lock

# Use text mode install
text

keyboard --vckeymap=us --xlayouts='us'
lang en_US.UTF-8

selinux --permissive

# Do not configure the X Window System
skipx

# Installation logging level
logging --level=info

# System timezone
timezone America/New_York --isUtc

# Include partition configuration setup by the %pre section
%include /tmp/part-include

%pre --erroronfail
#!/bin/sh

x1=2

%end

%addon hello --arg=$x1   
%end                       #failed here

%post --nochroot
#!/bin/sh
%end