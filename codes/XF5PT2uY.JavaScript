client.on('message', message => {
  if (message.content.startsWith(prefix + '8ball')) {
    message.delete()
    var args = message.content.substr(7);
    var response = [];
    response.push("Le bot n'est pas encore config !");
    response.push("It is decidedly so");
    response.push("Without a doubt");
    response.push("Yes, definitely");
    response.push("You may rely on it");
    response.push("As I see it, yes");
    response.push("Most likely");
    response.push("Outlook good");
    response.push("Yes");
    response.push("Signs point to yes");
    response.push("Reply hazy try again");
    response.push("Ask again later");
    response.push("Better not tell you now");
    response.push("Cannot predict now");
    response.push("Concentrate and ask again");
    response.push("Don't count on it");
    response.push("My reply is no");
    response.push("My sources say no");
    response.push("Outlook not so good");
    response.push("Very doubtful");

    var responsenum = Math.floor((Math.random())*20)
    message.channel.send('', { embed: {
      color: 0x65FF65,
      author: {
        name: message.author.username,
        icon_url: 'https://images-ext-1.discordapp.net/external/QtNcytcGoKEGXmxKO4hAhH0EGyaAkKRAj1VO0r4tAqs/http/www.mystic8ball.com/img/ajax-8ball.gif',
      },
      title: '',
      url: '',
     fields: [
       {
         name: 'Question Posée:',
         value: `${args}`,
       },{
         name: 'Ma Réponse:',
         value: response[responsenum],
       },
     ],
     footer: {
       text: client.user.username,
       icon_url: client.user.avatarURL,
     },
    }})
  }