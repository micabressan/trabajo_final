SELECT * FROM cadastros WHERE CPF='$cpf';
	
SELECT * FROM cadastros WHERE NOME LIKE '%$nome%' LIMIT 100;

SELECT * FROM cadastros WHERE NOME LIKE '%$nome%' AND NASCIMENTO='$nascimento' LIMIT 100;

SELECT * FROM cadastros WHERE NOME LIKE '%$nome%' AND NASCIMENTO='$nascimento' AND MAE LIKE '%$mae%' LIMIT 100;

SELECT * FROM cadastros WHERE NOME LIKE '%$nome%' AND NASCIMENTO='$nascimento' AND MAE LIKE '%$mae%' AND MUNICIPIO LIKE '%$municipio%' LIMIT 100;

SELECT * FROM cadastros WHERE NOME LIKE '%$nome%' AND NASCIMENTO='$nascimento' AND MAE LIKE '%$mae%' AND MUNICIPIO LIKE '%$municipio%' AND UF='$uf' LIMIT 100;