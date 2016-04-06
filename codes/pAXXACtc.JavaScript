function Bot() {
	this.config = require('./config');
}

Bot.prototype = {
	getLogin: function() {
		console.log('Api key: '. this.config.apyKey);
	}
}

var Bot = new Bot();
Bot.getLogin();