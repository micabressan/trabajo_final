#!/bin/bash

clean_and_exit()
{
    echo "[SHTTPD] Clean and exit..."
    rm /run/shttpd.pid
    exit 0
}

echo $$ > /run/shttpd.pid
trap clean_and_exit SIGHUP SIGINT SIGTERM SIGSTOP
echo "[SHTTPD] Running.."
while true; do
    html=`cat /var/www/index.html`
    echo -en "HTTP/1.0 200 OK\nContent-Type: text/html\nContent-Length: ${#html}\n\n$html" | nc -l -c -p 80
done

exit 1