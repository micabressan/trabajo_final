var aes256 = require('aes256');
var global_key = 'santa';

function cookie_maker(username) {
  var key = global_key;
  var plaintext = process.argv[2];
  var ciphertext = aes256.encrypt(key, plaintext).replace(/\=/g,'');
  var acookie = JSON.stringify({"name":username, "plaintext":plaintext,  "ciphertext":ciphertext});
  return acookie;
};


function cookie_checker(req) {
  try{
      //var key = 'somestupidfuckingkey';
      var key = global_key;
      var thecookie = JSON.parse(req);
      var ciphertext = thecookie.ciphertext;
      var plaintext = aes256.decrypt(key, ciphertext);
      var username = thecookie.name
      var ciphertext2 = process.argv[3];
      var plaintext2 = aes256.decrypt(key, ciphertext2);
      console.log('MANUALLY ENTERED VALUES');
      console.log('  Name: ' + username);
      console.log('  Cipher: ' + ciphertext2);
      console.log('  Decrypted: ' + plaintext2);
      console.log('  Plaintext: ' + thecookie.plaintext);
      console.log('');
      console.log('');
      console.log('ALGORITHMICALLY DERIVED VALUES');
      console.log('  Name: ' + username);
      console.log('  Cipher: ' + ciphertext);
      console.log('  Decrypted: ' + plaintext);
      console.log('  Plaintext: ' + thecookie.plaintext);
      if (plaintext2 === thecookie.plaintext) {
        console.log('This should work!');
      }
  } catch (e) {
      console.log(e);
  }
};

var req = cookie_maker('alabaster.snowball@northpolechristmastown.com');
cookie_checker(req);