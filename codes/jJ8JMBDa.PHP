
<?php

  require "mysql.php";


  $apk_name = ['ClockPackage.apk'] ['name'];

  $odex_name = ['ClockPackage.odex'] ['name'];

  $framework_name = ['framework'] ['name'];


  $directory_apk = 'requests/$name/apk';

  $directory_odex = 'requests/$name/odex';

  $directory_framework = 'requests/$name/framework';


  $target_apk = $directory_apk.$apk_name;

  $target_odex = $directory_odex.$odex_name;

  $target_framework = $directory_framework.$framework_name;





  if (isset($_POST['request'])) {

     function CheckCaptcha($userResponse) {

        $fields_string = '';

        $fields = array(

            'secret' => 'private key',

            'response' => $userResponse

        );

        foreach($fields as $key=>$value)

        $fields_string .= $key . '=' . $value . '&';

        $fields_string = rtrim($fields_string, '&');

        $ch = curl_init();

        curl_setopt($ch, CURLOPT_URL, 'https://www.google.com/recaptcha/api/siteverify');

        curl_setopt($ch, CURLOPT_POST, count($fields));

        curl_setopt($ch, CURLOPT_POSTFIELDS, $fields_string);

        curl_setopt($ch, CURLOPT_RETURNTRANSFER, True);

        $res = curl_exec($ch);

        curl_close($ch);

        return json_decode($res, true);

    }

    // Call the function CheckCaptcha

    $result = CheckCaptcha($_POST['g-recaptcha-response']);

    if (empty($_POST['name'])) {

      echo "<h5>Please enter a name</h5>";

    }

    else {

    $name = $_POST ['name'];

  }

      if (empty($_POST['email'])) {

        echo "<h5>Please enter your email</h5>";

      }

      else {

      $email = $_POST ['email'];

    }

      if (empty($_POST['ClockPackage.apk'])) {

        echo "<h5>Please upload your ClockPackage.apk to continue</h5>";

        }

        else {

      $clockapk = $_POST ['ClockPackage.apk'];

    }

          if (empty($_POST['ClockPackage.odex'])) {

        echo "<h5>Please upload your ClockPackage.odex to continue</h5>";

          }

          else {

      $clockodex = $_POST ['ClockPackage.odex'];

    }

        if (empty($_POST['framework'])) {

          echo "<h5>Please upload your framework to continue</h5>";

            }

            else {

      $framework = $_POST ['framework'];

    }

              if (empty($_POST['do_you_know_it'])) {

            echo "<h5>Please chose a option</h5>";

              }

        else {

          $you_know_it = $_POST ['do_you_know_it'];

        }

        if ($result['success']) {

        //If the user has checked the Captcha box

        echo "<h5>Captcha verified Successfully</h5>";


    } else {

        // If the CAPTCHA box wasn't checked

       echo "<h5>you must verifay chaptcha</h5>";

    }

  }

?>