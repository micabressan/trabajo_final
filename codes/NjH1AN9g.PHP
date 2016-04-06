include_once 'databaseConnect.php';

  $bericht = '';

  if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $errors = array();

    if(empty($_POST['naam'])){
      $errors[] = 'Gelieve een naam in te vullen.';
    }

    if(empty($_POST['titel'])){
      $errors[] = 'Gelieve een titel in te vullen.';
    }
    if(empty($_POST['bericht'])){
      $errors[] = 'Gelieve een bericht in te vullen.';
    }
    if(empty($_POST['email']) || !filter_var($_POST['email'],FILTER_VALIDATE_EMAIL)){
      $errors[] = 'Gelieve een geldig email adres in te vullen. ';
    }

    if(empty($errors)){
      $stmt = $mysqli->prepare('INSERT INTO Berichten (naam,email,titel,bericht,datum) VALUES (?,?,?,?, '.  time() . ')');
      $stmt->bind_param('ssss',$_POST['naam'],$_POST['email'],$_POST['titel'],$_POST['bericht']);
      $stmt->execute();
      $bericht = 'Verzonden';

    }else{
      $bericht = implode('<br/>', $errors);
    }

  }