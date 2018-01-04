if(!isset($_GET["ingredient"]))	$_GET["ingredient"] = "Aliment";

display($Hierarchie[$_GET["ingredient"]], "super-categorie");
echo "<a href='?l=Ingredients=".$_GET["ingredient"]."'>".$_GET["ingredient"]."</a><br/><br/>";
display($Hierarchie[$_GET["ingredient"]], "sous-categorie");

$conversionApostrophe=array('\'' => '&#39;');

function transformeApostrophe($var) {
	global $conversionApostrophe;
	return strtr($var,$conversionApostrophe);
}
function display($Aliment, $catg) {
	if(isset($Aliment[$catg])) {
		foreach($Aliment[$catg] as $aliment) {
			$aliment=transformeApostrophe($aliment);
			echo "<a href='?l=Ingredients=&ingredient=".$aliment."'>".$aliment."</a><br/>";
		}
	}
	else (if $catg == "super-categorie") echo "<a href='?page=cocktails&ingredient=Aliment'>Aliment</a><br/>";
}