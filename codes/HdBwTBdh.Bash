[dntldev@289elmp13 htdocs]$ curl --version
curl 7.44.0 (x86_64-redhat-linux-gnu) libcurl/7.44.0 OpenSSL/0.9.8b zlib/1.2.3 c-ares/1.10.0 libidn/1.18 libssh2/1.4.2
Protocols: dict file ftp ftps gopher http https imap imaps ldap ldaps pop3 pop3s rtsp scp sftp smb smbs smtp smtps telnet tftp
Features: AsynchDNS IDN IPv6 Largefile GSS-API Kerberos SPNEGO NTLM NTLM_WB SSL libz UnixSockets Metalink
[dntldev@289elmp13 htdocs]$ curl -X POST --verbose --header "Content-Type:text/xml;charset=UTF-8" --data @"/var/www/dntl.dev.bluetenthost.com/htdocs/landsofamerica.xml" https://www.landsofamerica.com/LandFeed/index.cfm
*   Trying 65.200.12.152...
* Connected to www.landsofamerica.com (65.200.12.152) port 443 (#0)
* Cipher selection: ALL:!EXPORT:!EXPORT40:!EXPORT56:!aNULL:!LOW:!RC4:@STRENGTH
* successfully set certificate verify locations:
*   CAfile: /etc/pki/tls/certs/ca-bundle.crt
  CApath: none
* TLSv1.0 (OUT), TLS handshake, Client hello (1):
* error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert handshake failure
* Closing connection 0
curl: (35) error:14077410:SSL routines:SSL23_GET_SERVER_HELLO:sslv3 alert handshake failure
[dntldev@289elmp13 htdocs]$