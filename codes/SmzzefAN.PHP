/*
 * Question: https://pt.stackoverflow.com/questions/263587/encurtando-nome-de-pessoas
 **/

// Palavras que serão removidas
$preps = ["da", "do", "dos", "de"];

// Nome do cadastrado
$name = "Fernando José Silva Machado";

// Separa as palavras e adiciona em um array
$nameArr = explode(" ", $name);

// Percorre o array do elemento 1, até o elemento n-1
// Dessa forma poderemos teremos certeza que iremos
// alterar os nomes corretos
for($i = 1; $i < count($nameArr)-1; $i++) {
  
  // Verifica se é um prep. Caso seja, remove a palavra.
  if (in_array($nameArr[$i], $preps)) {
      unset($nameArr[$i]);
      continue;
  }
  
  // Captura apenas o primeiro caractere e adicione o "."
  $nameArr[$i] = substr($nameArr[$i], 0, 1).".";
}

// Imprime o array separando por " " (espaço)
echo implode(" ", $nameArr);