loadFeed: function (callback) {
			let self = this;
			Connections.getEpisodes(this.feedUrl, function (ep) {
				if (ep) {
					self.episodes.push(ep);
					callback(null, ep);
				} else {
					callback(true, null);
				}
			});
		}

=====================>

exports.getEpisodes = function (url, callback) {
	const req = Request.get(url);
	rss.parse(req, function (ep) {
		callback(ep);
	});
};

=====================>

exports.parse = function (input, callback) {
	const stream = Flow(input);

	stream.on('tag:item', function (item) {
		callback(item);
	});

	stream.once('end', function () {
		callback(null);
	});
};