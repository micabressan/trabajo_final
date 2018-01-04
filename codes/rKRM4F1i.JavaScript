var queryString = Math.random();

function getData() {
  
  //
  //IMPORTANT: Create a sheet called 'Rates'.  This is where the values will be written
  //
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var ssRates = ss.getSheetByName('Rates');
  
  //Add coins to track. Go to the CoinMarketCap page for the currency, click tools (e.g. https://api.coinmarketcap.com/v1/ticker/bitcoin/)
  var coins = ['bitcoin','bitcoin-cash','ethereum','eos','iota','bitcoin-gold','ripple','cardano','bitcoin-diamond','raiblocks'];
  
  var coinCount = coins.length;
  
  for (var i = 0; i < coinCount; i++) {
    //Grabbing values from CoinMarketCapAPI
    var coinData = getAPIRate(coins[i]);
    
    //Setting values in a sheet called 'Rates' in columns A,B etc. starting at row 2.
    ssRates.getRange('A'+(i+2).toString()).setValue(coinData['symbol']);
    ssRates.getRange('B'+(i+2).toString()).setValue(coinData['name']);
    ssRates.getRange('C'+(i+2).toString()).setValue(coinData['usd']);
    ssRates.getRange('D'+(i+2).toString()).setValue(coinData['btc']);
    ssRates.getRange('L'+(i+2).toString()).setValue(coinData['24h']);
    ssRates.getRange('M'+(i+2).toString()).setValue(coinData['7d']);
  }
}

function getAPIRate(currencyId) {

  var url = 'https://api.coinmarketcap.com/v1/ticker/' + currencyId + '/';
  var response = UrlFetchApp.fetch(url, {'muteHttpExceptions': true});
  var json = response.getContentText();
  var data = JSON.parse(json);
  
  var obj = new Object();
  if (data[0]) {
    obj['usd'] = parseFloat(data[0]['price_usd']);
    obj['btc'] = parseFloat(data[0]['price_btc']);
    obj['24h'] = parseFloat(data[0]['percent_change_24h']);
    obj['7d'] = parseFloat(data[0]['percent_change_7d']);
    obj['symbol'] = data[0]['symbol'];
    obj['name'] = data[0]['name'];
  }
  else {
    obj['usd'] = 0;
    obj['btc'] = 0;
    obj['24h'] = 0;
    obj['7d'] = 0;
    obj['symbol'] = '???';
    obj['name'] = '???';
  }
  return obj;
}