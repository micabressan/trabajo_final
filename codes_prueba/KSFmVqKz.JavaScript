var https = require("https");
var fs = require("fs");
var ws = fs.createWriteStream("2letters_domains_available.txt");

var domain = "aa.lc"; // format: aa.tld
var numbers = false; // include numbers

function apiParse(body)
{
	var status = JSON.parse(body)[0].available;
	if (status == "pending")
		apiRequest();
	else
	{
		console.log(domain + ": " + status);
		if (status == "available")
			ws.write(domain + "\n");
		var ascii = domain.charCodeAt(1);
		if (ascii > 96 && ascii < 122) // > 'a' - 1 && < 'z' character
			domain = domain.substring(0, 1) + String.fromCharCode(ascii + 1) + domain.substring(2);
		else if (numbers && (ascii == 122 || ascii < 57)) // < '9' character
		{
			if (ascii == 122)
				ascii = 47; // '0' character - 1
			domain = domain.substring(0, 1) + String.fromCharCode(ascii + 1) + domain.substring(2);
		}
		else if ((ascii = domain.charCodeAt(0)) > 96 && ascii < 122)
		{
			domain = domain.substring(0, 1) + 'a' + domain.substring(2);
			domain = String.fromCharCode(ascii + 1) + domain.substring(1);
		}
		else if (numbers && (ascii == 122 || ascii < 57))
		{
			if (ascii == 122)
				ascii = 47;
			domain = domain.substring(0, 1) + 'a' + domain.substring(2);
			domain = String.fromCharCode(ascii + 1) + domain.substring(1);
		}
		else
		{
			ws.end();
			return;
		}
		apiRequest();
	}
}

function apiResponse(res)
{
	var body = "";
	res.on("data", function(d) {
		body += d;
	});
	res.on("end", function() {
		apiParse(body);
	});
}

function apiRequest()
{
	console.log("checking " + domain);
	https.get("https://www.gandi.net/domain/suggest/verbose_tlds?currency=EUR&tld=" + domain, apiResponse);
}

apiRequest();