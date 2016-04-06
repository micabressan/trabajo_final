$(".gen_id_cms").click(function(e){
      e.preventDefault();
      var pseudo = ('#id_pseudo')
    $.ajax({type: "GET",
            url: "include/config/id.php",success:function(result){$("#id_ajax").val(result);}});
    		data : 'pseudo=' + pseudo;
 });