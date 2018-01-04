const Canvas = require("canvas");
const snek = require("snekfetch");
const fsn = require("fs-nextra");
const GIFEncoder = require("gifencoder");

exports.run = async (client, message, args) => { 
        try {
      const target = message.author
      const msg = await message.channel.send(`Triggering...${target.tag}`);
      const stepped = message.author.displayAvatarURL
      const test = stepped.replace(/\.(gif|jpg|png|jpeg)\?size=2048/g, '.png?size=512');
      const attachment = await getTriggered(test);
      await message.channel.send({ files: [{ attachment, name: "triggered.gif" }] });
      await msg.delete();
    } catch (error) {
      console.log(error);
    }
  }
  
  function asyncgetTriggered(triggered) {
    const imgTitle = new Canvas.Image();
    const imgTriggered = new Canvas.Image();
    const encoder = new GIFEncoder(256, 256);
    const canvas = new Canvas.createCanvas(256, 256);
    const ctx = canvas.getContext("2d");
    imgTitle.src = fsn.readFile("./assets/plate_triggered.png");
    imgTriggered.src = snek.get(triggered).then(res => res.body);
    const stream = encoder.createReadStream();
    encoder.start();
    encoder.setRepeat(0);
    encoder.setDelay(50);
    encoder.setQuality(200);
    const coord1 = [-25, -33, -42, -14];
    const coord2 = [-25, -13, -34, -10];
    for (let i = 0; i < 4; i++) {
      ctx.drawImage(imgTriggered, coord1[i], coord2[i], 300, 300);
      ctx.fillStyle = "rgba(255 , 100, 0, 0.4)";
      ctx.drawImage(imgTitle, 0, 218, 256, 38);
      ctx.fillRect(0, 0, 256, 256);
      encoder.addFrame(ctx);
    }
    encoder.finish();
    return this.streamToArray(stream).then(Buffer.concat);
  }

  function streamToArray(stream) {
    if (!stream.readable) return Promise.resolve([]);
    return new Promise((resolve, reject) => {
      const array = [];
  
      function onData(data) {
        array.push(data);
      }
  
      function onEnd(error) {
        if (error) reject(error);
        else resolve(array);
        cleanup();
      }
  
      function onClose() {
        resolve(array);
        cleanup();
      }
  
      function cleanup() {
        stream.removeListener("data", onData);
        stream.removeListener("end", onEnd);
        stream.removeListener("error", onEnd);
        stream.removeListener("close", onClose);
      }
  
      stream.on("data", onData);
      stream.on("end", onEnd);
      stream.on("error", onEnd);
      stream.on("close", onClose);
    });
  }
  

  exports.conf = {
    enabled: true,
    guildOnly: false,
    aliases: [],
    permLevel: 0
  };
  
  exports.help = {
    name: 'triggered',
    description: 'get triggered.',
    usage: 'triggered'
  };