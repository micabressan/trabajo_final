<!--DOCTYPE html-->

<!-- Name : KeyLock | Version : 0.1 | Author : TÃ©o Bouttier-->
<!--This is a secured login API designed for Idralwel and AÃ©roclub Figari Sud Corse-->

<?php
session_start();

$date = date('Y-m-d H:i:s');

$db = new PDO('mysql:host=sql308.epizy.com;dbname=epiz_20963586_site','epiz_20963586','figari');
if(isset($_POST['login']))
{
    $username = htmlspecialchars($_POST['username']);
    $pass = sha1($_POST['pass']);
    if(!empty($username) AND !empty($pass))
    {
        $requser = $db->prepare("SELECT * FROM members WHERE username = ? AND pass = ?");
        $requser->execute(array($username, $pass));
        $userexist = $requser->rowCount();

        if($userexist == 1)
        {
            $userinfo = $requser->fetch();
            $_SESSION['id'] = $userinfo['id'];
            $_SESSION['username'] = $userinfo['username'];
            $_SESSION['name'] = $userinfo['name'];
            $_SESSION['mail'] = $userinfo['mail'];
            $_SESSION['clearance'] = $userinfo['clearance'];
            $logtime = $db->prepare("UPDATE members SET log_date = ? WHERE id = ?");
            $logtime->execute(array($date, $userinfo['id']));
            header("Location: profile.php?id=".$_SESSION['id']);
        }
        else
        {
          if ($userexist == 0) {
            $requser = $db->prepare("SELECT * FROM admins WHERE username = ? AND pass = ?");
            $requser->execute(array($username, $pass));
            $userexist = $requser->rowCount();

              if ($userexist == 1) {
                $userinfo = $requser->fetch();
                $_SESSION['id'] = $userinfo['id'];
                $_SESSION['username'] = $userinfo['username'];
                $_SESSION['name'] = $userinfo['name'];
                $_SESSION['mail'] = $userinfo['mail'];
                $_SESSION['clearance'] = $userinfo['clearance'];
                $_SESSION['valid'] = true;
                header("Location: admin/news_admin.php");
              }
              else {
                $error = "Wrong username or password !";
          }

          }

        }

    }
    else
    {
        $error = "Please complete all fields";
    }
}


?>


    <html>

    <head>
        <title>Control Air - Connection</title>
        <meta charset="utf-8">
        <link rel="icon" href="./images/controlair.png">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
        <link rel="stylesheet" href="css/skel.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-xlarge.css" />
        <style>
            /*-----ALERT BOX-----*/

            /* The alert message box */

            body {
                background-color: #192024;
            }
            p{
              max-width: 40em;
            }


            .success {
                padding: 20px;
                background-color: #2db000;
                /* Green */
                color: white;
                margin-bottom: 15px;
                margin-left: 25%;
                margin-right: 25%;
                opacity: 1;
                transition: opacity 0.6s;
                /* 600ms to fade out */
            }

            .error {
                padding: 20px;
                background-color: darkred;
                /* Red */
                color: white;
                margin-bottom: 15px;
                margin-left: 25%;
                margin-right: 25%;
                opacity: 1;
                transition: opacity 0.6s;
                border: 1px solid darkred;
                border-radius: 5px;
            }

            /* The close button */

            .closebtn {
                margin-left: 15px;
                color: white;
                font-weight: bold;
                float: right;
                font-size: 22px;
                line-height: 20px;
                cursor: pointer;
                transition: 0.3s;
            }

            /* When moving the mouse over the close button */

            .closebtn:hover {
                color: black;
            }

        </style>
    </head>

    <body>
        <div align="center">
            <img alt="KeyLock Logo" src="images/controlair.png" width="200px" height="auto">
            <br><br>
            <?php

            if(isset($error))

            { ?>
            <br>
            <div class="error">
                <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
                <p class="text-center">
                    <?php echo ($error);?>
                </p>
            </div>
            <?php }; ?>

            <form method="post" action="" class="login" style="">
                <table>
                    <tr>
                        <td>
                            <input type="text" placeholder="Username" name="username" id="username" value="<?php if(isset($username)) {echo $username;} ?>" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="password" placeholder="Password" name="pass" id="password" />
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <input type="submit" name="login" value="Login">
                        </td>
                    </tr>
                </table>

            </form>
            <p>Les identifiants administrateurs actuels pendant mes tests sont :<br> admin<br>pass</p>
        </div>
    </body>

    </html>