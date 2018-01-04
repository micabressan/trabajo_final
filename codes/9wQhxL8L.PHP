<!DOCTYPE html>
<html>
	<head>
		<title>Enemy List Database</title>
	</head>
	<body>

	<?php
		$dbServerName = "databases.000webhost.com"; //change to website URL
		$dbUsername = "id3562886_test"; //change to website database username
		$dbPassword = "testing"; //change to website database password
		$dbName = "id3562886_enemylist"; //database name, may need to change

		$conn = mysqli_connect($dbServerName, $dbUsername, $dbPassword, $dbName);
		if (!$conn)
		{
			echo "Error: Could not connect to database. Please try again.";
			die;
		}

		mysqli_select_db($dbName);
		//Statements to output entire table data
		$query = "SELECT * FROM enemies;";
		$result = mysqli_query($query);
		$resultCheck = mysqli_num_rows($result);
		echo "<p>Number of Enemies: ".$resultCheck."</p>";
		for ($i=0;i < $resultCheck; $i++) {
			echo "<p>";
			echo $row['enemyID'];
			echo $row['enemyName'];
			echo $row['enemyCity'];
		}
	?>
	</body>
</html>