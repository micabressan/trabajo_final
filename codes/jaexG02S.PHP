<?php
function habbo($name) {
  $ch = curl_init();
  curl_setopt( $ch, CURLOPT_URL, "https://www.habbo.nl/api/public/users" );
  curl_setopt( $ch, CURLOPT_HEADER, false );
  curl_setopt( $ch, CURLOPT_HTTPHEADER, array( 'Accept-Encoding: gzip, deflate, sdch' ) );
  curl_setopt( $ch, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT'] );
  curl_setopt( $ch, CURLOPT_RETURNTRANSFER, true );
  curl_setopt( $ch, CURLOPT_FOLLOWLOCATION, true );
  curl_setopt( $ch, CURLOPT_SSL_VERIFYHOST, 0 );
  curl_setopt( $ch, CURLOPT_SSL_VERIFYPEER, 0 );
  curl_setopt( $ch, CURLOPT_URL, "http://www.habbo.nl/api/public/users?name=" . $name );

  $id = json_decode( curl_exec( $ch ) );
  if( isset( $id ) ) {
    if (isset($id->error)) {
      $info = false;
      curl_close( $ch );
      return $info;
    } else {
      if (isset($id->errors)) {
        $info = false;
        curl_close( $ch );
        return $info;
      } else {
        $info = $id->motto;
      }
    }
  } else 
    $info = false;
    curl_close( $ch );
    return $info;
}