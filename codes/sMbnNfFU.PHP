public static function removeExif($filename) {
		if(in_array(self::getExtension($filename), array("jpeg, jpg"))){
			$img = imagecreatefromjpeg($filename);
			imagejpeg($img, $filename, 85);
    	}
	}

public static function getExtension($name) {
		return strtolower(pathinfo($name, PATHINFO_EXTENSION));
	}