function process_for_table(id, name, creation_time, query_text, result_time) {
	crAr = (creation_time).split(/[: /]/g);
	reAr = (result_time).split(/[: /]/g);
	pretty_creation_time = date_formatting(parse_date_to_client(crAr[0], crAr[1], crAr[2], crAr[3], crAr[4], crAr[5]));
	pretty_result_time = date_formatting(parse_date_to_client(reAr[0], reAr[1], reAr[2], reAr[3], reAr[4], reAr[5]));

	var out = "<td>" + id + "</td>" +
			"<td>" + name + "</td>" + 
			"<td>" + pretty_creation_time + "</td>" + 
			"<td>" + query_text + "</td>" + 
			"<td>" + pretty_result_time + "</td>";
	return out;
}
	
function load_more_obj(newHistory) {
	var table = document.getElementById("history_table");
	for (key = 0; key < Object.keys(newHistory).length; ++key) {
		var row = table.insertRow(table.rows.length);
		row.innerHTML = process_for_table(newHistory[key]['id'], newHistory[key]['name'],
			newHistory[key]['creation_time'], newHistory[key]['query_text'], newHistory[key]['result_time']);
	}
}

function get_more_obj() {
	if (last != 1) {
		var xmlhttp = new XMLHttpRequest();
		xmlhttp.onreadystatechange=function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status==200) {
				var newHistory = JSON.parse(xmlhttp.responseText);
				load_more_obj(newHistory);
				last = jQuery(jQuery('#history_table tr').last().html(), 'td').first().html();
			}
		}
		xmlhttp.open("GET", "ajax_history?last=" + last, true);
		xmlhttp.send();
	}
}