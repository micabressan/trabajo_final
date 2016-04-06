<?php
	require_once '../../biblioteca/Simple_sessions.php';
	$obj_ses = new Simple_sessions();
	if($obj_ses->check_sess('userid')):
?>
<?php include_once '../diseno/encabezado.php'; ?>

<div class="col-md-9">
	<div class="caja-actividades">
		<h3>Crear artículos</h3>
		<?php if(isset($_GET['m']) && $_GET['m'] == '1'): ?>
			<div class="mal">¡Error!. Existen datos vacíos...</div>
		<?php elseif(isset($_GET['m']) && $_GET['m'] == '2'): ?>
			<div class="mal">¡Error!. Intenta nuevamente enviar los datos...</div>
		<?php elseif(isset($_GET['m']) && $_GET['m'] == '3'): ?>
			<div class="bien">Registro Exitoso</div>
		<?php endif; ?>
			<p class="sub">Guarda multiples registros, coloque el número y presione empezar</p>
			<form class="multi" action="" post="get">
				<input type="text" name="n" class="ntexto" />
				<input type="submit" name="enviar" value="Empezar" />
			</form>
			
			<?php if(isset($_GET['n']) && !empty($_GET['n'])): ?>
				<form action="../controladores/ArticuloController.php" method="post" enctype="multipart/form-data">
					
					<table>
						<tr class="titulo">
							<td>Nª</td>
							<td>Nombre del artículo</td>
							<td>texto del artículo</td>
							
							<td>Autor</td>
							
							<td>Imagen</td>
						</tr>
						<?php for($i = 1; $i <= $_GET['n']; $i++): ?>
							<tr class="detalle">
								<td><?php echo $i; ?></td>
								<td><input type="text" name="nombre[]"/></td>
								<!-- <td><input type="text" name="texto[]"/></td> -->
								
								<td>
									<textarea name="texto[]" rows="0" cols="0"></textarea>
								</td>
								
								<td><input type="text" name="autor[]"/></td>
								
								<td><input type="file" name="imagen[]"/></td>
							</tr>
						<?php endfor; ?>
						<tr class="boton">
							<td colspan="3">
								<input type="hidden" name="n" value="<?php echo $_GET['n']; ?>" />
								<input type="submit" name="guardar" value="Guardar" />
							</td>
						</tr>
					</table>
					
				</form>
			<?php elseif(!isset($_GET['n']) || (isset($_GET['n']) && $_GET['n']) == '1' || $_GET['n'] == '0'): ?>
			
				<?php if(isset($_GET['id'])): ?>
					<p class="sub" style="color:red;">Edite el artículo<a href="guardar.php" title="Agrega un nuevo artículoa">Agregar un nuevo artículo</a></p>
				<?php else: ?>
					<p class="sub">Cree un artículo</p>
				<?php endif; ?>
				
			<form action="../controladores/ArticuloController.php" method="post" enctype="multipart/form-data">
				<table>
					<tr class="titulo">
						<td>Nº</td>
						<td>Nombre del artículo</td>
						<td>Texto para el artículo</td>
						
						<td>Autor</td>
						
						<td>Imagen</td>
					</tr>
					<tr class="detalle">
						<td>1</td>
						
						<?php
							if(isset($_GET['id'])):
								require_once '../modelos/DAOs/ArticuloDAO.php';
								$obj_articulo = new ArticuloDAO();
								$datas = $obj_articulo->getArticuloId($_GET['id']);
						?>
						
						<td><input type="text" name="nombre" value="<?php echo $datas[0]['nombre'];?>"/></label></td>
						<!-- <td><input type="text" name="texto" value="<?php echo $datas[0]['texto'];?>"/></label></td> -->
						<td>
							<textarea name="texto" rows="0" cols="0"><?php echo $datas[0]['texto'];?></textarea>
						</td>
						
						<td><input type="text" name="autor" value="<?php echo $datas[0]['autor'];?>"/></label></td>
						
						<td><input type="file" name="imagen"/></td>
						
						<td><input type="hidden" name="id" value="<?php echo $datas[0]['id'];?>"/></td>					
					
						<?php else: ?>
							<td><input type="text" name="nombre"/></label></td>
							<!-- <td><input type="text" name="texto"/></label></td> -->
							<td>
								<textarea name="texto" rows="0" cols="0"></textarea>
							</td>
							
							<td><input type="text" name="autor"/></label></td>
							
							<td><input type="file" name="imagen"></td>
							
							<td><input type="hidden" name="id" value=""/></td>
						<?php endif; ?>
					</tr>
					
					<tr class="boton">
						<td colspan="4">
							<input type="hidden" name="n" value=""/>
							<input type="submit" name="guardar" value="Guardar"/>
						</td>
					</tr>				
				</table>
			</form>
		<?php endif; ?>
	</div>
</div>
	
<?php include_once '../diseno/pie.php'; ?>
<?php
	else:
		header('location: logeo.php');
	endif;
?>