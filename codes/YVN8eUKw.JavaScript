document.new_file_id = 1;
						function upload_tmp() {
							$('#bloks').append('<div class="blok"><img class="thumbnail" id="'+document.new_file_id+'" src="assets/images/uploading.gif" /><div class="right" id="buttons"><input type="image" class="delete control" src="/assets/images/trash-on.png" name="image" width="10" height="10" onclick="audrey(); return false;"></div></div>');
							var fileinput = document.getElementById('file');
							var file = fileinput.files[0];
							var ajax = new XMLHttpRequest();
							ajax.open('POST', 'assets/ajax/upload.php', true);
							ajax.setRequestHeader('X-File-Name', file.name);
							ajax.send(file);
							ajax.onreadystatechange=function() {
								if (ajax.readyState == 4 && ajax.status == 200) {
									add_blok(ajax.responseText);
								}
							}
						}
						function add_blok(tmp_filename) {
							$.ajax({
								type: "POST",
								url: "assets/ajax/create_blok.php",
								data: "title=" + $('#title').val() + "&tmp_filename=" + tmp_filename + "&user_id=" + $('#user_id').val(),
								success: function(json_data) {
									var file = jQuery.parseJSON(json_data);
									$('#'+document.new_file_id).ready(function() {
										$('#'+document.new_file_id).fadeOut(500, function() {
											$('#'+document.new_file_id).attr('src', '/content/'+file.user_id+'/'+file.folder+'/'+file.filename+'-t.jpg');
											$('#'+document.new_file_id).delay(500).fadeIn(500);
											document.new_file_id++;
										});
										
									});
								}
							});
						}