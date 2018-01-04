<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <meta charset="UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        
        ?>
        <form name="zapis" method="post" action="ucitel.php" >
            <label>Předměty:
            
                <?php
                    $pripojeni = mysqli_init();
                    if(mysqli_real_connect($pripojeni, "localhost", "root")){
                        mysqli_select_db($pripojeni, "predmety");
                        mysqli_set_charset($pripojeni, "utf8");
                        session_start();
                        $login = $_SESSION["login"];
                        // echo $login;
                        
                        $dotaz = "select pr.zkratka_predmetu pred from predmety pr, pedagogove pe, pedagogove_predmety pp where pe.kod_pedagoga= '". mysqli_real_escape_string($pripojeni, $login)."'"." and pp.kod_pedagoga = pe.kod_pedagoga and pr.zkratka_predmetu = pp.zkratka_predmetu";

                        <select name="predmety">
                        

                        $vys = mysqli_query($pripojeni, $dotaz) or die(mysqli_error($pripojeni));
                        while($radek = mysqli_fetch_assoc($vys))
{
?>
                            <option value="<?php $radek["pred"]?>"><?php $radek["pred"]?></option>
<?php
}
?>
</select><?php
                    
                            
                    }else{
                        echo "Chyba pripojeni k db";
                    }
                
                ?>
               
            
            <label>Heslo:
            <input type="password" name="heslo"></br>
            
            <input type="submit" name="odeslat">
        </form>
    </body>
</html>