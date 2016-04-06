function generate_feed(xml) {
	var items = xml.getElementsByTagName("item");

	var doc = document.implementation.createHTMLDocument("New Document");
	var i, el = doc.createElement('html');
	el.innerHTML = "<html><head><title>ES CA</title></head><body></body></html>";
	
	var mark = 0;
	for (i = 0; i < items.length; i++) {
        var div = document.createElement("div");
		div.className = "block";
		
		var inner_cat = document.createElement("div");
		inner_cat.className = "cat";
		inner_cat.innerHTML = $(items[i]).find("category").html();
		div.appendChild(inner_cat);
		
		var inner_date = document.createElement("div");
		inner_date.className = "date";
		var pub_date = $(items[i]).find("pubDate").html();
		var date = new Date(pub_date);
		var months = Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		var string = date.getDate() + " " + months[date.getMonth()];
		inner_date.innerHTML = string;
		
		div.appendChild(inner_date);
		
		var inner_img = document.createElement("img");
		inner_img.className = "prev";
		inner_img.id = $(items[i]).find("enclosure").attr('length');
		inner_img.src = 'images/prev_load2_std.GIF';
		inner_img.style.width = "64px";
		inner_img.style.marginLeft = "148px";
		var img_src = $(items[i]).find("enclosure").attr('url');
		
		var xhr = new XMLHttpRequest();
		xhr.open('GET', img_src, true);
		xhr.responseType = 'blob';
		xhr.send();
		xhr.onload = function(e) {
			if (200 == this.status) {
				inner_img.src = window.URL.createObjectURL(this.response);
				console.log("XHR[" + mark + "]" + inner_img.src);
				var id = this.getResponseHeader('Content-Length').toString();
				document.getElementById(id).src = inner_img.src;
				document.getElementById(id).style.width = "160px";
				document.getElementById(id).style.marginLeft = "auto";
			}
		}
		div.appendChild(inner_img);
		
		var inner_title = document.createElement("div");
		inner_title.className = "tit";
		inner_title.innerHTML = $(items[i]).find("title").html();
		div.appendChild(inner_title);
		
		var inner_descr = document.createElement("div");
        inner_descr.className = "dsc";
		inner_descr.innerHTML = $(items[i]).find("description").html();
		div.appendChild(inner_descr);
        
		var inner_br = document.createElement("br");
		inner_descr.appendChild(inner_br);
		
		var inner_link = document.createElement("a");
		inner_link.className = "lnk";
		inner_link.href = $(items[i]).find("link").html();
		if (-1 != inner_link.href.indexOf("game") || -1 != inner_link.href.indexOf("thrones") || -1 != inner_link.href.indexOf("prestol")) {
			div.style.backgroundColor = "#FF9933";
			inner_img.src = 'images/prev_load2_spec.GIF';
		}
		inner_link.target = "_blank";
		inner_link.innerHTML = "Read more";
		inner_descr.appendChild(inner_link);
		
		
		el.getElementsByTagName('body')[0].appendChild(div);
    }
	console.log("mark:" + mark);
	
	
	string = JSON.stringify(el.getElementsByTagName("body")[0].innerHTML);
	string = string.replace(/<!--\[CDATA\[/g, '').replace(/\]\]-->/g, '');
	console.log('stringified:' + string);
	return string;
}