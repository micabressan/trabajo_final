<script src="//cdn.tinymce.com/4/tinymce.min.js"></script>
<script>
tinymce.init({
	file_browser_callback : 
	function(field_name, url, type, win){
		var filebrowser = "yourfile.php?a=param";
		filebrowser += (filebrowser.indexOf("?") < 0) ? "?type=" + type : "&type=" + type;
		tinymce.activeEditor.windowManager.open({
		title : "Insert File",
		width : 700,
		height : 400,
		url : filebrowser
		}, {
		window : win,
		input : field_name
		});
		return false;
	}
}
</script>

// == yourfile.php ==

<script src="https://code.jquery.com/jquery-2.2.4.min.js" integrity="sha256-BbhdlvQf/xTY9gja0Dq3HiwQF8LaCRTXxZKRutelT44=" crossorigin="anonymous"></script>
<script>
$(document).on("click",".file",function(){
  item_url = $(this).data("src");
  var args = top.tinymce.activeEditor.windowManager.getParams();
  win = (args.window);
  input = (args.input);
  win.document.getElementById(input).value = item_url;
  top.tinymce.activeEditor.windowManager.close();
});
</script>
<?php
$path = 'yourimagefolder/';
$files = GLOB($path.'*{.jpg,.png}',GLOB_BRACE);
?>
<?php if (!EMPTY($files)): ?>
	<ul style="display: inline-block; width: 100%; box-sizing: border-box; list-style: none; padding: 0;">
	<?php foreach ($files as $file): ?>
		<?php
			$file_name = basename($file);
			$file = str_replace(' ', '%20', $file);
		?>
		<li class="file" data-src="<?= $path.$file_name; ?>" style="margin: 10px; width: 100px; display: inline-block; height: 100px; float: left; cursor: pointer;">
			<div class="file_image" title="<?= $file_name; ?>" style="display: block; width: 100px; height: 100px; background-image: url(<?= $path.$file_name; ?>); background-position: center center; background-size: cover;"></div>
		</li>		
	<?php endforeach; ?>
	</ul>	
<?php endif; ?>