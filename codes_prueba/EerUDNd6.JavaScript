//registerLink
function showRegisterForm(errors) {

        $('.login-form').animate({opacity:0},300,function(){ $('.login-form').hide(); });
        $('.registerForm').show().css({opacity:0});
        $('.registerForm').animate({opacity:1},300);
        $('.shadow').show().css({opacity:0,'width':'100%','height':'100%'});
        $('.shadow').animate({opacity:0.7},300);
        $('.shadow').unbind().click(function(){
            $('.shadow').animate({opacity:0},200,function(){$('.shadow').hide()});
            $('.registerForm').animate({opacity:0},300,function(){ $('.registerForm').hide(); });
        });
        $('.registerForm').find('.close').unbind().click(function(){
            $('.shadow').animate({opacity:0},200,function(){$('.shadow').hide()});
            $('.registerForm').animate({opacity:0},300,function(){ $('.registerForm').hide(); });
            return false;
        });
   
    
    if (errors != undefined) {
        $('.regform-note1').html(errors);
    }
}
function hideRegForm() {
    $('#formbackground').hide();
    $('.registerForm').hide();
    $('.shadow').animate({opacity:0},200,function(){$('.shadow').hide()});
        ths.animate({opacity:0},300,function(){ ths.hide(); });
}

$(document).ready(function() {
    $('.registerLink').click(function() {
        showRegisterForm();
        return false;
    });
})

function showtab (sm_num)
{
var element = document.getElementById('imglink'+sm_num);
element.src="/wp-content/themes/noviy2/images/imglink"+sm_num+"2.png";
}
function hidetab (sm_num)
{
var element = document.getElementById('imglink'+sm_num);
element.src="/wp-content/themes/noviy2/images/imglink"+sm_num+"1.png";
}
function showcloselink (pc_num) {
  /*
	var element = document.getElementById('closeimg');
	element.src="/wp-content/themes/noviy2/images/closebox"+pc_num+".png";
  */
  $('.closeimg').attr('src', "/wp-content/themes/noviy2/images/closebox"+pc_num+".png");
}
function showloginform () {
	show_form('.login-form'); 
    return false;	
}
function hideloginform () {
	var element = document.getElementById('formbackground');
	element.style.display='none';
}