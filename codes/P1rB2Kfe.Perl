--- log.dat	2015-04-09 09:15:45.346524000 +0200
+++ log.dat	2015-08-24 15:03:59.685568442 +0200
@@ -53,6 +53,7 @@
         'red' => '(red:|pppd\[.*\]: |chat\[.*\]|pppoe\[.*\]|pptp\[.*\]|pppoa\[.*\]|pppoa3\[.*\]|pppoeci\[.*\]|ipppd|ipppd\[.*\]|kernel: ippp\d|kernel: isdn.*|ibod\[.*\]|dhcpcd\[.*\]|modem_run\[.*\])',
         'ddns' => '(ddns\[\d+\]:)',
         'dns' => '(dnsmasq\[.*\]: )',
+        'dma' => '(dma\[.*\]: )',
         'dhcp' => '(dhcpd: )',
         'clamav' => '(clamd\[.*\]: |freshclam\[.*\]: )',
         'collectd' => '(collectd\[.*\]: )',
@@ -73,6 +74,7 @@
         'red' => 'RED',
         'ddns' => $Lang::tr{'dynamic dns'},
         'dns' => 'DNS',
+        'dma' => 'Mail',
         'dhcp' => "$Lang::tr{'dhcp server'}",
         'cron' => 'Cron',
         'collectd' => 'Collectd',
@@ -192,8 +194,10 @@
         # calculate file name
         if ($gzindex == 0) {
             $filestr = "/var/log/messages";
+            $filestr = "/var/log/mail" if (${section} =~ 'dma');
         } else {
             $filestr = "/var/log/messages.$gzindex";
+            $filestr = "/var/log/mail.$gzindex" if (${section} =~ 'dma');
     	    $filestr = "$filestr.gz" if -f "$filestr.gz";
         }
 	# now read file if existing