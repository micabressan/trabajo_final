function zmiana_rozmiaru($file, $mime_type){


    $nazwa='images/source/'.$file['name'];
    $nazwa_nowy='images/min/min'.$file['name'];
    $im = imagecreatetruecolor(200, 125);
    list($width, $height) = getimagesize($nazwa);

    if ($mime_type === 'image/jpeg'){
        $source = imagecreatefromjpeg($nazwa);
        
        imagecopyresized($im, $source, 0, 0, 0, 0, 200, 125, $width, $height);         

        imagejpeg($im, $nazwa_nowy);

    }

    else{
            $source = imagecreatefrompng($nazwa);
                  
            imagecopyresized($im, $source, 0, 0, 0, 0, 200, 125, $width, $height);         
        
            imagepng($im, $nazwa_nowy);
    }

}