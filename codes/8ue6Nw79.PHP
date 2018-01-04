// step_1.php
<form action="step_2.php" method="post">
  <input type="text" name="login" />
  <input type="submit" value="Next" />
</form>

// step_2.php
<?php
  $link = mysqli_connect($nameSERVER, $nameUSER, $passUSER, $nameDB) or die("Ошибка: " . mysqli_error($link));
  $login = $_POST["login"];
  $query = "INSERT INTO users (login) VALUES ('$login')";
  $result = mysqli_query($link, $query) or die(mysqli_error($link)); 
  $record_id = mysqli_insert_id($link);
?>
<form action="step_3.php" method="post">
  <input type="text" name="name" />
  <input type="hidden" name="record_id" value="<?php echo $record_id; ?>" />
  <input type="submit" value="Next" />
</form>

// step_3.php
<?php
  $link = mysqli_connect($nameSERVER, $nameUSER, $passUSER, $nameDB) or die("Ошибка: " . mysqli_error($link));
  $name = $_POST["name"];
  $record_id = $_POST["record_id"];
  $query = "UPDATE users SET name = '$name' WHERE id = '$record_id'"; 
  $result = mysqli_query($link, $query) or die(mysqli_error($link)); 
?>
<form action="step_3.php" method="post">
  <input type="text" name="name" />
  <input type="hidden" name="record_id" value="<?php echo $record_id; ?>" />
  <input type="submit" value="Next" />
</form>