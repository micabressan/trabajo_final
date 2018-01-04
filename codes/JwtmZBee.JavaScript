var browserDiscordLib = function () {
	token: 0,
	on: function (message, cb) {
		this["on" + message] = cb;
    },
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
					if (_this.onready) _this.onready(data.d);
                }
				if (data.t == "MESSAGE_CREATE") {
					let ev = _this.messageFromRaw(data.d);
					if (_this.onmessage) _this.onmessage(ev);
            }
        }
    }
	messageFromRaw: function (_raw) {
		var raw = _raw;
		var _this = this;
	
		raw.reply = function (content) {
			return new Promise((res, rej) => {
				var xhr = new XMLHttpRequest();
				var this_ = this;
				xhr.addEventListener("load", res(_this.messageFromRaw(this_.responseText)));
				xhr.onerror = rej;
				xhr.open("POST", _this.baseURL + `/channels/${_raw.channel_id}/messages`);
				xhr.setRequestHeader("Authorization", `Bot ${_this.bot_token}`);
				xhr.setRequestHeader("content-type", "application/json");
				xhr.send();
            });
        }

		return raw;
    }
	baseURL = "https://discordapp.com/api/v6",
}