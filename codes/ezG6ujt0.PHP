<?php
require 'vendor/autoload.php';

$mail = new PHPMailer (true);

$mail->isSMTP();
$mail->Host = 'smtp.gmail.com';
$mail->SMTPAuth = true;
$mail->Username = 'meine gmail adresse';
$mail->Password = 'mein gmail passwort';
$mail->SMTPSecure = 'ssl';
$mail->Port = 465;
$mail->CharSet = "UTF-8";

$mail->setFrom('meine gmail adresse', 'mein name');
$mail->addReplyTo('meine gmail adresse', 'mein name');

$mail->addAddress('empfänger email adresse');
$mail->isHTML(true);

$mail->Subject = 'Here is the subject';
$mail->Body    = 'This is the HTML message body <b>in bold!</b>';

if(!$mail->send()) {
  echo 'Your message could not be sent. Please try again!';
  echo 'Mailer Error: ' .$mail->ErrorInfo;
} else {
  echo 'Your Message has been sent! I will reply as quickly as i can ;)';
}
?>