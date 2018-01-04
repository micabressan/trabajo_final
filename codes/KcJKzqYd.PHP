<?php
    $wal_im = 1;
    $wal_nz = 1;
    $wal_np = 1;
    $wal_m = 1;
    $wal_post = 1;
    $wal_cal = 0;
    $imie = $nazwisko = $panienskie = $email = $kod_pocztowy = $plec ="";

    if(isset($_POST["wyslij"]))
    {
        $imie = $_POST["imie"];
        if (empty($imie))
            $wal_im=0;
        if (is_numeric($imie))
            $wal_im=0;
        if(!preg_match("/^[a-zA-ZąęćżźńłóśĄĆĘŁŃÓŚŹŻ'-]+$/",$imie))
            $wal_im=0;

        $nazwisko = ($_POST["sname"]);
        if (empty($nazwisko))
            $wal_nz=0;
        if (is_numeric($nazwisko))
            $wal_nz=0;
        if(!preg_match("/^[a-zA-ZąęćżźńłóśĄĆĘŁŃÓŚŹŻ'-]+$/",$nazwisko))
            $wal1=0;


        $panienskie = ($_POST["pname"]);
        if (empty($panienskie))
            $wal_np=0;
        if (is_numeric($panienskie))
            $wal_np=0;
        if(!preg_match("/^[a-zA-ZąęćżźńłóśĄĆĘŁŃÓŚŹŻ'-]+$/",$panienskie))
            $wal_np=0;

        $email = ($_POST["email"]);
        if (empty($email))
            $wal_m=0;
        if (is_numeric($email))
            $wal_m=0;
        if(!preg_match("/^([a-zA-Z0-9])+([a-zA-Z0-9\._-])*@([a-zA-Z0-9_-])+([a-zA-Z0-9\._-]+)*(\.[a-z]{2,3})+$/",$email))
            $wal_m=0;

        $kod_pocztowy = ($_POST["postcode"]);
        if (empty($kod_pocztowy))
            $wal_post=0;
        if(!preg_match("/^([0-9]{2})(-[0-9]{3})?$/i",$kod_pocztowy))
            $wal_post=0;

        $plec = ($_POST["plec"]);

        $wal_cal = $wal_im + $wal_nz + $wal_m + $wal_post + $wal_np;
        if($wal_cal == 5)
        {

            echo "Imię: ".$imie;
            echo "<br>Nazwisko: ".$nazwisko;
            echo "<br>Płeć: ".$plec;
            echo "<br>Nazwisko panieńskie: ".$panienskie;
            echo "<br>Email: ".$email;
            echo "<br>Kod pocztowy: ".$kod_pocztowy;
        }
    }

    if(!isset($_POST["wyslij"]) or ($wal_cal != 5))
    {
        ?>
        <form action="index.php?strona=2" method="POST">

            <table>
                <tr>
                    <td>Imię:</td>
                    <td><input value="<?php if ($wal_im == 1)echo $imie;?>" type="text" name="imie" id="Name"><br/></td>
                    <td>
                        <?php if($wal_im == 0) echo "błędne dane";?></td>
                </tr>
                <tr>
                    <td>Nazwisko:</td>
                    <td><input value="<?php if ($wal_nz == 1)echo $nazwisko;?>" type="text" name="sname" id="Sname"><br/></td>
                    <td><?php if($wal_nz == 0) echo "błędne dane";?></td>
                </tr>
                <tr>
                    <td>Plec:</td>
                    <?php if ($plec == "male")echo '<td><input type="radio" name="plec" value="male" id="male" checked>mężczyzna<br>
                        <input type="radio" name="plec" value="female" id="female">kobieta<br></td>';
                    else echo '<td><input type="radio" name="plec" value="female" id="female" checked>kobieta<br>
                        <input type="radio" name="plec" value="male" id="male">mężczyzna<br></td>';
                    ?>
                </tr>
                <tr>
                    <td>Nazwisko panieńskie:</td>
                    <td><input value="<?php if ($wal_np == 1)echo $panienskie;?>" type="text" name="pname" id="Pname"><br/></td>
                    <td><?php if($wal_np == 0) echo "błędne dane";?></td>
                </tr>
                <tr>
                    <td>Email:</td>
                    <td><input value="<?php if ($wal_m == 1)echo $email;?>" type="text" name="email" id="Email"><br/></td>
                    <td><?php if($wal_m == 0) echo "błędne dane";?></td>
                </tr>
                <tr>
                    <td>Kod pocztowy:</td>
                    <td><input value="<?php if ($wal_post == 1)echo $kod_pocztowy;?>" type="text" name="postcode" id="Post"><br/></td>
                    <td><?php if($wal_post == 0) echo "błędne dane";?></td>
                </tr>
            </table>

            <button type="submit" name="wyslij" id="wyslij">wyślij</button>
        </form>
        <?php
    }
?>