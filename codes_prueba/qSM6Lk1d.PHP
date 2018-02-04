<?php
if (isset($_GET['page'])) 
{
  $page = $_GET['page'];

  if ($page == 'ajouter') include ('ajouter.php'); 
  elseif ($page == 'afficher') include ('afficher.php');
  
   
    else 
    {
      include ("accueil.php");
    }
} 
    else 
    {
      include ("accueil.php");
    }
?>