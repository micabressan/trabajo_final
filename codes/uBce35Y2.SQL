FotoKoch.nl
---

-- Host: localhost    Database: fkdb
-- ------------------------------------------------------
-- Server version	5.5.37-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `zend_users`
--

DROP TABLE IF EXISTS `zend_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zend_users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `photo_job_pk` int(10) DEFAULT NULL,
  `kenmerk_code` varchar(15) DEFAULT NULL,
  `opdrachtnr` varchar(40) DEFAULT NULL,
  `fotopad` varchar(512) DEFAULT NULL,
  `schoolnaam` varchar(128) DEFAULT NULL,
  `txt_group` varchar(50) CHARACTER SET ucs2 DEFAULT NULL,
  `username` varchar(128) DEFAULT NULL,
  `enc_password` varchar(128) DEFAULT NULL,
  `userlevel` tinyint(1) DEFAULT '0',
  `int_loginfout` tinyint(4) DEFAULT '0',
  `firstname` varchar(128) DEFAULT NULL,
  `lastname` varchar(128) DEFAULT NULL,
  `prefix` varchar(10) DEFAULT NULL,
  `street` varchar(128) DEFAULT NULL,
  `street_only` varchar(128) DEFAULT NULL,
  `housenumber` varchar(50) DEFAULT NULL,
  `housenumber_only` int(1) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `city` varchar(128) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `country` varchar(128) DEFAULT NULL,
  `firstname_delivery` varchar(128) DEFAULT NULL,
  `prefix_delivery` varchar(10) DEFAULT NULL,
  `lastname_delivery` varchar(128) DEFAULT NULL,
  `street_delivery` varchar(128) DEFAULT NULL,
  `street_only_delivery` varchar(128) DEFAULT NULL,
  `housenumber_delivery` varchar(50) DEFAULT NULL,
  `housenumber_only_delivery` int(1) DEFAULT NULL,
  `suffix_delivery` varchar(50) DEFAULT NULL,
  `postcode_delivery` varchar(10) DEFAULT NULL,
  `city_delivery` varchar(128) DEFAULT NULL,
  `country_delivery` varchar(128) DEFAULT NULL,
  `telnumber` varchar(40) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `remarks` varchar(5000) DEFAULT NULL,
  `newsletter` tinyint(1) DEFAULT NULL,
  `session_id` varchar(64) DEFAULT NULL,
  `ipaddress` varchar(32) DEFAULT NULL,
  `country_code` varchar(2) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `is_family` int(11) DEFAULT NULL,
  `is_employee` int(11) DEFAULT NULL,
  `is_school` int(11) DEFAULT '0',
  `is_photographer` tinyint(1) DEFAULT '0',
  `is_tester` tinyint(1) DEFAULT '0',
  `giro_sluitdatum` datetime DEFAULT NULL,
  `int_internetjob` int(11) DEFAULT NULL,
  `int_teacher_price` int(11) DEFAULT NULL,
  `txt_ip_address` varchar(50) DEFAULT NULL,
  `has_loggedin` tinyint(1) DEFAULT NULL,
  `selectiecode` varchar(50) DEFAULT NULL,
  `int_test_login` int(11) DEFAULT NULL,
  `birthdate` datetime DEFAULT NULL,
  `int_datumfout` tinyint(4) DEFAULT NULL,
  `groupphoto` tinyint(1) DEFAULT NULL,
  `int_temp_veld` int(1) DEFAULT NULL,
  `students_pk` int(11) DEFAULT NULL,
  `has_no_password` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `photo_job_pk` (`photo_job_pk`),
  KEY `students_pk` (`students_pk`),
  KEY `kenmerk_code` (`kenmerk_code`),
  KEY `email` (`email`),
  KEY `is_school` (`is_school`)
) ENGINE=InnoDB AUTO_INCREMENT=1916107 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

Slightly mangeld data subset extract:
---
fotopad,username,enc_password,firstname,lastname,street,housenumber,city,postcode,schoolnaam,telnumber,ipaddress,email,birthdate,has_no_password
U:\PORTRET\10000a\10000A\mainuser.JPG,mainuser,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"1979-08-26 00:00:00",""
U:\PORTRET\10000a\10000a\actionuser1.jpg,actionuser1,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,202.164.151.147,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\actionuser2.jpg,actionuser2,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\singleuser.jpg,singleuser,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,202.164.151.147,de_hek@yahoo.com,"",""
U:\PORTRET\10001a\10001a\singleuser2.jpg,singleuser2,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,202.164.151.123,joost@icterperuur.nl,"",""
U:\PORTRET\10001a\10001a\singleuser3.jpg,singleuser3,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\singleuser4.jpg,singleuser4,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\singleuser5.jpg,singleuser5,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\teacher.jpg,teacher,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\school.jpg,school,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,Rythovius,070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\admin.jpg,admin,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\photographer.jpg,photographer,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-8912558,127.0.0.1,de_hek@yahoo.com,"",""
U:\PORTRET\10000a\10000a\middelbaar.jpg,middelbaar,0xf799f0eabd6761ce,"JÒÓÔÕÖòóôõöst","MÀÁÂÃÄáâãäåttheijssen","iiiiiiiiiiÌÍÎÏìíîï 99","99 ","Nèééërgens",1000XX,"",070-891255X,127.0.0.1,de_hek@yahoo.com,"1979-08-26 00:00:00",""
U:\PORTRET\p0452a\p0452a\p0452a_010L0010.jpg,5940000,0xc6e0c547a0b05b01,"","ER XARISIUS","SWINGSTRAAT 7X","",ALMERE,"1326 PR","","","","","1998-05-27 00:00:00",""
U:\PORTRET\p0452a\p0452a\p0452a_012L0012.jpg,1940022,0xe47b9c9c7d6b8fd2,"","KE WONG XHUNG","CINEMADREEF 2xx","",ALMERE,"x325 XT","","","","","",""
U:\PORTRET\p0452a\p0452a\p0452a_024L0024.jpg,4940044,0x05a5b69f83c30750,"","L BEVERS CJ","KERSEBOOMSTRAAT 4X","",ALMERE,"1326 DK","","","","","",""
U:\PORTRET\p0452a\p0452a\p0452a_033L0033.jpg,2940033,0x53f393ad0dd3663b,"","SA WACHTER CJ","OLIVER HARDYSTRAAT 21","",ALMERE,"1325 CR","","","","","",""
U:\PORTRET\p0452a\p0452a\p0452a_040L0040.jpg,4940000,0xe48cc39bd6038428,Joost,Xattheijssen,"Tripstraat 4X","","Den Haag",0571DA,"",070-891255X,"",de_Xek@yahoo.com,"",""
U:\PORTRET\p0452a\p0452a\p0452a_042L0042.jpg,0940022,0xf186c7c46f8d33c7,"","A.N. van der Xinden eo","KON HOLLEWYNSTR 25","",ALMERE,"1336 HN","","","","","",""
U:\PORTRET\p0452a\p0452a\p0452a_060L0060.jpg,7940000,0xec4c127728ab6276,"","X. Busi eo","BUD ABBOTTSTRAAT 25","",ALMERE,"1325 CP","","","","","",""
U:\PORTRET\p0452a\p0452a\p0452a_067L0067.jpg,4940077,0x488fc573fc7f936b,"","XOSCOVITER MENSWEAR","ANNIE BOSSTRAAT X","",ALMERE,"1325 NL","","","","","",""
U:\PORTRET\p0452a\p0452a\p0452a_073L0073.jpg,8940033,0x4e1c3b1fb341f1b5,"","XLT VAN ZANDBEEK CJ","ADRIENNE SOLSERSTRAAT 2X","",ALMERE,"1325 NZ","","","","","",""
......
......
INSERT INTO `zend_users` VALUES (1847793,31947,'31947010352',NULL,'U:\\PORTRET\\p31947a\\p31947a\\p31947a_0352L0352.JPG',NULL,'1-2','319470352A','0x4f8ca9e2f163e880',0,0,'Bianca','Xerts','','Waterstraat 3X','Waterstraat','3X ',3X,'','Goor','747X XR','NL','','','','','',' ',0,'','','','NL','06-5355971X','XtjoinX@ziggo.nl','',0,'Xpfpmoqq0ipq0tp7lgrsskqnt2kiv129rj99fted0toq4i3lfj0X','X2.72.173.85','NL',1,NULL,NULL,0,0,0,'2014-11-21 00:00:00',1,NULL,NULL,1,NULL,NULL,'1899-11-30 00:00:00',NULL,NULL,NULL,3757230,NULL),(1847798,31947,'31947010363',NULL,'U:\\PORTRET\\p31947a\\p31947a\\p31947a_0363A0363.JPG',NULL,'1-2','319470363A','0x2f0709b3ccf023c1',0,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,1,NULL,NULL,0,0,0,'2014-11-21 00:00:00',1,NULL,NULL,0,NULL,NULL,'1899-11-30 00:00:00',NULL,NULL,NULL,3757235,NULL),(1847799,31947,'31947010366',NULL,'U:\\PORTRET\\p31947a\\p31947a\\p31947a_0366L0366.JPG',NULL,'1-2','319470366A','0xe48740ab8290e80b',0,0,'Xarlon','Xostma','','Xeldensestraat  13X','Xeldensestraat ','13X ',13X,'','Goor','X471kX','NL','','','','','',' ',0,'','','','NL','068200089X','Xarlontip198X@gmail.com','',0,'Xb8q0nmkqkbudg3utng4636217uietucgupq0s8rkabkrbj3q10X','82.75.13.140','NL',1,NULL,NULL,0,0,0,'2014-11-21 00:00:00',1,NULL,NULL,1,NULL,NULL,'1899-11-30 00:00:00',NULL,NULL,NULL,3757236,NULL)
......
......

Total Data Records = 760MB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
System had a backup on the system it self in a Public default web folder for many months, and still has doesn't have security measures in line with the level stated in the WBP as minimally needed when handling such large quantities of privacy sensitive data. 
$Company & CBP where informed months ago, but they both didn't feel like taking the action stated by law, like informing the users about the data leakage and fixing the overall lack of systems & web-application security.
Maybe this blog post will prompt CBP to take example action against the company, and for those thousands of customers with private data+foto's that is still kept on those systems.
??????????????????????????????????????