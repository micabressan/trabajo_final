RestTemplate template = new RestTemplate();
        ResponseEntity<String> response =
                template.postForEntity("http://localhost:8080/meal", newMeal, String.class);

LUB


        HttpEntity entity = new HttpEntity(newMeal);
        ResponseEntity<String> response =
                template.exchange("http://localhost:8080/meal", HttpMethod.POST, entity, String.class);