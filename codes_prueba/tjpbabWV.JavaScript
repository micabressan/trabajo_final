var ing = document.getElementById("ingrediente").value; 
// Define a variavel ing com o conteúdo (valor) do elemento que tem o ID "ingrediente"


var listahtml = document.getElementById("lista").innerHTML;
// Define a variavel listahtml com o conteúdo (conteúdo interno - innerHTML, ou seja, tudo que esta dentro da div) do elemento com ID = "lista"

listahtml = listahtml +"<li>"+ing+"<li>"; 
// Adiciona a variavel listahtml um elemento <li> com o valor de ing que pegamos na primeira linha.


document.getElementById("lista").innerHTML= listahtml; 
// Substitui o valor do conteúdo do elemento com ID="lista" pelo valor da variavel listahtml (que agora tem nosso <li> com o novo ingrediente)