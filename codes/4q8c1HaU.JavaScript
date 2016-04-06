$.post('../pages/retrieve_definitions.php',$('#getRecords').serialize()+'&session_cookie='+$("#c").val(),
		function(datum){
			var c;
				
				c=JSON.parse(datum);
				
				$("#result_view").html("");
				//console.log(JSON.stringify(c.status.success));
				if(JSON.stringify(c.status.success)==1){
					
				
				
					for(i=0;i<c.objects.length;i++){   
					
					 __id = c.objects[i]._id;
					 __name = JSON.stringify(c.objects[i].name);
					 __description = JSON.stringify(c.objects[i].description);
					 __type= JSON.stringify(c.objects[i].type);
					 __diet= JSON.stringify(c.objects[i].diet);
					 __shelter= JSON.stringify(c.objects[i].shelter);
					 __hygiene= JSON.stringify(c.objects[i].hygiene);
					 __medication= JSON.stringify(c.objects[i].medication);
					 __video= JSON.stringify(c.objects[i].video);
					 __thumbnail= JSON.stringify(c.objects[i].thumbnail);
					 __picture=JSON.stringify( c.objects[i].picture);
					 
					 console.log(__id);
					 console.log(__name);
					 console.log(__description);
					 console.log(__type);
					 console.log(__diet);
					 console.log(__shelter);
					 console.log(__hygiene);
					 console.log(__medication);
					 console.log(__video);
					 console.log(__thumbnail);
					 console.log(__picture);
					
					$("#result_view").
					append
					("<legend class='awesome'><span class='number'>"+(i+1)+"</span>"+c.objects[i].name+"  </legend> <button class='example pinterest' onclick='editAnimal("+__id+","+__name+","+__type+","+__description+","+__diet+","+__shelter+","+__hygiene+","+__medication+","+__video+","+__thumbnail+","+__picture+     " )' >Edit</button>  <button class='example pinterest' onclick='editAnimal("+c.objects[i]._id+" )' >Delete</button>  ");
					
				}
				
				
				}
				else{
					logout_message();
				}
			//console.log(datum);
		});