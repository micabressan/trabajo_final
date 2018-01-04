<?php

$ch = curl_init();

//curl_setopt($ch, CURLOPT_URL, "https://api-direct.posbistro.com/api/public/anchor");
curl_setopt($ch, CURLOPT_URL, "https://api-direct.posbistro.com/api/public/locations/dc6ba5d7-e9d5-acf6-ce35-d8aecf9867e9/categories");
curl_setopt($ch, CURLOPT_POST, 0);
//curl_setopt($ch, CURLOPT_POSTFIELDS,
//    "client_id=78-001423-002649");
curl_setopt($ch, CURLOPT_POSTFIELDS,
    "public_token=7MynVRa7miWWBpqHB7Txig3HXQHvtOcbZQizulZ33P9yZAyGztuExDlFHom0BVTE");


curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$server_output = curl_exec($ch);

curl_close($ch);

//if ($server_output == "OK") { ... } else { ... }
var_dump($server_output);
?>

<!-- 7MynVRa7miWWBpqHB7Txig3HXQHvtOcbZQizulZ33P9yZAyGztuExDlFHom0BVTE


{"status":true,"message":"Anchored successfully",
"client_id":"78-001423-002649",
"short_id":4044,
"public_token":"7MynVRa7miWWBpqHB7Txig3HXQHvtOcbZQizulZ33P9yZAyGztuExDlFHom0BVTE",
"assets_path":"http://posbistro-prod.s3.amazonaws.com",
"server_domain":"api.posbistro.com",
"pusher_data":{"key":"612168969802852439459608016322",
"ssl":false,"host":
"web-socket.posbistro.com",
"port":4567,
"client_port":8080}}

-->