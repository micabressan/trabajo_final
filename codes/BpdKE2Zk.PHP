<!DOCTYPE html>
<html>
	<head>
		<title>Muestrario</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<link href="estilos.css" rel="stylesheet" type="text/css">
	</head>
	<body>
<?php
    if(isset($_GET["producto"]) && isset($_GET["precio"]) && isset($_GET["imagen"])){ // Seteo las variables recibidas por GET...
            //Inicializo las variable recibidas...
            $producto = $_GET["producto"];
            $precio = $_GET["precio"];
            $imagen = $_GET["imagen"];
?>
		<div class="est_13"><p class="est_16">Muebles OMEGA</p></div>
		<div class="est_10">
			Los mejores precios del mercado y las mejores ofertas. Con productos traidos de f&aacute;brica, con la mejor calidad, dise&ntilde;o y variados colores.
		</div>
		<div class="Marco">
			<div class="est_6">Producto: <?php echo $producto;?></div>
			<img id="" src="<?php echo $imagen;?>" alt="" />
			<div class="est_18">Precio: <?php echo $precio;?></div> 
			<div class="est_6">
				<a href="index.html"> Volver </a>
			</div>
		</div>
		<div class="est_1">
			Domicilio 1234 - Ciudad - Provincia - tel. (0000) 1234567 - www.muebleria.com.ar
		</div>
<?php
    }else{
?>
		<div class="est_13">
			<p class="est_16">Muebles OMEGA</p>
		</div>
		<div class="est_10">
			Los mejores precios del mercado y las mejores ofertas.
			Con productos traidos de f&aacute;brica, con la mejor calidad, dise&ntilde;o y variados colores.
		</div>
		<div class="Marco">
			<div class="est_6">Producto:</div>
			<div class="est_6">
				<a href="index.html"> Volver </a>
			</div>
		</div>
		<div class="est_1">
			Domicilio 1234 - Ciudad - Provincia - tel. (0000) 1234567 - www.muebleria.com.ar
		</div>
<?php
	}
?>
	</body>
</html>