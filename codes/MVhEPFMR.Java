	public List<DocumentParagraph> retrieveParagraphsBySimpleFullTextSearch(String searchTerm, Integer limitResultsTo, Integer resultsFrom, String user) {
		
		List<DocumentParagraph> response = new ArrayList<DocumentParagraph>();
		
		ValidationExceptionBuilder validations = ValidationExceptionBuilder.create();
		
		validations.requiredNotBlankField(user, "user");
		validations.requiredNotBlankField(searchTerm, "searchTerm");
		validations.isTrue(limitResultsTo == null || limitResultsTo > 0, "limitResultsTo", ValidationExceptionBuilder.ERROR_CODE_INVALID_VALUE);
		validations.isTrue(resultsFrom == null || resultsFrom >= 0, "resultsFrom", ValidationExceptionBuilder.ERROR_CODE_INVALID_VALUE);
		validations.throwValidationExceptionIfHasErrors();
	
		try {
			
			URL url = new URL(String.format(
					"%s/%s/%s/_search",
					documentsSettingsService.getElasticSearchServerWsBaseUrl(),
					documentsSettingsService.getElasticSearchIndexRoot(),
					documentsSettingsService.getElasticSearchSubIndexParagraphs()));
			
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setDoOutput(true);
			conn.setRequestMethod("GET");
			
			ObjectNode jsonRequestBody = createQuery(searchTerm, limitResultsTo, resultsFrom, user,false);
			
			getLogger().info("External Elastic Search Service: trying to call service with input body '{}' ...", this.jsonObjectMapper.writeValueAsString(jsonRequestBody));
			
			this.jsonObjectMapper.writeValue(conn.getOutputStream(), jsonRequestBody);
			conn.getOutputStream().close();

			if (conn.getResponseCode() != 200) {
				
				String errorMsg = "External Elastic Search Service responded with HttpResponse: " + conn.getResponseCode() + " " + conn.getResponseMessage();
				getLogger().error(errorMsg);
				throw new RuntimeException(errorMsg);
				
			}
			
			JsonNode jsonResponseBody = this.jsonObjectMapper.readTree(conn.getInputStream());
			conn.getInputStream().close();
			
			getLogger().info("External Elastic Search Service: received response from service with output body '{}'.", this.jsonObjectMapper.writeValueAsString(jsonResponseBody));
			
			Iterator<JsonNode> hitsElementIterator = jsonResponseBody.get("hits").get("hits").elements();
			
			while (hitsElementIterator.hasNext()) {
				
				JsonNode hitsElement = hitsElementIterator.next();
				
				DocumentParagraph paragraphElement = new DocumentParagraph();
				paragraphElement.setIndexId(hitsElement.get("_id").asText());
				paragraphElement.setSequence(hitsElement.get("_source").get("paragraphId").asLong());
				paragraphElement.setDocumentIndexId(hitsElement.get("_source").get("documentId").asText());
				paragraphElement.setContent(hitsElement.get("_source").get("content").asText());
				paragraphElement.setMatch(hitsElement.get("_source").get("match").asInt());
				paragraphElement.setView(hitsElement.get("_source").get("view").asInt());
				paragraphElement.setTimestamp(new Date(hitsElement.get("_source").get("timestamp").asLong()));
				paragraphElement.setPage(hitsElement.get("_source").get("page").asInt());
				paragraphElement.setDocumentName(hitsElement.get("_source").get("documentName").asText());
				paragraphElement.setDocumentPath(hitsElement.get("_source").get("documentPath").asText());
				
				response.add(paragraphElement);
				
			}
			
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		
		return response;
		
	}