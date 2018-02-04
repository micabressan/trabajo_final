		download: function() {

			$('.jr-page').on('click','button.jr-media-download',function() {

				var el = $(this),
					media_id = el.data('media-id'),
					tokens = el.data('token-s'),
					tokeni = el.data('token-i');

				if(jreviews.iOS) {

					window.open(s2AjaxUri+'&url=media/download&'+jreviews.qvars.mc+'='+media_id+'&'+tokens+'=1&'+tokeni+'=1');
				}
				else {

					$('#jr-download-'+media_id).remove();

					var iframe = $('<iframe id="jr-download-'+media_id+'" style="display:none;"></iframe>');

					iframe.attr('src',s2AjaxUri+'&url=media/download&'+jreviews.qvars.mc+'='+media_id+'&'+tokens+'=1&'+tokeni+'=1').appendTo('body');
				}
			});
		}