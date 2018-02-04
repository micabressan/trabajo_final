	if (isset($_POST["register"])) {
		// Si tous les champs ne sont pas vide
		if(not_empty(["name","pseudo","email","password","password_confirm"])){
			$errors = [];
			extract($_POST);

			if (mb_strlen($pseudo) < 3) {
				$errors[] = "Pseudo trop court (minimum 03 caractères)";
			}
			if(!filter_var($email, FILTER_VALIDATE_EMAIL)){
				$errors[] = "Adresse email invalide";
			}
			if (mb_strlen($password) < 6) {
				$errors[] = "Email trop court (minimum 06 caractères)";
			}else {
				if($password != $password_confirm){
					$errors[] = "Les mots de passe ne concordent pas";
				}
			}
			if(is_already_in_use("pseudo",$pseudo,"users")){
				$errors[] = "Pseudo déjà utilisé";
			}
			if(is_already_in_use("email",$email,"users")){
				$errors[] = "Adresse E-mail déjà utilisée";
			}
			if(count($errors) == 0){
				$to = $email;
				$subject = WEBSITE_NAME." - ACTIVATION DE COMPTE";
				$password = password_hash($password, PASSWORD_DEFAULT);
				$token = sha1($pseudo.$email.$password);
				ob_start();
				require 'templates/email/activation.tmpl.php';
				$content = ob_get_clean();

				//mail($to, $subject, $content);
				$q = $db->prepare("INSERT INTO users(name,pseudo,email,password) VALUES (:name,:pseudo,:email,:password)");
				$q->execute([
					'name' => $name,
					'pseudo' => $pseudo,
					'email' => $email,
					'password' => $password
				]);


				set_flash("mail d'activation envoyé","success");
				redirect("index.php");
			}else {
				save_input_data();
			}
		}else {
			$errors[] = "veuillez SVP remplir tous les champs";
			save_input_data();
		}
	}else {
		clear_input_data();
	}