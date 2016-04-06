<?php include('online.php'); ?>
    <!-- META information -->

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="description" content="">


    <!-- CSS -->

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

    <link rel="stylesheet" href="css/style.css" type="text/css">

    

    <!-- Icon -->

    <link rel="shortcut icon" type="image/x-icon" href="favicon.ico">



    <!-- Fonts -->

    <link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" type="text/css">

    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" type="text/css">

    <link href="http://fonts.googleapis.com/css?family=Raleway:800" rel="stylesheet" type="text/css">



    <!-- add to the <head> of your page -->

    <link rel="stylesheet" type="text/css" href="engine0/style.css">

    <script type="text/javascript" src="engine0/jquery.js"></script>    <script src="https://www.youtube.com/iframe_api"></script>

        <!-- Navigation -->
    <div class="nav-content">
        <nav class="navbar navbar-static-top" role="navigation">
            <div class="container">

                <!-- Icon -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Barre de Navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>

                <!-- Liens -->
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav navbar-center">
                        <li><a href="http://cakefamily.esy.es/">Accueil</a></li>
                        <li><a href="http://cakefamily.esy.es/#nous">Nous !</a></li>
                        <li><a href="http://cakefamily.esy.es/#team">La team</a></li>
                        <li><a href="http://cakefamily.esy.es/#parcour">Notre parcours</a></li>
                        <li><a href="http://cakefamily.esy.es/#facebook">Facebook</a></li>
                        <li><a href="http://cakefamily.esy.es/#youtube">YouTube</a></li>
                        <li><a href="http://cakefamily.esy.es/radio.phpo">Radio</a></li>
						<li><a href="http://cakefamily.esy.es/connexion.php">Connexion</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    </div>


<?php

$bdd = new PDO('', '', '');

if (isset($_POST['forminscription']))
{
	$pseudo = htmlspecialchars($_POST['pseudo']);
	$mail = htmlspecialchars($_POST['mail']);
	$mail2 = htmlspecialchars($_POST['mail2']);
	$mdp = sha1($_POST['mdp']);
	$mdp2 = sha1($_POST['mdp2']);

	if(!empty($_POST['pseudo']) AND !empty($_POST['mail']) AND !empty($_POST['mail2']) AND !empty($_POST['mdp']) AND !empty($_POST['mdp2']))
	{
		$pseudolength = strlen($pseudo);
		if($pseudolength <= 255)
		{
				if($mail == $mail2)
				{
					if(filter_var($mail, FILTER_VALIDATE_EMAIL))
					{
						$repseudo = $bdd->prepare('SELECT * FROM membres WHERE id = ?');
						$repseudo->execute(array($pseudo));
						$pseudoexist = $repseudo->rowCount();
						if($pseudoexist == 0)
						{
							$reqmail = $bdd->prepare('SELECT * FROM membres WHERE mail = ?');
							$reqmail->execute(array($mail));
							$mailexist = $reqmail->rowCount();
							if($mailexist == 0)
							{
								if($mdp == $mdp2)
                                {
                                    $insertmbr = $bdd->prepare("INSERT INTO membres (pseudo, mail, motdepasse) VALUES(?, ?, ?)");
                                    $insertmbr->execute(array($pseudo, $mail, $mdp));
                                    $verifmail = "Votre compte à bien était créé !"
								}
								else
								{
									$erreur = "Les mots de passe ne correspondent pas !";
								}
							}
							else
							{
								$erreur = "Adresse mail déjà utilisée !";
							}
						}
						else
						{
							$erreur = "Pseudo déjà pris !";
						}

					}   
					else
					{
						$erreur = "L'adresse mail n'est pas valide !";
					}	
				}
				else
				{
					$erreur = "Vos adresse mail ne correspondent pas !";
				}
		}
		else
		{
			$erreur = "Votre pseudo ne doit pas dépasser 255 caractères !";
		}
	}
	else
	{
		$erreur = "Tous les champs doivent être complétés !";
	}
}

?>
<html>
    <head>
    	<title>Inscription</title>
    	<meta charset="utf-8">
    </head>
    <body>
    	<div align="center">
            <br><center><div style="z-index:0; height: 450px; width: 1000px; border-radius: 10px 10px 10px 10px; background-color:rgba(255, 255, 255, 0.7)">
    		<center><br><br></br></br><h5>Inscription</h5></center>
    		<br /><br /><br />
    		<form method="POST" action="
    		">
    		    <table align="center">
    		    	<tr>
    		    	    <td align="center"
    		                <label for="pseudo">Pseudo: </label>
    		            </td>
    		            <td>
    		                <input type="text" 
    		                placeholder="Votre Pseudo" id="pseudo" name="pseudo" value="<?php if(isset($pseudo)) { echo $pseudo; } ?>" />
    		            </td>
    		        </tr>
    		    	<tr>
    		    	    <td align="center">
    		                <label for="mail">Mail: </label>
    		            </td>
    		            <td>
    		                <input type="email" 
    		                placeholder="Votre Mail" id="mail" name="mail" value="<?php if(isset($mail)) { echo $mail; } ?>" />
    		            </td>
    		        </tr>
    		    	<tr>
    		    	    <td align="center">
    		                <label for="mail2">Confirmation du Mail: </label>
    		            </td>
    		            <td>
    		                <input type="email" 
    		                placeholder="Confirmer votre mail" id="mail2" name="mail2" />
    		            </td>
    		        </tr>
    		    	<tr>
    		    	    <td align="center">
    		                <label for="mdp">Mot de Passe: </label>
    		            </td>
    		            <td>
    		                <input type="password" 
    		                placeholder="Votre mot de passe" id="mdp" name="mdp" />
    		            </td>
    		        </tr>
    		    	<tr>
    		    	    <td align="center">
    		                <label for="mdp2">Confirmation du Mot de Passe: </label>
    		            </td>
    		            <td>
    		                <input type="password" 
    		                placeholder="Confirmer votre MDP" id="mdp2" name="mdp2" />
    		            </td>
    		        </tr>
                    </table>
    		            <td></td>
    		        <td align="center">
    		                <input type="submit" name="forminscription" value="Je m'inscris" />
    		            </td>
    		        </tr>
    		<?php
    		if(isset($erreur))
    		{
    			echo '<font color="red">' .$erreur."</font>";
    		}
    		?>
            <?php
            if(isset($verifmail))
            {
                echo '<font color="green">' .$verifmail."</font>";
            }
            ?> 
    		</form> 
    	</div>
    </body><br><br></br></br>
         <!-- Bottom section -->
    <section class="bottom dark">
        <div class="container">
            <div class="bottom-content">
                <span class="ip">CF</span>
                <span class="server-name">CakeFamily</span>
                <span class="italic">Nombre de visiteur: <?php echo $user_nbr; ?></span>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="dark">
        <div class="container">
            <span class="copyright">Design par<a href="http://www.ivizadesigns.com"> Iviza</a> et retouché par<a href="http://youtube.com/c/Khaelo"> Khaelo</a></span>
            <ul>
                <li><a href="#acceuil">Accueil</a></li>
                <li><a href="#nous">Nous !</a></li>
                <li><a href="#team">La team</a></li>
                <li><a href="#parcour">Notre parcours</a></li>
                <li><a href="#facebook">Facebook</a></li>
                <li><a href="#youtube">YouTube</a></li>
                <li><a href="http://cakefamily.esy.es/radio.php#radio">Radio</a></li>
            </ul>
        </div>
    </footer>
    <!-- jQuery Version 1.10.2 -->
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>

    <!-- Custom JavaScript -->
    <script src="js/main.js"></script> 
</body>
</html>