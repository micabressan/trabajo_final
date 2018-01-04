<?php

	session_start();
	ob_start();
	error_reporting(E_ALL);
	
	// jezxeli nie jest zalogowany do wysylamy do ekranu logowania!!!
	if((!isset($_SESSION['zalogowany'])))
	{
		header('Location: logowanie.php');
		exit();
	}
	
	/*if(!(isset($_POST['file_name']))
	{
		header('Location: add.php');
		exit();
	}
	*/
	
	$all_OK = true; // flaga do sprawdzania warunkow

	// Zmienne $_FILES
	$folder_upload = "./mems/".$_SESSION['login'];
	$plik_nazwa = $_FILES['file_name']['name'];
	$plik_lokalizacja = $_FILES['file_name']['tmp_name'];	// tymczasowa lokalizacja
	$plik_mime = $_FILES['file_name']['type'];
	$plik_rozmiar = $_FILES['file_name']['size'];
	$plik_blad = $_FILES['file_name']['error'];
	$plik_title = $_POST['title'];
	$domena = "http://pastopedia.pl/mems/";

	// sprawdzenie czy plik został wysłany
	if(!($plik_lokalizacja))
	{
		$all_OK = false;
		exit('Nie wysłano żadnego pliku');
	}

	// sprawdzenie błędów
	switch($plik_blad)
	{
		case UPLOAD_ERR_OK:
		{
			break;
		}

		case UPLOAD_ERR_NO_FILE:
		{
			$all_OK = false;
			exit('Brak pliku');
			break;
		}

		case UPLOAD_ERR_INI_SIZE:
		case UPLOAD_ERR_FORM_SIZE:
		{
			$all_OK = false;
			exit('Przekroczony rozmiar maaksymalny pliku');
			break;
		}

		default:
		{
			$all_OK = false;
			exit('Nieznany błąd');
			break;
		}
	}


	// sprawdzenie rozszerzenia plikow
	$dozwolone_rozszerzenia = array("jpeg", "jpg", "png", "tiff", "tif", "gif");
	$plik_rozszerzenie = pathinfo(strtolower($plik_nazwa), PATHINFO_EXTENSION);

	if(!in_array($plik_rozszerzenie, $dozwolone_rozszerzenia, true))
	{
		$all_OK = false;
		exit("Niedozwolone rozszerzenie pliku");
	}

	// przeniesienie pliku z lokalizacji tymczasowej do własciwej
	if(!(move_uploaded_file($plik_lokalizacja, $folder_upload."/".$plik_nazwa)))
	{
		$all_OK = false;
		exit('Nie udało się przeniesc pliku');
	}

	// brak błędow
	if($all_OK == true)
	{
		echo("Plik został zapisany");
	}
	require_once "db_connect.php";
	
	mysqli_report(MYSQLI_REPORT_ALL);
	
	try
	{
		
		$connect = new mysqli($db_host, $db_user, $db_password, $db_name);
		
		if($connect->connect_errno != 0)
		{
			throw new Exception(mysqli_connect_errno());
		}
		else
		{
			$user_id = $_SESSION['id'];
			
			if($all_OK == true)
			{
				$sciezka = $domena.$_SESSION['login']."/";
				$actual_date = date('Y:m:d'); 
				$actual_hour = date('H:i:s'); 
				$full_link = $sciezka.$plik_nazwa;
				// wstawienie rekordu do tabeli mems
				if($connect->query("INSERT INTO mems VALUES(NULL,  '$user_id', '$plik_nazwa', '$plik_title', 0, 0, '$full_link', '$actual_date', '$actual_hour')"))
				{	
					
					echo "Zdjecie zapisane do bazy danych";
				}
				else
				{
					echo "Błąd zapytania";
					throw new Exception($connect->error);
				}
			}
			$connect->close();
			ob_end_flush();
		}
	}
	
	catch(Exception $e)
	{
		echo '<span style="color:red;">"Błąd serwera. Przepraszamy za niedogodności. Prosimy o rejestracje w innym terminie"
				</span>';
			
		//	echo '<br />Informacja developerska:'.$e;	// przy publikacje ta linijka bedzie komentowana
	}
	
	

?>