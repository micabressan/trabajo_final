// Schema i nazewnictwo

// ProductModel = to co przychodzi teraz w [GET] w Katalogu

// PendingProductModel = ProductModel rozszerzony o :
// -uploadDisplayTitle - 'Manulal' / 'Automatic' (przychodzi przedłumaczone)
// -uploadTypeId - 1 dla Automatic, 2 dla Manulal
// -proccesingStatusId - 1: Created, 2(...) Encoding/Processing (czyli status z którego bedzie wyliczany fake procent)
// -manualIngestionData

// manualIngestionData - bedzie zawierał dane z formualrza które nie znajduja sie w ProductModel

// każdy child product (product.products) dla PendingProductModel bedzie dodatkowo rozszeżony o manualIngestionData
// Przykladowo:

{
  displayArtist: "Various Artists" // [REQUIRED TO PUBLISH]
  displayTitle: "Parent product (album)", // [REQUIRED TO PUBLISH]
  thumbnailUrl: "https://msdkfsd.dfsd/sdf.jpg", // [REQUIRED TO PUBLISH]
  thumbnailErrorId: 1, // [GET ONLY]
  typeId: 1, // [REQUIRED TO PUBLISH]
  ownerSpecificCode: "A10302B00029965835", // UPC/EAN
  description: "super album",
  genre: "Pop",  // [REQUIRED TO PUBLISH]

  contributor: [
    {id: 269562, artistRoleId: 4, artistRoleName: "Composer", contributorName: "Chelo Villarreal"}, // kiedy nie ma wartoscie contributorName, zapisuje user name (tylko przy POST)
    {id: 269562, artistRoleId: 5, artistRoleName: "Lyricist", contributorName: "Chelo Villarreal"}, // kiedy nie ma wartoscie contributorName, zapisuje user name (tylko przy POST)
  ],

  pline: "", // kiedy nie ma wartoscie contributorName, zapisuje user name (tylko przy POST)

  (...) /// pozostale dostepne flagi z ProductModel [GET ONLY]

  uploadDisplayTitle: "Manual", // [GET ONLY]
  uploadTypeId: 2, // [GET ONLY]
  proccesingStatusId: 1, // [GET ONLY]


  manualIngestionData: {
    artistShare: 2.00, // [REQUIRED TO PUBLISH]
    countryCodes: ["GB", "DE"], // Pusta tablica znaczy ze jest dostepny wszedzie
    countryCodesOperand: 'in' //  [REQUIRED TO PUBLISH] in/not_in
    releaseData: 12312312312, // [REQUIRED TO PUBLISH] timestamp,
    preorderData: 12312312312, // timestamp,
    copyright: "copyright by jacek 2015", //  [REQUIRED TO PUBLISH]
    credits: "jacek sroga",

  }

  products: [
    {
      displayArtist: "Child product 1",  // [REQUIRED TO PUBLISH]
      displayTitle: "Child Title (Track)",  // [REQUIRED TO PUBLISH]
      ownerSpecificCode: "A10302B00029965835", // ISRC
      description: "super track",
      (...) /// pozostale dostepne flagi z ProductModel [GET ONLY]
      manualIngestionData: {
        trackExternalId: "2312983091823091", // [REQUIRED TO PUBLISH]
        trackFileErrorId: 1, // [GET ONLY]
        artistShare: 2.00, //  moze byc null - oznacza wtedy, ze track nie jest dostepny do kupienia jako single track; 
        releaseData: 12312312312, //  [REQUIRED TO PUBLISH] timestamp, brane pod uwage kiedy artisShare != null. Wartość null oznacza tą samą date co album
        preorderData: 12312312312, // timestamp, brane pod uwage kiedy artisShare != null. Wartość null oznacza tą samą date co album
        explicit: false, // true/false
        allowStreming: true, // true/false
        credits: "jacek sroga",

      },

    {
      displayArtist: "Child product 2"
      (...) /// dostepne flagi z ProductModel

      manualIngestionData: {
        // manualIngestionData
      },

  ]
}


Metody:

[POST] /media/addTrack - multifile form data, NIE tworzy nowego resourca, zwraca -

{
  displayArtist: "Child product 1",  
  displayTitle: "Child Title (Track)",
  manualIngestionData: {
    trackExternalId: "2312983091823091", 
    trackFileError: 1,
  }
}



[POST] /products/ 
[GET] /products/{id} 
[PUT] /products/{id} - dostaje cały PendingProductModel i aktualizuje go
[DELETE] /products/{id}
[POST] /products/{id}/publish