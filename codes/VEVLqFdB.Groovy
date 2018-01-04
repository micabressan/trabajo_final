class NewpinFilters {

    def filters = {
        allURIs(uri:'/admin/**', invert:true) {
            after = { model ->
                model.alleCityNews =  newpin.CityNews.findAllByFreigabe(true)
            }
           
        }
    }
    
}