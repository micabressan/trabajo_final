function login(event){
event.preventDefault();
var email = document.getElementById("email_form_login").value;
var password = document.getElementById("pass_form_login").value;
if( email !=='' && password !==''){
 $.ajax({
            type: "POST",
            url: 'post.php?action=login',
            data: {
                email: email,
                password: password
            },
            success: function(data)
            {
                if (data === 'success') {
                    alert("quara");
                }
                else {
                    alert(data);
                }
            }
        });
}
};