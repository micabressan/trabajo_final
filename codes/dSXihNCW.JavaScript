this.handleResp=function(serverResponse){
	var count=0
    var intentName=serverResponse.result.metadata.intentName
    $log.log(intentName);
	var d = new Date();
        
	if(intentName!="FallbackClassic" || intentName!="FallbackName" || intentName!="Falleback_123"){
		store.fallbackCount=0;
	}
	
    switch(intentName){
    
    case "FallbackClassic":   
    case "FallbackName":
    case "Falleback_123":
    	
    	store.fallbackCount++;
    	if(store.fallbackCount==2)
    		{
    		this.resetConversation();
    		store.fallbackCount=0;
    		}
    	else
    		store.messages.push({"id":0,
	    		  "text": serverResponse.result.fulfillment.speech,
	    		  "time": d.getTime()
	    	});
    
    case "InsertName2":
    case "InsertName":

	  store.showBalloons=false;
      store.showThreeButtons=false;
      store.showPDFViewer=false;
        
      var dayNight=store.getDayNight();
      
      store.userName=serverResponse.result.parameters.name
      sessionActive=true   			
      
      
      store.messages.push({"id":0,
    		  "text": dayNight+serverResponse.result.fulfillment.speech,
    		  "time": d.getTime()
      });

      
      break
      
    case "SearchDocument":
    case "No_Search":
    
      if(serverResponse.result.actionIncomplete){  
    	  store.messages.push({"id":0,
    		  "text": serverResponse.result.fulfillment.speech,
    		  "time": d.getTime()
    	  });
    	  break; 
      }
    	
      if(intentName=="SearchDocument")
      {
        store.completeQuestion=serverResponse.result.resolvedQuery;
        store.specificQuestion=serverResponse.result.parameters.any;
        store.showBalloons=false;
        store.showThreeButtons=false;
      } 
      
      if(serverResponse.result.fulfillment.data){ 
        
        var data=serverResponse.result.fulfillment.data
        
        var found={};
        store.relatedDocumentFileName=[];
        store.page=[];
        store.relativeIdESDocument=[];
        store.urlParagraph=[];
        store.content=[];
        store.pageChanged=[-1,-1,-1];
        store.idESSaved=[];
        
        for(i=0; i<3; i++){
        	if(i==0)
        		found=data.found0;
        	else if(i==1)
        		found=data.found1;
        	else
        		found=data.found2;
        
	        store.idESSaved.push(found.indexId);
	        store.page.push(found.page);
	        store.relativeIdESDocument.push(found.relatedDocumentIndexId);
	        store.relatedDocumentFileName.push(found.relatedDocumentFileName);
        	store.content.push(found.content);
	        
        	UrlRetriever.retrieveUrl(found.relatedDocumentIndexId,i).then(function(d) {
        		var urlTemp=d.data.contentLink;
        		store.urlParagraph[d.config.param.i]=urlTemp;
        	});

    		$log.log(found.content+"\n\n")
	       
        }
        
        var resp=[];
        store.searchResults=[];
        for(k=0;k<3;k++)
        	{
	        	resp.push({
	        		"page":store.page[k],
	        		"content":store.content[k],
	        		"index":k,
	        		"idESSaved": store.idESSaved[k],
	        		"relativeDocumentFileName": store.relatedDocumentFileName[k],
	        		"relativeIdESDocument":store.relativeIdESDocument[k]
	        	});
	        	
	        	store.searchResults.push({
	        		"page":store.page[k],
	        		"content":store.content[k],
	        		"index":k,
	        		"idESSaved": store.idESSaved[k],
	        		"relativeDocumentFileName": store.relatedDocumentFileName[k],
	        		"relativeIdESDocument":store.relativeIdESDocument[k]
	        	});
        	}
        
        store.messages.push({"id":0,
    		  "text": serverResponse.result.fulfillment.speech,
    		  "time": d.getTime(),
    		  "founds": resp
    	});
        
      }
      else
      {
    	  const promise = client.eventRequest("empty_Data");
  	      promise.then(this.handleResp).catch(this.handleErr);
      }
      
      break

    case "SearchWeb":
      store.showBalloons=false;
      store.showThreeButtons=false;
      store.showPDFViewer=false;
      if(serverResponse.result.fulfillment.data){ 
	        
	        var data=serverResponse.result.fulfillment.data
	        
	        var found={};
	        var feeds=[];
	        store.feedRSSResults=[];
	        
	        for(i=0; i<3; i++){
	        	if(i==0)
	        		found=data.found0;
	        	else if(i==1)
	        		found=data.found1;
	        	else
	        		found=data.found2;
	        
	        	feed={"link": found.link,
	        		"datePub":found.datePub,
	        		"description":found.description,
	        		"title":found.title
	        	}
	        	
	        	store.feedRSSResults.push(feed);
	        	feeds.push(feed);
	        	
	        }
	        
	        store.messages.push({"id":0,
	    		  "text": serverResponse.result.fulfillment.speech,
	    		  "time": d.getTime(),
	    		  "feeds": feeds
	    	});
	        
      }
      break;
    	
    case "InsertRight":  
    	if(!serverResponse.result.actionIncomplete)
		{
		      var toUpdate=serverResponse.result.parameters.OneTwoThree;
		      var intToUpdate=eval("toUpdate-1");
		      store.clickRight(intToUpdate);
		}
    	else{
    		store.messages.push({"id":0,
	    		  "text": serverResponse.result.fulfillment.speech,
	    		  "time": d.getTime()
	    	});
    	}
      
      break

    case "InsertPageNumber":
    	store.showThreeButtons=false;
    	if(!serverResponse.result.actionIncomplete)
    		{
    		store.clickThreeButtons(serverResponse.result.parameters.number);
    		}
      
    default:
    	store.messages.push({"id":0,
    		  "text": serverResponse.result.fulfillment.speech,
    		  "time": d.getTime()
    	});
    }
};