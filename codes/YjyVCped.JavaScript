jQuery(document).ready(function($){
    $('#tab-wrapper li:first').addClass('active');
    $('#tab-body > div').hide();
    $('#tab-body > div:first').show();
    $('#tab-wrapper a').click(function() {
        $('#tab-wrapper li').removeClass('active');
        $(this).parent().addClass('active');
        var activeTab = $(this).attr('href');
        $('#tab-body > div:visible').hide();
        $(activeTab).show();
        return false;
    });
});