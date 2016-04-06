						<div class="side-block side-login">
							<form method="post" action="">
								<h4 class="side-block-head">Login</h4>
								<div class="side-block-body">
<?php 
if (!$forum_user['is_guest'])
{
?>
<div class="blocks">
  <h2>Здравей, <?php echo forum_htmlencode($forum_user['username']) ?>!</i></h2> 

<?php echo $avatars ?>

<?php echo '<i class="fa fa-comments"></i> <a href="/forum/pm.php?section=inbox#brd-crumbs-top" id="loginlink">Съобщения</a>'; ?><br />
<?php echo $links['userlist'] = '<i class="fa fa-users"></i> <a href="'.forum_link($forum_url['users']).'" id="loginlink">'.$lang_common['User list'].'</a>';?><br />
<?php echo $links['profile'] = '<i class="fa fa-user"></i><a href="'.forum_link($forum_url['user'], $forum_user['id']).'" id="loginlink">'.$lang_common['Profile'].'</a>';?><br />
<?php echo $links['logout'] = ' <i class="fa fa-sign-out"></i> <a href="'.forum_link($forum_url['logout'], array($forum_user['id'], generate_form_token('logout'.$forum_user['id']))).'">'.$lang_common['Logout'].'</a>';?>

</div>
<?php
}
else
{
$cur_panel['title'] = $lang_common['Login'];
require_once FORUM_ROOT.'lang/'.$forum_user['language'].'/login.php';
$form_action = forum_link($forum_url['login']);
$forum_page['redirect_url'] = 'https://flazy.us/index.php';
?>

<div class="blocks">

<form method="post" action="<?php echo $form_action ?>">

            <input type="hidden" name="form_sent" value="1" />
            <input type="hidden" name="redirect_url" value="<?php echo forum_htmlencode($forum_page['redirect_url']) ?>" /><?get_current_url()?>
            <input type="hidden" name="csrf_token" value="<?php echo generate_form_token($form_action) ?>" />

		<div align="center" class="logform">
			<ul class="reset">
				<label for="login_name"><?php echo $lang_login['Username'] ?>:</label><br /><input type="text" name="req_username" id="login_name" size="23" />
				<label for="login_password"><?php echo $lang_login['Password'] ?> (<a href="forum/login.php?action=forget">Forgoten password</a>)</label><br /><input type="password" name="req_password" id="login_password" size="23" />
				<?php echo $lang_login['Remember me'] ?></span> <input type="checkbox"  size="3" id="fld-remember-me" name="save_pass" value="1" />
				<button class="fbutton" onclick="submit();" type="submit" title="Login"><span>Login</span></button>
			</ul>
			<input name="login" type="hidden" id="login" value="submit" />
		</div>
	</form>

<noindex></noindex>
</div>
<?php 
}
unset($stats_list);
?>
								</div>
							</form>
						</div>