<?php

global $connection;

extract($_POST);
if($_POST['act'] == 'add-com'):
	
    $comment = htmlentities($comment);
	  $uid = ($uid);
	  $aid = ($aid);
	    $qid = ($qid);
		  $uname = ($uname);
		  $uemail = ($uemail);
		  $aemail = ($aemail);
		  $session_id = ($session_id);
		  if($session_id==$aid){$subject="Query Notification" && $body = 'Hi '.$username.',  There is a Query in Forum Belong to your Department please Click the Following Link To Reply'.  BASE_URL.'/question.php?id='.$qid && $to=$aemail;}
		  else{$body = 'Hi '.$username.',  One of Our Advisor Comment on Your Question please Click on the Following Link to Check'.  BASE_URL.'/question.php?id='.$qid && $to=$uemail && $subject='Query Notification';  }


    // Connect to the database
	include('../db.php'); 
	

	
    //insert the comment in the database
	$sql="INSERT INTO `answers`(`uid`,`qid`,  `answer`, `status`, `uname`)VALUES('$uid','$qid','$comment','0','$uname')";
	$qr=mysqli_query($connection,$sql);
	
	$headers = "From: Nadeem@hungamahouse.com";

mail("$to","$subject",$body,$headers);	
    if(!mysql_errno()){
?>

    <div class="profilesleft">

		
       

 		<hr />
            	<div id="p8149" class="post vt-bg1">
		<div class="postbody">
			
				
			

			<h3>Reply</h3>
			<p class="author">by <strong><?php echo $uname; ?></strong></p>
				<div class="content"><?php echo $comment;?>  <img src="./answers_files/icon_e_biggrin.gif" alt=":D" title="Very Happy"></div>
			

			

			

		</div>

		
			<dl class="postprofile" id="profile8149">
			<dt>
				by <?php echo $uname; ?>
			</dt>

			

		<dd>&nbsp;</dd>

		<dd><strong>Date:</strong><?php echo date('d-m-Y H:i'); ?></dd>

		</dl>
	

		

		


	</div></div>
    <div class="cmt-cnt">
    	
		<div class="thecom">
        </div>
        </div>
<?php } ?>
<?php endif; ?>