#!/bin/bash

# Sockets uptime (SUP)
# Author: Dawid Mocek (dawid.mocek@gmail.com)
# Require: python

# SUP must be run as ROOT

# SUP does not take any args from the user - you need to modify some variables in this script
# SUP shows times when socket was accessed, modified, changed and remote_addr, local_addr, inode created by a runinng process
# SUP example output:
#[root@my scripts]# ./socket_uptime.sh
#           Local addr. Remote addr. Last access Last modify Last change       inode
#         0.0.0.0:6789   0.0.0.0:*         52m      17662m      17662m        9920
#    10.202.30.12:9991   0.0.0.0:*         52m      17662m      17662m        8863
#    10.202.30.12:9999   0.0.0.0:*         52m      17662m      17662m        9926
#    10.202.30.12:8080   0.0.0.0:*         52m      17662m      17662m        8862
#       0.0.0.0:60720   0.0.0.0:*         52m      17662m      17662m        9921
#       0.0.0.0:52820   0.0.0.0:*         52m      17662m      17662m        9918
#    10.202.32.12:4447   0.0.0.0:*         52m      17662m      17662m        9927
#    10.202.32.12:8080  10.255.24.13:40186         52m      17662m      17662m     8652595


# The only variables you need to modify here are:
#       PID - __runinng__ processs id
#       TCP_STATE - tcp state you wish or "ALL" of them. Read more: man netstat
#       TIME_FORMAT



# Process pid
PID="1104"

# Possible values for TCP_STATE are: TIME_WAIT CLOSE_WAIT FIN_WAIT ESTABLISHED SYN_RCVD(man netstat) or just  ALL
TCP_STATE="ALL"

# Possible values for TIME_FORMAT are: DAYS HOURS MINUTES SECONDS
TIME_FORMAT="HOURS"


# Disable file expansion cos netstat outputs wildcards(*)
set -f

LANG=C
LC_NUMERIC=C
LC_COLLATE=C
NOW=""

# Converts port number (int) to hex
function port_to_hex() {
    p=${1:?Port number}
    # wilcard(*) case: netstat -tlnuap eg.:
    # [...]
    # tcp        0      0 0.0.0.0:6789                0.0.0.0:*                   LISTEN      1104/java
    if [ "$p" == "*" ]; then
        printf '%04X' 0
    else
        printf '%04X' $p
    fi
}

# HEX IP addr is printed backwards using: cat /proc/net/tcp
# so we need to pack it into raw socket struct to convert
function ipv4_to_hex() {
    ip=${1:?IPv4 address}
    echo $(python -c "
import socket, struct;
print hex(struct.unpack('<L',socket.inet_aton('$ip'))[0])[2:].upper().zfill(8)")
}

# Returns file descriptor inode
function get_fd_inode {
    remote_hex_ip=${1:?Remote hex IPv4}
    remote_hex_port=${2:?Remote hex port number}
    local_hex_ip=${3:?Local hex IPv4}
    local_hex_port=${4:?Local hex port number}

    awk '$2 == "'$local_hex_ip:$local_hex_port'" && $3 == "'$remote_hex_ip:$remote_hex_port'" {print $10}' /proc/net/tcp
}

# Returns last time access, last time read and last time modified
# %(X|Y|Z) corresponds to EPOCH time
function inode_time {
    pid=${1:?PID}
    inode=${2:?i-node}
    find "/proc/$pid/fd" -lname "socket:\[$inode\]" -exec stat -c "%X %Y %Z"  {} \;
}


function change_output_time_format() {
    tmp=${1:?Time}
    if [ "$tmp" -eq "0" ]; then
        echo "<1"
    else
        echo "$tmp"
    fi
}

function socket_uptime() {
    pid=${1:?PID}
    inode=${2:?i-node}
    format=${3:?Format DAYS | HOURS | SECONDS}

    # Get time
    time=$(inode_time $pid $inode)

    if [ "x$time" != "x" ]; then
        tmp2=($time)

        # Defaults to: seconds
        divisor=1
        ext="s"
        if [[ $format == "SECONDS" ]]; then
            divisor=1
            ext="s"
        elif [[ $format == "MINUTES" ]]; then
            divisor=60
            ext="m"
        elif [[ $format == "HOURS" ]]; then
            divisor=3600
            ext="h"
        elif [[ $format == "DAYS" ]]; then
            divisor=86400
            ext="d"
        fi

        last_access=$(( ($NOW - ${tmp2[0]}) / $divisor ))
        last_modify=$(( ($NOW - ${tmp2[1]}) / $divisor ))
        last_change=$(( ($NOW - ${tmp2[2]}) / $divisor ))

        last_access=$(change_output_time_format $last_access)
        last_modify=$(change_output_time_format $last_modify)
        last_change=$(change_output_time_format $last_change)

        echo "$last_access$ext $last_modify$ext $last_change$ext"
    else
        echo "N/A N/A N/A"
    fi
}


# Main program #

# Hash array storing ip in hex format
declare -A HEX_IP_CACHE

# Get current date in epoch format - it's a lot time faster than runing `date` command every function call in a loop in main_program
NOW=$(date -d 'now' +%s)

HEADER=0

# Check if PID exists
if [[ $(kill -s 0 $PID > /dev/null 2>&1) -eq "0" ]]; then

    # Set flag if user choose all tcp states
    IS_ALL="false"
    if [[ "$TCP_STATE" == "ALL" ]]; then
        IS_ALL="true"
    fi

    netstat -tulnap | awk -v is_all=$IS_ALL '{ if (is_all == "true" && $7 ~ /^'"$PID"'/) { print $4, $5; } else if ($6 == "'"$TCP_STATE"'" && $7 ~ /^'"$PID"'/) { print $4, $5; } }' | while read line; do
        # To array
        tmp=($line)

        local_addr=${tmp[0]}
        remote_addr=${tmp[1]}

        # Replace ":" from netstat output
        local_addr=("${local_addr/:/ }")
        remote_addr=("${remote_addr/:/ }")

        # To array
        local_addr=($local_addr)
        remote_addr=($remote_addr)

        # Assign local ports and ipv4 numbers
        local_ip=${local_addr[0]}
        local_port=${local_addr[1]}

        # Assign remote ports and ipv4 numbers
        remote_ip="${remote_addr[0]}"
        remote_port="${remote_addr[1]}"

        # Convert port number to hex
        local_hex_port=$(port_to_hex $local_port)
        remote_hex_port=$(port_to_hex $remote_port)

        local_hex_ip=""
        remote_hex_ip=""


        # Convert ipv4 to hex or use cache(a lot time faster than coverting it again using python)
        if  test "${HEX_IP_CACHE[$local_addr]+isset}"; then
            local_hex_ip=${HEX_IP_CACHE[$local_ip]}
        else
            local_hex_ip=$(ipv4_to_hex $local_ip)
            HEX_IP_CACHE[$local_ip]=$local_hex_ip
        fi

        if  test "${HEX_IP_CACHE[$remote_addr]+isset}"; then
            remote_hex_ip=${HEX_IP_CACHE[$remote_ip]}
        else
            remote_hex_ip=$(ipv4_to_hex $remote_ip)
            HEX_IP_CACHE[$remote_ip]=$remote_hex_ip
        fi



        # Get fd inode
        inode=$(get_fd_inode $remote_hex_ip $remote_hex_port $local_hex_ip $local_hex_port)

        # Stats() this fd(socket)
        sup=($(socket_uptime $PID $inode $TIME_FORMAT))
        last_access=${sup[0]}
        last_modify=${sup[1]}
        last_change=${sup[2]}

        if [ $HEADER -eq 0 ]; then
            printf "%22s %11s %11s %11s %11s %11s \n" "Local addr." "Remote addr." "Last access" "Last modify" "Last change" "inode"
            HEADER=1
        fi
        local_addr="$local_ip:$local_port"
        local_addr_size=${#local_addr}

        remote_addr="$remote_ip:$remote_port"
        remote_addr_size=${#remote_addr}

        printf "%22s %11s %11s %11s %11s %11s \n" "$local_addr" "$remote_addr" "$last_access" "$last_modify" "$last_change" "$inode"
    done
fi