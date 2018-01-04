<?php
/**
 * Created by PhpStorm.
 * User: banksy
 * Date: 12/16/2017
 * Time: 3:25 PM
 *
 */
$nbre = 1;
while ($nbre <= 10) {
    echo("hh" . "<br>");
    $nbre++;
}

$coordonnees = array(
    'prenom' => 'banksy',
    'nom' => 'meme',
    'adresse' => '3 Rue du maymays',
    'ville' => 'Swing xd');

foreach ($coordonnees as $cle => $element) {
    echo '[' . $cle . '] vaut ' . $element . '<br />';
}
?>
<?php
$phrase = 'L\'hrba a sat xd' . "<br>";
$longueur = strlen($phrase);
echo $longueur;


$jour = date('d');
$mois = date('m');
$annee = date('Y');

$heure = date('H');
$minute = date('i');

echo 'Bonjour ! Nous sommes le ' . $jour . '/' . $mois . '/' . $annee . 'et il est ' . $heure . ' h ' . $minute . "\"<br>\"";

function DireBonjour($nom)
{
    echo 'Bonjour ' . $nom . "<br>";
}

DireBonjour('banksyyy');
DireBonjour('Rezox');
DireBonjour('Fatal');

?>
<?php
function CalculCone($rayon, $Hauteur)
{
    $calcul = $rayon ** 2 * 3.14 * $Hauteur * (1 / 3);
    echo $calcul;
}

CalculCone(3, 7);
CalculCone(5, 8);
?>