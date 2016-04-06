final PassengerDataProcessor passengerDataProcessor = new PassengerDataProcessor();
        service.registerBuilder(PassengerData.class, passengerDataProcessor);
        dataRegistry.registerDataProcessorAndImpl(PassengerData.class, SpongePassengerData.class,
                                                  ImmutablePassengerData.class, ImmutableSpongePassengerData.class, passengerDataProcessor);