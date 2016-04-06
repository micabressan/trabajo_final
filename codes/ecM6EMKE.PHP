esse código vai na primeira pagina (primeirapagina.php)
é um form normal, nada d+

<form method="post" action="segundapagina.php">
	Seu nome: <input type="text" name="nome" /><br/>
	Seu e-mail: <input type="email" name="email" /><br/>
	<input type="submit" value="vai" />
</form>


Esse código vai na segunda pagina

Ele pega todos os dados do formulário anterior e joga em input hidden

<form method="paginafinal.php">
	<?php
		foreach($_POST as $key=>$value) {
			?>
			<input type="hidden" name="<?php echo $key; ?>" value="<?php echo htmlentities($value); ?>" />
			<?php
		}
	?>
	<!-- agora outros campos deste segundo form -->
	Seu endereço: <input type="text" name="endereco" /><br/>
	Bla: <input type="text" name="bla" /><br/>
	<input type="submit" value="pronto" />
</form>

esse código vai na terceira pagina
se rodar tudo isso, essa pagina vai ter os dados das 2 paginas anteriores.
<?php
print_r($_POST);