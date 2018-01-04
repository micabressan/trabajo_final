private SearchApiAiResponseDTO searchDocument(SearchApiAiRequestDTO request) {
		String number=null;
	    int start=-1;
	    String searchingText=null;
	    
	    if(request.getResult().getParameters().get("any")==null)
	    {
	    	for(ContextDTO ctx:request.getResult().getContexts())
	    		if(ctx.getName().equals("search"))
	    			searchingText=(String) ctx.getParameters().get("any");
	    }
	    else
	    {
	    	searchingText=request.getResult().getParameters().get("any");
	    }
	    
	    String name="";
	    for(int k=0;k<request.getResult().getContexts().size();k++)
	    {
	    	if(request.getResult().getContexts().get(k).getName().equals("username"))  
	    		name=(String) request.getResult().getContexts().get(k).getParameters().get("name.original");
	    }
	    
	    
		SearchApiAiResponseDTO response=new SearchApiAiResponseDTO();
		response.setSource("webhook");
		response.setDisplayText("C'è quello che stavi cercando "+name+"?");   
		response.setSpeech("C'è quello che stavi cercando "+name+"?");
		response.setContextOut(new ArrayList<ContextDTO>());
		response.setData(new HashMap<String, Map<String, String>>());
		response.setMessages(new ArrayList<MessageDTO>());
		int count=0;
		
		//possibile sviluppo futuro per cercare per documenti o per pagine (Specific search)
		String type=null;
		if(request.getResult().getParameters().get("part-of-text")!=null) 
		{
			type=request.getResult().getParameters().get("part-of-text");
		}
		else
		{
			String part=null;
			for(int k=0;k<request.getResult().getContexts().size();k++)
			{
				if(request.getResult().getContexts().get(k).getName().equals("phase2")) 
				{
					part=(String) request.getResult().getContexts().get(k).getParameters().get("part-of-text");
					type=part;
				}
			}
			if(part==null)
				type="paragrafi"; 	
				
		}
			
		
		
		 switch (type) {

         case "paragrafo": case "paragrafi": case "secondo": case "paragraph":
        	 number=request.getResult().getParameters().get("number");
        	 try {
				start=(int) javascriptEngine.eval(number);
			} catch (ScriptException e1) {
				throw new InternalServerErrorException();
			}
        	 List<DocumentParagraph> foundParagraphsList = documentsIndexerService.retrieveParagraphsBySimpleFullTextSearch(searchingText, 3,start, name);
        	 for (DocumentParagraph foundParagraph : foundParagraphsList) {
     			try {
     				SearchParagraphsItemElementDTO listItemElement = DocumentsDataDTOAssembler.toSearchParagraphsItemElementDTO(foundParagraph);
     				HashMap<String, String> map=DocumentsDataDTOAssembler.toSearchParagraphsMAP(listItemElement);
     				response.getData().put("found"+count,map);
     				count++;
     			} catch (EntityNotExistsException e) {
     				throw new InternalServerErrorException();
     			}
     			
     		}
        	 break;
        	 
         //case page, possibile sviluppo futuro
        	 
         //case document, possibile sviluppo futuro
		 }
		 
		 return response;
	}