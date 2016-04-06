#!/bin/sh

for a in $(find . ); do
    #cat $a | openssl dgst -sha256
    cat $a | sha256sum
done
------------------------
sha256sum:
$time test.sh
....
real    0m10.265s
user    0m8.100s
sys     0m5.509s

openssl dgst -sha256:
$time test.sh
....
real    0m19.896s
user    0m17.719s
sys     0m6.789s