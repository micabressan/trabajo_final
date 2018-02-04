var browserDiscordLib = function () {
	token: 0,
	connect: function (token) {
		var _this = this;
		
		var ws = new WebSocket("wss://gateway.discord.gg/?v=6&encoding=json");
        ws.onopen = function () {
            ws.send(JSON.stringify({
                op: 2,
                d: {
                    token: token,
                    shard: [0, 1],
                    compress: false,
                    large_threshold: 250,
                    properties: {
                        $os: "windows",
                        $browser: "jesse",
                        $device: "jesse"
                    },
                    presence: {}
                }
            }));
        }
        ws.onmessage = function (message) {
            var data = JSON.parse(message.data);
            if (data.op == 10) {
                setInterval(() => {
                    ws.send(JSON.stringify({
                        op: 1
                    }));
                }, data.d.heartbeat_interval);
            }
			if (data.op == 0) {
				if (data.t == "READY") {
					_this.bot_token = token;
                }
            }
        }
    }
}