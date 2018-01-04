<input type="text" id="1" oninput="mult()" value="" placeholder="укажите количество точек">
<input type="text" id="цена"" placeholder="цена составит:">
<script> 
function mult() {
    var a = document.getElementById('1').value;
    document.getElementById('цена').value = a * 400;
} 
</script>
</BODY>
</HTML>