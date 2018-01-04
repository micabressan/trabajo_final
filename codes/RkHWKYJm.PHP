<?php
function connect_PDO()
{
    try
    {
        $options = [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION];
        $bdd = new PDO('mysql:host=localhost;dbname=test;charset=utf8', 'root', '', $options);

        return $bdd;
    } 
    catch(Exception $e)
    {
        die('Erreur : '.$e->getMessage());
    }
}

function select_messages($bdd)
{
    $req = $bdd->query('SELECT pseudo, message, id FROM minichat ORDER BY id DESC LIMIT 10');
    return $req->fetch(PDO::FETCH_ASSOC);
}

function add_message($bdd, $_POST)
{
    if(isset($_POST['message']) && isset($_POST['pseudo']) && !empty($_POST['message']) && !empty($_POST['pseudo']))
    {
        $request = $bdd->prepare('INSERT INTO minichat(pseudo, message) VALUES(:pseudo, :message)');
        
        $fields = 
        [
            'pseudo'  => $_POST['pseudo'], 
            'message' => $_POST['message']
        ];

        $req->execute($fields);
    }
}

function delete_message($id)
{
    $request = $bdd->prepare('DELETE FROM minichat WHERE id = :idMessage');
    $request->bindParam(':idMessage', intval($id));

    $request->execute();
}

$bdd = connect_PDO(); //Connexion à la base de données

if(isset($_POST['Send']))
    add_message($bdd, $_POST);

$listMessages = select_messages($bdd); //Récupération des messages
?>
<!-- ------------------------------------------------------------------------ -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <title>MiniCHat 1.0</title>
</head>
<body>
    <h1>Mon MiniChat 1.0</h1>
    <p>Je tient a dire qu'il n'est qu'en phase de developpement et que des bugs sont possibles merci d'etre indulgents !</p>

    <form method="post" action="" id="form-group">
        <!--
        ATTENTION : La balise <center> est obsolète, tu dois positionner tes éléments via CSS
        -->
        <center>
            <input type="text" name="pseudo" id="pseudo" autofocus autocomplete="off" required placeholder="Entrez votre pseudo :">
            <input type="text" name="message" id="message" autocomplete="off" required placeholder="Entrez votre message :">
        </center>
        <input type="submit" name="Send" value="Send">
    </form>

    <?php while($listMessages as $msg): ?>
        <p class="msg"><b><?= $msg['pseudo'] ?></b> : <?= $msg['message'] ?></p>
    <?php endwhile; ?>
</body>
</html>