<?php
session_start();
require"view/header.php";
error_reporting(0);
if (!isset($_SESSION['nis'])) header("location: ../index.php");
$nis = $_SESSION['nis'];

$ceknama= mysql_fetch_array(mysql_query("SELECT * FROM tbl_user WHERE nis='$nis'")) or die (mysql_error());
?>
<div class="col-lg-9">
	<p class="bg-primary">Laporan Nilai <?php echo"$ceknama[nama]";?></p>
	<div class="panel panel-info">
		<div class="panel-body">
			<table><tr><td><img src="../assets/images/z.png"  width="50px" 
				<fieldset>
					<label>Nis</label>: <?php echo"$ceknama[nis]";?><br>
					<label>Nama</label>: <?php echo"$ceknama[Nama]";?><br>
					</fieldset>
					</table>
					<fieldset>
						<table class="table table-responsive">
							<tr>
								<th>No</th><th>BAB</th><th>Nilai</th>
							</tr>
					<?php
						$i=1;
						$data = mysql_query("SELECT j.id_judul,j.judul_materi,n.nis,n.id_judul,n.validasi, n.nilai as nilai from tbl_nilai n, tbl_judul_materi j WHERE n.nis='$nis' AND j.id_judul=n.id_judul") or die (mysql_error());
						$totalnilai=mysql_fetch_array(mysql_query("SELECT SUM(nilai) AS total FROM tbl_nilai WHERE nis='$nis'"));
						$count=mysql_num_rows($data);
						$total1= $totalnilai['total']/$count;
						if ($total1>=80){
							$grade='A';
							$keterangan='Memuaskan';
						
						}else if ($total1>=70){
							$grade='B';
							$keterangan='Cukup';
						
						}else if ($total1>=60){
							$grade='C';
							$keterangan='Anda Harus Mengulang';
						
						}else if ($total1>=50){
							$grade='D';
							$keterangan='Anda Harus Mengulang';
						
						}else{
							$grade='E';
							$keterangan='Anda Harus Mengulang';

						}
						while ($r=mysql_fetch_array($data)){
						echo"	
							<tr>
								<td>$i</td><td>$r[judul_materi]</td><td>$r[nilai]</td>
							</tr>";
						$i++;
						}
						echo"	
							<tr>
								<td colspan=2 align='center'>Total Nilai</td><td>$totalnilai[total]</td>
							</tr>
							<tr>
								<td colspan=2 align='center'>Rata - rata</td><td>$total1</td>
							</tr>
							<tr>
								<td colspan='2' align='center'>Grade Anda</td>
								<td>$grade ($keterangan)</td>
							</tr>
							
							
							
							";
					?>
					</fieldset>
			</table>
</div>
</div>
</div>

<?php
require"view/sidebarakun.php";
?>
</div>
<?php
require"view/footer.php";
?>