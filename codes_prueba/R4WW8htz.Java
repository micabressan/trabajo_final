/**
* Constructor
*
* @param address    Full Postal Address
* @param postalCode Addressee postal code
* @see http://codereview.stackexchange.com/questions/101772/unit-testing-private-constructors-and-getter-setters
*/
private Address(String address, String postalCode) throws InstantiationException {
    if ((address == null) || (address.equals("")) || (postalCode == null) || (postalCode.equals(""))) {
        throw new InstantiationException("Please provide postal address and/or postal code.");
    } else {
        this.addressId = new BigInteger(256, new Random());
        this.address = address;
        this.postalCode = postalCode;
    }
}

@Test
public void testAddressInstantiation(){
    try {
        final Address address = Address.createAddress("","");
        address.setName("Sandeep");
        address.setContactNo("1234567890");
    }catch(InstantiationException e){
        Assert.assertEquals(e.getLocalizedMessage(),"Please provide postal address and/or postal code.");
    }
}