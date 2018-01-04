<!DOCTYPE html>
<html>
  <head>
    <title>Insert Enemy</title>
  <body>
    <?=
      //declare enemy name and city to the entered values
      $enemyName = $_POST['enemyName'];
      $enemyCity = $_POST['enemyCity'];

      //if not enemy and not faction, then error
      if (!$enemy || !$enemyCity)
      {
        echo "Something went wrong, please try again.";
        die;
      }

      //connect to our DB
      $dbServerName = "databases-000webhost.com"; //change to website URL
      $dbUsername = "id3562886_test"; //change to website database username
      $dbPassword = "testing"; //change to website database password
      $dbName = "id3562886_enemylist"; //database name, may need to change

      $db = mysqli_connect($dbServerName, $dbUsername, $dbPassword, $dbName);

      //if not connected to DB, then error
      if (!$db)
      {
        echo "Error connecting to database. Please try again";
        die;
      }

      //Select the DB
      mysqli_select_db("id3562886_enemylist");

      //Prepare to query
      $query = "insert into enemies values ('".NULL."', '".$enemyName."', '".enemyCity."')";

      //Run query
      $result = mysqli_query($query);

      //Confirm add
      if ($result)
        echo mysql_affected_rows()." '".$enemyName."' "added to Database.";
    ?>
  </body>
  </html>