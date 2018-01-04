$(function() {
	var modal_holder_selector, modal_selector;
	modal_holder_selector = '#modal-holder';
	modal_selector = '.modal';
	$(document).on('click', 'a[data-modal]', function(e) {
		e.preventDefault();
		var location = $(this).attr('href');
		$.ajax({
			url: location,
			type: 'get',
			success: function(data, status, xhr){
				var url = xhr.getResponseHeader('Location');
				if (url) {
					window.location = url;
				} else {
					$('.modal-backdrop').remove();
					$(modal_holder_selector).html(data).find(modal_selector).modal();
				}
			},
			error: function(data){
				$('.modal-backdrop').remove();
				$(modal_holder_selector).html(data.responseText).find(modal_selector).modal(); //i dont believe you will do this on error
				alert('error');
				console.log(data);
			}
		});
		
	});
});