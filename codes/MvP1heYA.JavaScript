this.submitFunction=function(){
	    	var d = new Date();
			store.messages.push({"id":"1",
				"text":store.inputText,
				"time": d.getTime()
				});
	    	
		    if(!this.controlTime()){ 
		        
		        var cont={contexts:[{name:'userName', parameters:{'name':store.userName}}]};
		        const promise = client.eventRequest("sessionActive",cont);
		        promise.then(this.handleResp).catch(this.handleErr);

		      }
		      else{
		      
		        const promise = client.textRequest(store.inputText);
		        promise.then(this.handleResp).catch(this.handleErr);
		      }
		    
		    store.inputText="";   

		};