<?php if(!defined('In_ZapHK')) { exit; } ?>
 
 <div class="row-fluid sortable">		
	<div class="box span12">
		<div class="box-header well" data-original-title>
			<h2><i class="icon-list-alt"></i> Users Chatlog</h2>
		</div>
		<div class="box-content">
		Here you can search a user's chatlog. <br />
		<hr />
		<form method="post" class="form-horizontal">
                        <fieldset>		
			  <div class="control-group">
				<label class="control-label" for="focusedInput">Username</label> 
				<div class="controls">
				  <input class="input-xlarge focused" name="username" type="text">
				</div>
			  </div>

			  <div class="form-actions">
				<button type="submit" class="btn btn-primary" name="userSubmit">Search</button>
			  </div>
			  
			  </fieldset>
			  
			  </div>
			  </div>
			  
			  		<?php
 if(isset($_POST["username"]) && isset($_POST["userSubmit"])) {
                $getUser = $db->query("SELECT username,id FROM users WHERE username = '".$db->real_escape_string($_POST["username"])."'");
                        $userInfo = $getUser->fetch_assoc();
                        if($getlogs = $db->query("SELECT * FROM chatlogs WHERE user_id = '".$userInfo["id"]."' ORDER BY timestamp DESC LIMIT 150")) {
                                echo '
                <div class="row-fluid sortable">            
                                <div class="box span12">
                                        <div class="box-header well" data-original-title>
                                                <h2><i class="icon-list-alt"></i> Your Result</h2>
                                        </div>
                                        <div class="box-content">
                                                <table class="table table-striped table-bordered bootstrap-datatable datatable">
                                                  <thead>
                                                          <tr>
                                                                  <th>Username</th>
                                                                                <th>Room</th>
                                                                                <th>Time</th>
                                                                                <th>Message</th>
                                                          </tr>
                                                  </thead>  
                                                  <tbody> ';
                            $username = $db->query("SELECT username FROM users WHERE username = '".$logs['user_id']."'");

                                while($logs = $getlogs->fetch_assoc()) {
                                        echo "<tr>
                                                        <td>" . $username . "</td>
                                                        <td>" . $logs['room_id'] . "</td>
                                                        <td>" . date('d/M/Y h:i:s',$logs['timestamp']) . "</td>
                                                        <td>" . $logs['message'] . "</td>
                                                </tr>";
                                }
                                echo '</table></div>';
                                        }
										}
                ?>
			</div>
<div class="row-fluid sortable">               
        <div class="box span12">
                <div class="box-header well" data-original-title>
                        <h2><i class="icon-list-alt"></i> Chatlogs</h2>
                </div>
                <div class="box-content">
                You can view all chatlogs here. <br />
                <hr />
		<div class="box-content">
			<table class="table table-striped table-bordered bootstrap-datatable datatable">
			<thead>
				  <tr>
					  <th>Username</th>
					  <th>Room</th>
					  <th>Time</th>
					  <th>Message</th>
				  </tr>
				  </thead>
                </div>
        </div>
 
</div>
		<?php
			if($getlogs = $db->query("SELECT * FROM chatlogs ORDER BY timestamp DESC LIMIT 150")) {
                                while($logs = $getlogs->fetch_assoc()) {
                                        $username = $db->query("SELECT username FROM users WHERE username = '".$logs['user_id']."'");

                                        $userInfo = $getUser->fetch_assoc();
                                        echo "<tr>
							<td>" . $username . "</td>
							<td>" . $logs['room_id'] . "</td>
							<td>" . date('d/M/Y h:i:s',$logs['timestamp']) . "</td>
							<td>" . $logs['message'] . "</td>
						</tr>";
				}
			}
		?>  
		</table>
</div>
</div>
</div>
</div>

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />