$( document ).ready(function() {
    var saveBlob = new Blob(['content'], {
      "type": "text/plain"
    });
    var url = window.URL.createObjectURL(saveBlob);
    var a = document.createElement("a");
    document.body.appendChild(a);
    a.textContent = "Download";
    a.href = url;
    a.download = "filename.txt";
});