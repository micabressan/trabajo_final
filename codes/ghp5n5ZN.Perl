RewriteEngine on

SetEnv TZ Europe/Budapest
Options -Indexes

#RewriteRule ^$ index.php [R,NC,L]

order allow,deny
<Files "index.php">
    Allow from all
</Files>
<Files ~ "\.(js|css|jpg|png|gif|woff|ttf)$">
   allow from all
</Files>