<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <title>Compute</title>

		<script type="text/javascript">
			
			/* PARTIALLY WORKING */
			
			function calculate_values(){
				
				var result = document.getElementById('result0');
				var el, i = 0, total = 0; 
				
					while(el = document.getElementById('value'+(i++)) ) {
						el.value = el.value.replace(/\\D/,"");
						total = total + Number(el.value);
					}
					
					result.value = total;
					
					
					
				var SubTotal = document.getElementById('result0').value;	
				var tax = document.getElementById('result1');	
				var myResult = SubTotal * 0.07;
					
					tax.value = myResult.toFixed(2);



				var MySubTotal = document.getElementById('result0').value;	
				var Tax = document.getElementById('result1').value;
				var GrandTotal = document.getElementById('result2');	
				var myFinalResult = MySubTotal + Tax;
					
					GrandTotal.value = myFinalResult.toFixed(2);

			}
			
			
			/* TRIED THIS FIRST... FAILED MISERABLY !!!   */ /*
			
			
			function calculate_values(){
				
				var SubTotal = document.getElementById('result0').value;
				var Tax = document.getElementById('result1').value;
				var GrandTotal = document.getElementById('result2').value;
				
				var Result0 = SubTotal * 0.07;
				var Result2 = MySubTotal + Tax;
				
				var el, i = 0, total = 0; 
				
					while(el = document.getElementById('value'+(i++)) ) {
						el.value = el.value.replace(/\\D/,"");
						total = total + Number(el.value);
					}
					
				SubTotal.value = total;
					
				Tax.value = Result0.toFixed(2);
					
				GrandTotal.value = Result2.toFixed(2);

			}
			*/
			
			
		</script>
  </head>
  <body>
	  
	<style>
		.txt {
			text-align: right;
		}
	</style>
	  
	  
	<h2>Calculation Test 086</h2>
	
	<br>
	
    <form action="">
		Some Amount:<input type="text" id ="value0" class="txt" placeholder="0.00" onkeyup="calculate_values()"><br>
		Some Amount:<input type="text" id ="value1" class="txt" placeholder="0.00" onkeyup="calculate_values()"><br>
		Some Amount:<input type="text" id ="value2" class="txt" placeholder="0.00" onkeyup="calculate_values()"><br>
		Some Amount:<input type="text" id ="value3" class="txt" placeholder="0.00" onkeyup="calculate_values()"><br>
		Some Amount:<input type="text" id ="value4" class="txt" placeholder="0.00" onkeyup="calculate_values()"><br>
		Some Amount:<input type="text" id ="value5" class="txt" placeholder="0.00" onkeyup="calculate_values()"><br>
		
	<br>
		
		SubTotal: <input type="text" id="result0" class="txt" placeholder="Automatically Generated" onkeyup="calculate_values()"  readonly><br>
		Tax:      <input type="text" id="result1" class="txt" placeholder="Automatically Generated" onkeyup="calculate_values()"  readonly><br>
		Total:    <input type="text" id="result2" class="NOTtxt" placeholder="! NOT YET FUNCTIONAL !" onkeyup="calculate_values()"  readonly><br>
    </form>
    
    <br><br>
    
  </body>
</html>