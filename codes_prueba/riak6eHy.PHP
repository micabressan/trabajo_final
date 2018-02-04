<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Diretta extends Model
{
    protected static $url = "https://www.diretta.it/";

    public static function today(){
      $ch = curl_init();
      curl_setopt($ch,CURLOPT_URL,self::$url);
      curl_setopt($ch,CURLOPT_POST, 0);                //0 for a get request
      curl_setopt($ch,CURLOPT_RETURNTRANSFER, true);
      curl_setopt($ch,CURLOPT_CONNECTTIMEOUT ,5);
      curl_setopt($ch,CURLOPT_TIMEOUT, 20);
      $response = curl_exec($ch);
      $html = $response;
      $doc = new \DOMDocument();
      @$doc->loadHTML($html);
      $finder = new \DomXPath($doc);
      $campionati = $finder->query("//table[@class='soccer']");
      //$result = [];
      print_r($campionati);
      return $html;
    }

}