$servername = "unseentargaryen.ddns.net";
$username = "root";
$password = "Arrow990";
$dbname   ="Lista";

$conn = mysqli_connect($servername,$username,$password,$dbname);

if ($conn->connect_error) {
    die("Connessione fallita: " . $conn->connect_error);
	} else{
	  //echo("Connessione riuscita!");
	}
?>