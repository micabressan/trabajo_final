<?php
/*
* BOT SADAP V4
* Created By Gilang Dandnug
* Email : joywhan@kimcil.ws
* FB : https://www.facebook.com/gilang.dandung
* Twitter : https://twitter.com/Dandung_Whoami
* Instagram : Ngga Punya ,
* Powered BY TESSERACT OCR
* HOW TO Excekute Upload And Rename With Name sadap.php , and Visit http://anumu.com/sadap.php?token=CAAAAAA&id=10000099_8829829xxx
* Bisa D Cron Dan Digabungin Dengan Refresh Token Mbah :v
* **** NOTE , Jangan Sadap Autolike Negeri Sendiri Mbah :v , Kan Site Autolike Banyak :v , ****
* Tambahkan AUtolikenya Terserah Yang Penting Jgn Negeri Sendiri !!! , Hanya Perlu Edit dan Tambahkan Function
* Thank You
* Covered By L Joywhan
* NEW
* FITUR ENCODE POST AND VIA WEB SERVER
* Fixing Bug With Function Private And Public :v
 
*/
        class semvak
{
        public $token;
        public $id;
       
        private function xstring($string,$start,$end)
        {
        $str = explode($start,$string);
        $str = explode($end,$str[1]);
        return $str[0];
    }
        private function xaccess($url)
        {
       
                $ch = curl_init($url);
                curl_setopt($ch,CURLOPT_FOLLOWLOCATION,false);
                curl_setopt($ch,CURLOPT_REFERER,$url);                
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_USERAGENT,'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36');
                curl_setopt($ch,CURLOPT_COOKIEFILE,'cookie.txt');
                curl_setopt($ch,CURLOPT_COOKIEJAR,'cookie.txt');                              
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                $body = curl_exec($ch);
                $info = curl_getinfo($ch);
                $redir = $info['redirect_url'];
                $redirect = $redir;
                return $body;
        }
        private function copyright()
        {
                $w = '<body style="background-color:black">
               <font color="green" style="Times New Roman"><b>
               <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
               <pre>
╔═══╗╔══╗╔╗───╔═══╗╔═╗─╔╗╔═══╗     ╔═══╗╔═══╗╔═╗─╔╗╔═══╗╔╗─╔╗╔═╗─╔╗╔═══╗
║╔═╗║╚╣─╝║║───║╔═╗║║║╚╗║║║╔═╗║     ╚╗╔╗║║╔═╗║║║╚╗║║╚╗╔╗║║║─║║║║╚╗║║║╔═╗║
║║─╚╝─║║─║║───║║─║║║╔╗╚╝║║║─╚╝     ─║║║║║║─║║║╔╗╚╝║─║║║║║║─║║║╔╗╚╝║║║─╚╝
║║╔═╗─║║─║║─╔╗║╚═╝║║║╚╗║║║║╔═╗     ─║║║║║╚═╝║║║╚╗║║─║║║║║║─║║║║╚╗║║║║╔═╗
║╚╩═║╔╣─╗║╚═╝║║╔═╗║║║─║║║║╚╩═║     ╔╝╚╝║║╔═╗║║║─║║║╔╝╚╝║║╚═╝║║║─║║║║╚╩═║
╚═══╝╚══╝╚═══╝╚╝─╚╝╚╝─╚═╝╚═══╝     ╚═══╝╚╝─╚╝╚╝─╚═╝╚═══╝╚═══╝╚╝─╚═╝╚═══╝
       </pre>';
        echo $w;
        }
        private function getCaptcha($lokasi)
     {
         $ch = curl_init($lokasi);
         curl_setopt($ch,CURLOPT_COOKIEJAR,'cookie.txt');      
         curl_setopt($ch,CURLOPT_COOKIEFILE,'cookie.txt');      
         curl_setopt($ch,CURLOPT_COOKIESESSION,true);
         curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
         curl_setopt($ch,CURLOPT_REFERER,$lokasi);
         curl_setopt($ch, CURLOPT_USERAGENT,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.52 Safari/537.36');
         curl_setopt($ch,CURLOPT_FOLLOWLOCATION,false);
         curl_setopt($ch,CURLOPT_HEADER,0);
         curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
         curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
         curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
         $y = curl_exec($ch);
         $tmpFile = uniqid();
         $file = $tmpFile.'.png';
         $x = fopen($file,"w");
         fwrite($x,$y);
         fclose($x);
         $up = 'http://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['PHP_SELF']).'/'.$file;
         $xa = file_get_contents('http://104.197.52.172/~unamenak/curl.php?img='.$up); //API
         unlink($file);
         return $xa;
                 curl_close($ch);
        }
        private function Submit($url,$fields)
    {
                $field_string = http_build_query($fields);
                $ch = curl_init();
                curl_setopt($ch,CURLOPT_URL,$url);
                curl_setopt($ch,CURLOPT_FOLLOWLOCATION,false);
                curl_setopt($ch,CURLOPT_REFERER,$url);          
                curl_setopt($ch,CURLOPT_TIMEOUT,5);            
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_USERAGENT,'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.52 Safari/537.36');
                curl_setopt($ch,CURLOPT_COOKIEFILE,'cookie.txt');
                curl_setopt($ch,CURLOPT_COOKIEJAR,'cookie.txt');
                curl_setopt($ch, CURLOPT_POST, count($field_string));
                curl_setopt($ch,CURLOPT_POSTFIELDS,$field_string);  
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                $body = curl_exec($ch);
                if(!curl_errno($ch)){
                $info = curl_getinfo($ch);
                $redir = $info['redirect_url'];
                $code = $info['http_code'];
                curl_close($ch);
                return $redir." <br> Dengan Code = ".$code."";
                }
                unlink("cookie.txt");
                curl_close($ch);
    }
        private function dj()
        {
                $II = "http://djliker.com/loginmedj.php?user=".$this->token;
                $III = "http://djliker.com/captcha.php";
                $III = array(
                "answer" => $this->getCaptcha($III),
                "submit" => "SUBMIT",
                );
                $IIII = "http://djliker.com/Like.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                "slider" => "200",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";
        }
                private function monkey()
        {
                $II = "http://monkeyliker.com/login.php?user=".$this->token;
                $III = "http://monkeyliker.com/captcha.php";
                $III = array(
                "answer" => $this->getCaptcha($III),
                "submit" => "SUBMIT",
                );
                $IIII = "http://monkeyliker.com/Like.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                "slider" => "400",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                        private function mg()
        {
                $II = "http://mg-likers.com/login.php?access_token=".$this->token;
                $III = "http://mg-likers.com/includes/image.php";
                $III = array(
                "captcha_verify" => $this->getCaptcha($III),
                "submit" => "SUBMIT",
                );
                $IIII = "http://mg-likers.com/like.php?type=custom";
                $IIIII = array(
                "privacy" => "yes",
                "submit" => "submit",
                "id" => $this->id,
                "limit" => "200",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                        private function topautolike()
        {
                $II = "http://www.topautolike.com/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://www.topautolike.com/like.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function kdliker()
        {
                $II = "http://www.kdliker.com/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://www.kdliker.com/index.php";
                $IIIII = array(
                "id" => $this->id,
                "limitlike" => "150",
                "access_token" => $this->token,
                "pancal" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function royaliker()
        {
                $II = "http://www.royaliker.net/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://www.royaliker.net/liker.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                        private function likelo()
        {
                $II = "http://likelo.in/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://likelo.in/index.php";
                $IIIII = array(
                "id" => $this->id,
                "access_token" => $this->token,
                "pancal" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function myfbliker()
        {
                $II = "http://www.myfbliker.com/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://www.myfbliker.com/home.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                "selector" => "150",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function swaglikers()
        {
                $II = "http://www.swaglikers.com/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://www.swaglikers.com/index.php";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function vipautoliker()
        {
                $II = "http://vipautoliker.com/Go.login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://vipautoliker.com/liker.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function haylike()
        {
                $II = "http://haylike.net/login.php?user=".$this->token."&submit=Submit.%21";
                $III = array(
                "null" => "null",
                );
                $IIII = "http://haylike.net/rkzganteng.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function fblikess()
        {
                $II = "http://fblikess.com/login.php";
                $III = array(
                "null" => "null",
                );
                $III = array(
                "user" => $this->token,
                "submit" => "Submit",
                );
                $IIII = "http://fblikess.com/liker.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                private function fourliker()
        {
                $II = "http://4liker.com/verify.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://4liker.com/liker.php?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "likerange" => "200",
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                        private function newfbautoliker()
        {
                $II = "http://newfbautoliker.com/Access.php";
                $III = array(
                "null" => "null",
                );
                $III = array(
                "pass" => $this->token,
                "submit" => "Submit",
                );
                $IIII = "http://newfbautoliker.com/likes/?type=custom";
                $IIIII = array(
                "id" => $this->id,
                "submit" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                        private function noxliker()
        {
                $II = "http://noxliker.in/login.php?user=".$this->token;
                $III = array(
                "null" => "null",
                );
                $IIII = "http://noxliker.in/index.php";
                $IIIII = array(
                "id" => $this->id,
                "access_token" => $this->token,
                "pancal" => "Submit",
                );
                echo $this->Submit($II,$III);
                echo "<br>";
                echo $this->Submit($IIII,$IIIII);
                echo "<br>";
                echo "================================__0>@WHOAMI@<0__================================";
                echo "<br>";          
        }
                       
        public function SADAP()
        {
                ignore_user_abort(true);
                while (@ob_end_flush());      
                ob_implicit_flush(true);
                echo $this->copyright();
                echo $this->dj();
                echo $this->monkey();
                echo $this->mg();
                echo $this->topautolike();
                echo $this->kdliker();
                echo $this->royaliker();
                echo $this->likelo();
                echo $this->myfbliker();
                echo $this->swaglikers();
                echo $this->vipautoliker();
                echo $this->haylike();
                echo $this->fblikess();
                echo $this->fourliker();
                echo $this->newfbautoliker();
                echo $this->noxliker();
                break;
        }
}
$toket = array(
"http://alamattoken.com/my_token.txt",
"http://alamattoken.com/anu/my_token.txt",
"http://alamattoken.com/akun2/my_token.txt",
"http://alamattoken.com/akun3/my_token.txt",
//dan seterusnya
);
foreach ($toket as $b => $a)
{
	$token = file_get_contents($a);

$try = new semvak;
$try->token=$token;
$try->id=$id;
$try->SADAP();
}