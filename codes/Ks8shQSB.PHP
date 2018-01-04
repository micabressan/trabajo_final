if(isset($_GET['user'])) {
	$user = $_GET['user'];
	
	$user_select_query = mysql_query("SELECT * FROM Person WHERE ID='$user' && status='1' ");
	$user_data_row = mysql_fetch_assoc($user_select_query);
	$online_user_Name = htmlspecialchars($user_data_row['Name']);
	
}