<!DOCTYPE html>
<html lang="pl">
<head>
   <meta charset="UTF-8">
   <title>MARCIN WIELGOS</title>
   
   <link rel="stylesheet" href="CSS/MARCIN_WIELGOS.CSS">
   
   <script src="JS/MARCIN_WIELGOS.JS"></script>
   
</head>
<body onload="date()">
   <div class="container">
      <header class="header-main">
         <span>Pizzeria u Marcina - najlepsza pizza w mieście!</span>
      </header>
      
      <div class="main">
         <?php 

            $server = 'localhost';
            $user = 'root';
            $pass = '';
            $db = 'restaurant';

            $c = mysqli_connect($server, $user, $pass, $db);

            $query = 'SELECT * from pizzas;';
        
            $result = mysqli_query($c, $query);

            while ($row = mysqli_fetch_row($result)) {
               $a = $row[0] +1;
               echo '<div id='."$row[0]".'><div class="left"><img src="GRAFIKA/'."$row[0]".'.jpg"></div>';
               echo "<h1>$row[0]. $row[1]</h1> <p>$row[2]</p> <h3>$row[3]<h3>";
               echo '<div class="navi">';
               echo '<a href='."#$a".'>';
               echo 'Następny';
               echo '</a>';
               echo '</div>';
               echo '</div>';
            }

            mysqli_close($c);

         ?>
         </div>
         
      <footer class="footer-main">
         <div id="date"></div>
      </footer>
   </div>
</body>
</html>