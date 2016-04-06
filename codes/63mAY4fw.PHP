<?php
session_start();
$_SESSION['sname'] = $_POST["name"];
$_SESSION['sybr'] = $_POST["ybr"];
$_SESSION['semail'] = $_POST["email"];
$_SESSION['sach']= $_POST["ach"];
?>
<!DOCTYPE html >

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="css/jj.css" rel="stylesheet" /
<title></title>
</head>
<body background="../../Users/Nigam/Documents/Unnamed Site 1/1.jpg">
 
<?php 
$nameErr = "";
$ybrErr  = "";
$emailErr = "";
$achErr = "";
$flag = 0;

//print_r($_SESSION);



		
if($_SERVER["REQUEST_METHOD"]=="POST")
{ if(empty($_SESSION['sname']))
	{
	$nameErr="Enter full name"; $flag=1; 
	}
	else{
		 $name = test_input($_SESSION['sname']);
         if (!preg_match("/^[a-zA-Z ]*$/",$name)) {
       $nameErr = "Only letters and white space allowed"; $flag=1;
     }
   }
if (empty($_SESSION['semail'])) {
     $emailErr = "Email is required";	$flag=1;
   } else {
     $email = test_input($_SESSION['semail']); 
     
     if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
       $emailErr = "Invalid email format"; $flag=1; 
     }
   }
   
   if (empty($_SESSION['sybr'])) {
     $ybrErr = "Year Branch is required";
   } else {
     $email = test_input($_SESSION['sybr']);
     
    
       $ybrErr = "Correct format Eg: SE(IT)";
     }
}
	function test_input($data) {
   $data = trim($data);
   $data = stripslashes($data);
   $data = htmlspecialchars($data);
   return $data;
}

if($flag==0)
{	$con=mysqli_connect("localhost","root","","aitdc");
	if (mysqli_connect_errno()) {
 								 echo "Failed to connect to MySQL: " . mysqli_connect_error();
								}
	$name = $_SESSION['sname'];
	$ybr = $_SESSION['sybr'];
	$email = $_SESSION['semail'];
	$ach = $_SESSION['sach'];		
								

			
	$sql="INSERT INTO members VALUES ('$name', '$email', '$ybr', '$ach')";

if (!mysqli_query($con,$sql)) {
  die('Error: ' . mysqli_error($con));
}
//echo "1 record added";
else
{
	
	echo '<script language="javascript">';
      echo 'alert("Successfully Registered"); location.href="finalmem.php"';
      echo '</script>';
}	    

mysqli_close($con);	

	

}	
session_destroy();		
?>								
									




<div class='login'>
  <h2>Register</h2>
  <form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
  <input name='name' placeholder='Name*' type='text' >
  <span class="error"> <?php echo $nameErr;?></span>
<br><br>
  <input name='ybr' placeholder='Year(Branch)*' type='text' >
  <span class="error"> <?php echo $ybrErr;?></span>
<br><br>
 
  <input name='email' placeholder='E-Mail Address*' type='text'>
  <span class="error"> <?php echo $emailErr;?></span>
<br><br>
  
  <textarea name="ach" placeholder='Achievements/Certificates'  style="background-color:#2E3740"  ></textarea>
  <div class='agree'>
  <span class="error"> <?php echo $achErr;?></span>
<br><br>
    <input id='agree' name='agree' type='checkbox'>
    <label for='agree'></label>Accept rules and conditions
  </div>
  
  <input class='animated' type='submit' value='Register'>
  <div>* marked fields are compulsory</div>
  
  </form>
</div>




</body>
</html>