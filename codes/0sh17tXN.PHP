<!DOCTYPE>

  <?php
  
 
  session_start();
  include('functions/functions.php');
  include('includes/db.php');

	$DBConn = setDBConn();
                $ip = getIp();
 
                $cartData = getCart($DBConn, $ip);
                $totalPrice = $cartData['total_price'] . "&euro;";
                $totalItems = $cartData['total_items'];
                $cartMarkup = $cartData['cart_markup'];



       


?>

<html>
	<head>
		<title>ANIKI - Animu&Mangu merchandise</title>

	<link rel="stylesheet" href="styles/style3.css" media="all">

	</head>

<body>
	<!--Main containter starts here-->
	<div class="main_wrapper">

			<!-- Header starts here -->
			<div class="header_wrapper">

				<a href="index.php"><img id="image1" src="images/aniki_titulo3.png"></a>


			</div>
			<!-- Header ends here -->

			<!-- Navigation Bar starts here -->
			<div class="menubar">

				<ul id="menu">
					<li><a href="index.php">Home</a></li>
					<li><a href="all_products.php">Products</a></li>
					<li><a href="customer/my_account.php">My Account</a></li>
					<li><a href="#">Sign up</a></li>
					<li><a href="cart.php">Shopping Cart</a></li>
					<li><a href="#">Contact us</a></li>
				</ul>

				<div id="form">
					<form method="get" action="results.php" enctype="multipart/form-data">
						<input type="text" name="user_query" placeholder="Search a product">
						<input type="submit" name="search" value="Search">
					</form>
				</div>


				<!-- Navigation Bar ends here -->
			</div>


			<!-- Content wrapper starts here -->
			<div class="content_wrapper">
				
				<div id="sidebar">
            <div id="sidebar_title">Categories</div>

            <ul id="cats">

		<?php getCats($DBConn);
		
  		?>	

            </ul>


        <div id="sidebar_title">Manufacturers</div>

            <ul id="cats">

               <?php getManu($DBConn);
               ?>
               
            </ul>



      </div>
					
				<div id="sidebar2">This is the second side bar</div>
				

        <div id="content_area">
			
			<?php getCart($DBConn, $ip);
			?>
				
				<div id="shopping_cart">
				
				<span id="cart">
					
					<?php
					if(isset($_SESSION['customer_email'])){
					echo "<b>Welcome:</b>" . $_SESSION['customer_email'] . "<b style='color:gray;'>Your</b>";
					}
					else{
					echo "<b>Welcome Guest</b>";
					
					}
					
					
					?>
					
					
				
				
				<b style="color:gray">Shopping Cart - </b> Total Items: <?php echo $totalItems; ?> - Total Price: <?php echo $totalPrice ?> <a href="cart.php">Go to Cart</a>
				
				<?php
				
				if(!isset($_SESSION['customer_email'])){
					
					echo "<a href='checkout.php'>Login</a>";
					
				}
				else{
					
					echo "<a href='logout.php' style='color:white'>Logout</a>";
				}
				
				?>
				
				
				
				</span>
				
				</div>
			
			
			<div id="products_box">
			<?php getPro($DBConn);
			?>
			<?php getCatPro($DBConn);
			?>
			<?php getManuPro($DBConn);
			?>
			</div>
			
        </div>
        
      
				<!-- Content wrapper ends here -->


			<div id="footer">
			
			<h2 id="hh">&copy; 2015 Aniki - From bros to bros</h2>
			
			</div>
	</div>

</div>
	<!--Main containter ends here-->





</body>
</html>