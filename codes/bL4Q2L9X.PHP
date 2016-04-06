add_action('um_submit_form_errors_hook', 'validate_user');

function validate_user() {
include(TEMPLATEPATH."/simple_html_dom.php");
$username = "Georgeba";
$link = 'http://www.roblox.com/User.aspx?username=$username';
$headers = @get_headers($link);
$invalidName = false;
$hasWord = false;
if ($headers[0] != 'HTTP/1.1 404 Not Found') { //Check if username is real
        $data = file_get_html($link)->plaintext;
        $word = "Admin";
        $hasWord = (bool) strpos($data, $word);
} else {
        $invalidName = true;
}
if ($hasWord == 0) {
    echo "Verified";
} else {
    echo "Un-Verified";
}
}