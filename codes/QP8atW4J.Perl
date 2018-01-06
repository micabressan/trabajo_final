Options +Indexes +FollowSymLinks
RewriteEngine On
RewriteBase /
RewriteRule ^m$			m/index.php [R=301,L]


ErrorDocument 404 /index.php?f=404


RewriteRule ^tum_gazeteler/$ index.php?f=gazeteler [L,QSA]
RewriteRule ^404.html$ index.php?f=404 [L,QSA]
RewriteRule ^reklamci$ index.php?f=affiliate [L,QSA]
RewriteRule ^reklamci/cikis$ index.php?f=affiliate&ff=logout [L,QSA]
RewriteRule ^2011/$ index.php?f=arsiv&yil=2011 [L,QSA]
RewriteRule ^2011$ index.php?f=arsiv&yil=2011 [L,QSA]
RewriteRule ^index.html$ index.php [L,QSA]
RewriteRule ^arama.html$ index.php?f=arama [L,QSA]
RewriteRule ^reklam.html$ index.php?f=reklam [L,QSA]
RewriteRule ^iletisim.html$ index.php?f=iletisim [L,QSA]
RewriteRule ^insan-kaynaklari.html$ index.php?f=insan-kaynaklari [L,QSA]
RewriteRule ^profil.html$ index.php?f=profil [L,QSA]
RewriteRule ^cikis.html$ index.php?f=logout [L,QSA]
RewriteRule ^sifremi_unuttum.html$ index.php?f=password_reminder [L,QSA]
RewriteRule ^uye_islemleri.html$ index.php?f=uye_islemleri [L,QSA]
RewriteRule ^admin$ admin/index.php [L,QSA]
RewriteRule ^video-galerisi.html$ index.php?f=vid_galeri [L,QSA] 
RewriteRule ^video-galerisi.html$ index.php?f=vid_galeri [L,QSA]
RewriteRule ^fotograf-galerisi.html$ index.php?f=foto_galeri [L,QSA]
RewriteRule ^mobil-haberler.html$ index.php?f=mobil_haberler [L,QSA]

RewriteRule ^video/sayfa-([0-9]+)$ index.php?f=vid_galeri&sayfa=$1 [L,QSA]

RewriteRule ^yerel_haber/([a-zA-Z0-9_.]+)-haberleri-([0-9]+)/$ index.php?f=sehir&plaka=$2 [L,QSA]
RewriteRule ^yerel_haber/([a-zA-Z0-9_.]+)-haberleri-([0-9]+)/sayfa-([0-9]+)$ index.php?f=sehir&plaka=$2&sayfa=$3 [L,QSA]

RewriteRule ^([a-zA-Z0-9_-]+)/([a-zA-Z0-9_]+)-gazetesi/$ index.php?f=gazete&ff=$2 [L,QSA]


RewriteRule ^yerel_haber/([a-zA-Z0-9_.]+)/([a-z0-9_]+)-haberleri-([0-9]+)/$ index.php?f=ilce&plaka=$3 [L,QSA]
RewriteRule ^yerel_haber/([a-zA-Z0-9_.]+)/([a-z0-9_]+)-haberleri-([0-9]+)/sayfa-([0-9]+)$ index.php?f=ilce&plaka=$3&sayfa=$4 [L,QSA]



RewriteRule ^video/([a-z0-9_]+)-videolari-([0-9]+)/sayfa-(.*)$ index.php?f=vid_galeri&sayfa=$3&fff=$2&ff=$1 [L,QSA]


RewriteRule ^([a-z0-9_]+)-haberleri-([0-9]+)/([a-z0-9_]+)-([a-z0-9_]+)-haberi-([0-9]+)\.html index.php?f=content&id=$5 [L,QSA] 

RewriteRule ^tarihte_bugun/([0-9]+)/([0-9]+)/sayfa-([0-9]+) index.php?f=tarihte_bugun&gun=$1&ay=$2&sayfa=$3 [L,QSA]
RewriteRule ^tarihte_bugun/([0-9]+)/([0-9]+) index.php?f=tarihte_bugun&gun=$1&ay=$2 [L,QSA]


RewriteRule ^foto/([a-z0-9_]+)/([0-9]+)/sayfa-([0-9]+)$ index.php?f=foto_galeri&ff=$1&sayfa=$3&gal=$2 [L,QSA]
RewriteRule ^foto/([a-z0-9_]+)/([0-9]+)/sayfa-([0-9]+)/$ index.php?f=foto_galeri&ff=$1&sayfa=$3&gal=$2 [L,QSA]

RewriteRule ^foto/([a-z0-9_]+)/([0-9]+)/$ index.php?f=foto_galeri&ff=$1&gal=$2 [L,QSA]

RewriteRule ^arama/sayfa/([0-9]+)$ index.php?f=arama&sayfa=$1 [L,QSA]
RewriteRule ^([a-z0-9_]+)-resim_galerisi-([0-9]+)/$ index.php?f=galeri&ff=$2 [L,QSA]

RewriteRule ^([a-z0-9_]+)-resim_galerisi-([0-9]+)/sayfa-([0-9]+)$ index.php?f=galeri&ff=$2&sayfa=$3 [L,QSA]
RewriteRule ^([a-z0-9_]+)-videolari-([0-9]+)/$ index.php?f=vid_galeri&fff=$2&ff=$1 [L,QSA]
RewriteRule ^([a-z0-9_]+)-galerisi-([0-9]+)/$ index.php?f=foto_galeri&fff=$2&ff=$1 [L,QSA]
RewriteRule ^([a-z0-9_]+)-haberleri-([0-9]+)/sayfa/([0-9]+)$ index.php?f=category&tag=$1&id=$2&sayfa=$3 [L,QSA]
RewriteRule ^([a-z0-9_]+)-haberleri-([0-9]+)/$ index.php?f=category&tag=$1&id=$2 [L,QSA]
RewriteRule ^([a-z0-9_]+)-haberi-([0-9]+)/$ index.php?f=tag_search&ff=$2&tag=$1 [L,QSA]



RewriteRule ^([a-z0-9_]+)-gunun_gelismeleri-([0-9]+).html$ index.php?f=gundem&id=$2&tarih=$1 [L,QSA]
RewriteRule ^([a-z0-9_]+)-gunun_gelismeleri-([0-9]+)/sayfa-([0-9]+)$ index.php?f=gundem&id=$2&tarih=$1&sayfa=$3 [L,QSA]


RewriteRule ^haber_galerisi/([a-z0-9_]+)-([0-9]+).html$ index.php?f=gundem&id=$2&link=$1 [L,QSA]
RewriteRule ^haber_galerisi/([a-z0-9_]+)-([0-9]+)/sayfa-([0-9]+)$ index.php?f=gundem&id=$2&sayfa=$3&link=$1 [L,QSA]


RewriteRule ^([a-z0-9_]+)-haberi-([0-9]+)/sayfa/([0-9]+)$ index.php?f=tag_search&ff=$2&sayfa=$3&tag=$1 [L,QSA]
RewriteRule ^video/([a-z0-9_]+)/$ index.php?f=vid_galeri&ff=$1 [L,QSA]

RewriteRule ^foto/galeriler/sayfa-([0-9]+)/$ index.php?f=foto_galeri&gal_sayfa=$1 [L,QSA]
RewriteRule ^foto/galeriler/sayfa-([0-9]+)$ index.php?f=foto_galeri&gal_sayfa=$1 [L,QSA]

RewriteRule ^foto/([a-z0-9_]+)-galerileri-([0-9]+)/sayfa-([0-9]+)/$ index.php?f=foto_galeri&fff=$2&gal_sayfa=$3 [L,QSA]
RewriteRule ^foto/([a-z0-9_]+)-galerileri-([0-9]+)/sayfa-([0-9]+)$ index.php?f=foto_galeri&fff=$2&gal_sayfa=$3 [L,QSA]



RewriteRule ^([a-z0-9_]+).html$ index.php?f=tags&&ff=$1 [L,QSA]
RewriteRule ^tema/([a-z0-9_]+)$ temadegis.php?f=$1 [L,QSA]

RewriteRule 2011/([a-z]+)/([0-9]+)/sayfa/([0-9]+) index.php?f=arsiv&gun=$2&ay=$1&yil=2011&sayfa=$3 [L,QSA]
RewriteRule 2011/([a-z]+)/sayfa/([0-9]+) index.php?f=arsiv&ay=$1&yil=2011&sayfa=$2 [L,QSA]
RewriteRule 2011/sayfa/([0-9]+) index.php?f=arsiv&yil=2011&sayfa=$1 [L,QSA]

RewriteRule 2011/([a-z]+)/([0-9]+) index.php?f=arsiv&gun=$2&ay=$1&yil=2011 [L,QSA]

RewriteRule 2011/([a-z]+) index.php?f=arsiv&ay=$1&yil=2011 [L,QSA]