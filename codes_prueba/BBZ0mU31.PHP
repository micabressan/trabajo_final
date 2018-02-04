public static function img_upload($width = 500, $height = 500)
    {
        //Userordner vorhanden?
        $userPath = "uploads/".$user_id;

        if(is_dir($userPath) == false)
        {
            if(!mkdir($userPath, 0755, true))
            {
                return array('message' => "Unbekannter Fehler. Kontaktieren Sie uns bitte oder versuchen es später noch einmal.",'bool' => false);
            }
        }

        //Bild speichern
        $name = str_replace(' ','',$name);
        $path = "$userPath/$name";

        if(!move_uploaded_file($_FILES['picture']['tmp_name'], "$path"))
        {
            echo "Could not upload the File to ".$path;
        }

        //Bildtyp extrahieren
        $type = exif_imagetype($path);
        //Array für die switch Anweisungen (1 = .gif, 2 = .jpg, 3 = .png)
        $allowedTypes = array(1,2,3);

        if(!in_array($type,$allowedTypes))
        {
            return array('message' => "Dateityp kann nicht verarbeitet werden. (Nur .png, .jpg, und .gif)", 'bool' => false);
        }

        switch($type)
        {
            //gif
            case 1:
                //Größe des .gif Bilds anpassen, falls höher oder breiter als 150px
                if ($size[0]>500 && $size[1]>500)
                {
                    $size = getimagesize("$path");

                    $src_img = imagecreatefromgif("$path");

                    $new_img = imagecreatetruecolor(500,500);
                    imagecopyresampled($new_img, $src_img, 0, 0, 0, 0, 500, 500, $size[0], $size[1]);
                    imagegif($new_img, "$path");

                    imagedestroy($src_img);
                    $edit = true;
                }
                break;
            //jpg
            case 2:
                //Größe des .jpg Bilds anpassen, falls höher oder breiter als 150px
                $size = getimagesize("$path");
                if ($size[0]>500 && $size[1]>500)
                {
                    $src_img = imagecreatefromjpeg("$path");

                    $new_img = imagecreatetruecolor(500,500);
                    imagecopyresampled($new_img, $src_img, 0, 0, 0, 0, 500, 500, $size[0], $size[1]);
                    imagejpeg($new_img, "$path");

                    imagedestroy($src_img);
                }
                break;

            //png
            case 3:
                //Größe des .gif Bilds anpassen, falls höher oder breiter als 150px
                $size = getimagesize("$path");
                if ($size[0]>500 && $size[1]>500)
                {
                    $src_img = imagecreatefrompng("$path");

                    $new_img = imagecreatetruecolor(500,500);
                    imagecopyresampled($new_img, $src_img, 0, 0, 0, 0, 500, 500, $size[0], $size[1]);
                    imagepng($new_img, "$path");

                    imagedestroy($src_img);
                }
                break;
        }
    }