timp@timbsd:~/mygithub/Rex % git diff
diff --git a/lib/Rex/Service/NetBSD.pm b/lib/Rex/Service/NetBSD.pm
index 958adf2..a47aa44 100644
--- a/lib/Rex/Service/NetBSD.pm
+++ b/lib/Rex/Service/NetBSD.pm
@@ -44,11 +44,16 @@ sub ensure {

   if ( $what =~ /^stop/ ) {
     $self->stop( $service, $options );
-    delete_lines_matching "/etc/rc.conf", matching => qr/${service}=YES/;
+    #rm -rf /etc/rc.conf.d/$service;
+    delete_lines_matching "/etc/rc.conf",
+      matching => qr/\s*${service}="?((?i)YES)"?/;
   }
   elsif ( $what =~ /^start/ || $what =~ m/^run/ ) {
     $self->start( $service, $options );
-    append_if_no_such_line "/etc/rc.conf", "${service}=YES\n";
+    #rm -rf /etc/rc.conf.d/$service;
+    append_or_amend_line "/etc/rc.conf",
+      line => "${service}=YES",
+      regexp => qr/^\s*${service}="?((?i)YES|NO)"?/;
   }

   return 1;