<script>
        var token = window.location.toString().split('#')[1].substring(13,window.location.toString().split('#')[1].toString().indexOf("&")-1);

            //$.get("http://api.soundcloud.com/me", {client_id:'a5882704e3d05618887241084db23a01', access_token:token}).done(function(data){
                window.location = '/beta_scfollow/public/soundcloud/mobile_auth?access_token=' + token + "&sc_img_url=" +  '' + "&sc_username=" + {{"'" . $_SESSION['user'] . "'"}};
            //});
    </script>