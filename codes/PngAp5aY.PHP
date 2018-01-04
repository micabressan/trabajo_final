<form name="form" action="order.php" method="post">
  <table class="table">
  <thead>
    <tr>
      <th scope="col">Nama Barang</th>
      <th scope="col">Harga</th>
      <th scope="col">Jumlah</th>
    </tr>
  </thead>
    <?php $dataSession = $_SESSION['userku']; 

  $panggil = mysqli_query($mydb, "SELECT * FROM cart2 WHERE user='$dataSession'");
  $i=0;
  while ($hasil = mysqli_fetch_assoc($panggil) ) {

  ?>
  <?php $produk[$i] = $hasil['produk'];

  $i++; ?>
  <tbody> 
    <tr>
        <td><?php echo $hasil['produk']; ?></td>
        <td><?php echo number_format($hasil['harga'],2,",","."); ?></td>
        <td><?php echo $hasil['jumlah']; ?></td>
    </tr>
  <?php $total += $hasil['harga']; } ?>

  <tr>
    <td>Total Harga</td>
    <td><?php echo number_format($total,2,",","."); 
    $hasil = implode(", ", $produk);?></td>
    
    <td>
      <button class="btn btn-primary" type="submit" name="submit"><a href="order.php?total=<?php echo $total;?>" class="btn btn-primary">CHECKOUT</a></button>
    </td>
  </tr>
  <tr>
    <td>
      
    </td>
  </tr>
  </tbody>
</table>
</form>