var lastID = 0;
var defaultTitle = document.title;
var st = null;

function naprawaChatu(){
	if(lastID === 0){
		lastID = Number(document.getElementById('qa-chat-list').children[0].getAttribute('id').match(/[0-9]/g).join(''));
	}
	else{
		var tID = Number(document.getElementById('qa-chat-list').children[0].getAttribute('id').match(/[0-9]/g).join(''));
		if(tID > lastID)
			document.title = 'Nowa wiadomość!';

		lastID = tID;
	}

	setTimeout(naprawaChatu, 300); //recursion
}

document.body.addEventListener('mousemove', function(){
	document.title = defaultTitle;
});