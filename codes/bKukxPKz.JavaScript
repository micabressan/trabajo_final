// ZAMIEŃ TO <-------------
//Initiate everything
$(document).ready(function(){
  	$("#TermsAgree").after('<?php 
		echo tep_image(DIR_WS_TEMPLATES . 'images/buttons/'.$language.'/button_confirm_order_disabled.gif', '', '', '', ' id="TheDisabledButton" style="display:none;"'); 
?>');
		
	if(!$("#TermsAgree").attr("checked")){ //if it isnt checked the button should be disabled
disablebutton();
}

});

// NA TO <-------------
//Initiate everything
$(document).ready(function(){
  	$("#TermsAgree").after('<?php 
		echo tep_image(DIR_WS_TEMPLATES . 'images/buttons/'.$language.'/button_confirm_order_disabled.gif', '', '', '', ' id="TheDisabledButton" style="display:none;"'); 
?>');
		
	//if it isnt checked the button should be disabled
	if(!$("#TermsAgree").attr("checked")){ 
		disablebutton();
	}
	$('#TermsAgree').click(function(){
		if($(this).is(':checked')) {
			enablebutton();
		} else {
			disablebutton();
		}
	});
});