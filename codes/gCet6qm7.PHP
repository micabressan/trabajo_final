<?php
	if(!empty($_GET['edit'])){
		$cari ="SELECT nip,nama,user,pass,admin FROM login WHERE nip='".$_GET['edit']."'";
		$e = mysql_fetch_array(mysql_query($cari));
	?>
		<form class="form-inline" role="form" action="" method="post">
        <h4>Tambah / Ubah Data User</h4>
    	<table class="table table-border table-striped">
		 <div class="form-group">
     	 <tr>
     		<td width="90px"><label for="user" class="col-md-3 control-label">Username :</label></td>
			<td width="50px"><input type="text" class="form-control" name="username" value="<?php echo $e['user'];?>"/></td>
			<td width="90px"><label for="user" class="col-md-3 control-label">Password :</label></td>
			<td width="50px"><input type="text" class="form-control" name="password" value="<?php echo $e['pass'];?>"/></td>
            <td width="150px"><label for="user" class="col-md-3 control-label">Atur sebagai Admin:</label></td>
            <td width="50px"><input type="checkbox" class="form-control" name="admin" onSelect="" value="<?php echo $e['admin']; ?>"></td>
			<td><input type="submit" class="btn btn-danger" name="ubah" value="Edit Data"/></td>
		</tr>
		</div>
        </table>
        </form>