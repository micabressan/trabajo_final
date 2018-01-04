function updateGame()
{
  var eSource = new EventSource("http://twserver.alunos.dcc.fc.up.pt:8008/update?nick="+username+"&game="+gameId);
  
  console.log("In update function");
  
  eSource.onmessage = function(event) {
    
    console.log("Incoming data");
    
    var srvResponse = JSON.parse(event.data);
    
    console.log(JSON.stringify(srvResponse));
  }
}