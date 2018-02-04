<?php
header("Content-type:text/html; charset = utf8");
$link = mysqli_connect("localhost", "root", "", "catalog");

mysqli_query($link,"SET NAMES utf8");

$p = $_GET["p"]?$_GET["p"]:0;

$count = 6;

$result = mysqli_query($link, "SELECT * FROM catalog");

$row = mysqli_fetch_all($result);

$len = floor( count($row) / $count);

$start = $p * $count;

$pagination = mysqli_query($link, "SELECT * FROM catalog ORDER BY id LIMIT $start,$count");

$arr = mysqli_fetch_all($pagination, MYSQLI_ASSOC);

foreach($arr as $v){
    echo "<div class = 'thumbnail'>";
    echo "<p>",$v["id"]," ",$v["name"],"</p>";
    echo "</div>";
}
?>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<div class="container">
<nav>
  <ul class="pagination">
  <?php for($i = 0; $i <= $len; $i++){ ?>
    <li><a href="?p=<?= $i ?>"><?= $i + 1 ?></a></li>
  <?php } ?>
  </ul>
</nav>
</div>

<?php
mysqli_close($link);
?>