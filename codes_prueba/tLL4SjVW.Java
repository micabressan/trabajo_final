@RequestMapping(value = "/addmeal", method = RequestMethod.POST)
    @ResponseBody
    public String requestBodyExample(@RequestBody Meal meal) {
        
        menu.addItem(meal);
        ArrayList<Meal> bodyMealList = menu.getItemsByLanguage(0);
        return bodyMealList.toString();
    }