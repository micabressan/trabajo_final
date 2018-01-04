var arvot ={
		x: document.getElementById("YN").value, 
		x2: document.getElementById("kasvu").value, 
		x3: document.getElementById("DK").value, 
		x4: document.getElementById("BK").value, 
		x5: document.getElementById("OM").value, 
		x6: document.getElementById("KV").value, 
		x7: document.getElementById("MP").value,};
	alert("['"+arvot.x+"', '"+arvot.x2+"', '"+arvot.x3+"', '"+arvot.x4+"', '"+arvot.x5+"', '"+arvot.x6+"', '"+arvot.x7+"']");
	
	function tulosta() {
	$.ajax({
		url: '/DCF-calculator',
		type: 'POST',
		data: JSON.stringify(arvot)