<!DOCTYPE html>
<html>
<head>
	<title></title>
</head>
<body>

<?php
include 'function.php';
?>

<hr><br>
<form action="function.php" method="POST">
	<input type="text" name="message">
	<input type="submit" value="send">
</form>

</body>
</html>


================================================================= function.php
<?php

class GuestBook
{
	protected $file;

	public function __construct ()
	{
		$dir = __DIR__ . '/db.txt';
		$this->file = file($dir);
	}

	public function getData () 
	{
    	foreach ($this->file as $line) {
    		echo $line . '<br>';  
        }	
	}

	public function append ($text) 
	{
		$this->text = $_POST['message'];
		if ($_POST['message'] == true) {
	        $this->file[] .= "\n" . $_POST['message'];
	        file_put_contents('db.txt', $this->file);
	        	header("Location: index.php");
        		exit;	
	     	return $this->file;
	    }
	}
}

$book = new GuestBook();
$book->append($text);
$book->getData();