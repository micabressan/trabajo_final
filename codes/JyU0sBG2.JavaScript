//hello pastebin user no idea if this works

adminList = []; //put ur _id here
permban = []; //dont worry about this one //note: they dont save, so put anyusers you want to keep permbanned in here

function getUser(name) { //ignore this
  var array = [];
  for (var pl in gClient.ppl) {
    if (gClient.ppl[pl].name.toLowerCase().includes(name.toLowerCase())) {
      array.push(gClient.ppl[pl]);
    }
  }
  return array[Math.floor(Math.random() * array.length)];
}

gClient.on('a', msg => {
  var cmd = msg.a.split(' ')[0].toLowerCase();
  var input = msg.a.substring(cmd.length).trim();
  var target = getUser(input);
  try {
    if (cmd == cmdChar + 'pardon') {
      if (msg.p._id.indexOf(adminList) > -1) {
        if (input === '') {
          sendChat('Usage: L!pardon <user on the perma ban list>');
        } else if (target.name.indexOf(permban) === -1) {
          sendChat('This user is not on the permban list.');
        } else {
          loa.say('Removed user from permban list.');
          permban.slice(getUser(input)._id);
        }
      }
    }
  } catch (e) {
    sendChat('PERM_ENT HAS GONE NUTS -- TELL VINNY HE NUMBA ONE');
  }
});

gClient.on('participant added', msg => {
  if (permban.includes(msg._id)) {
    gClient.sendArray([{ m: 'kickban', _id: msg._id, ms: 3.6e6 }]);
    sendChat(
      `${msg.name} (${msg._id}) is on the perma ban list. Banning from room.`
    );
  } //else welcome them etc
});