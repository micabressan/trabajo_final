public SearchApiAiResponseDTO searchApiAi(SearchApiAiRequestDTO request) {
		
		SearchApiAiResponseDTO result=null;
																								
		if(request.getResult().getMetadata().getIntentName().equals("SearchDocument") || request.getResult().getMetadata().getIntentName().equals("No_Search"))
		{
			result=searchDocument(request);
		}
		
		if(request.getResult().getMetadata().getIntentName().equals("UpdateES"))
		{
			
			result=updateAll(request);
		}
		
		if(request.getResult().getMetadata().getIntentName().equals("SearchWeb"))
		{
			result=searchFeedRSSWeb(request, 3 , 0); 
		}
		
		if(request.getResult().getMetadata().getIntentName().equals("UpdateView"))
		{
			updateView(request);
			result=new SearchApiAiResponseDTO();
		}
		
		if(request.getResult().getMetadata().getIntentName().equals("TranslateText"))
		{
			result=translate(request);
		}
		
		if(request.getResult().getMetadata().getIntentName().equals("TranslationTwo"))
		{
			result=translateTwo(request);
		}
		
		return result;
		
	    
	}