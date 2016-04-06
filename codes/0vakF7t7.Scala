 for{
      hotel <- queryBronzeHotel0(preparedUrlBuilder, dateFrom, dateTo, CriteriaLevel.HIGH)
      hotel <-  if(!checkHotel(hotel) queryBronzeHotel0(preparedUrlBuilder, dateFrom, dateTo, CriteriaLevel.MEDIUM) else Future(Hotel)
      hotel <-  if(!checkHotel(hotel) queryBronzeHotel0(preparedUrlBuilder, dateFrom, dateTo, CriteriaLevel.LOW) else Future(Hotel)
    } yield (hotel )