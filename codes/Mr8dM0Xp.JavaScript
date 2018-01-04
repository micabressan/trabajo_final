 function onOpen(e) {
   SpreadsheetApp.getUi()
       .createMenu('Refresh')
       .addItem('Refresh', 'updateSheet')
       .addToUi();
 }

function getPrice (name,dummy) {
  var url = "https://api.coinmarketcap.com/v1/ticker/" + name + "?convert=USD"
  var response = UrlFetchApp.fetch(url);
  var json = response.getContentText();
  var data = JSON.parse(json); 
  
  var priceval = {"USD" : data[0].price_usd }
  
  var price = priceval["USD"]
  
  return Number(price)
}

function updateSheet() {
  var sheet = SpreadsheetApp.getActiveSpreadsheet().getRange('A1').setValue(new Date().toTimeString());
}