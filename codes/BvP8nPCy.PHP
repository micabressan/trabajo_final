$stmt = $mysqli->prepare('INSERT INTO Berichten (naam,email,titel,bericht,datum) VALUES (?,?,?,?, '.  time() . ')');
      $stmt->bind_param('ssss',$_POST['naam'],$_POST['email'],$_POST['titel'],$_POST['bericht']);
      $stmt->execute();