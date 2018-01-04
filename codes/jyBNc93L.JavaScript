// bot.js file

'use strict'

const TelegramBot = require('node-telegram-bot-api')

const config = require('../telegram/config.json')
const bot = new TelegramBot(config.token, {polling: true})

module.exports = bot;

-------------------------------------

// db.js file

'use strict'

const mongoose = require('mongoose')
const config = require('../telegram/config.json')
const url = config.dbURL

module.exports.connect = function connectDB()
{
  // Mongoose initial set-up
  mongoose.Promise = global.Promise
  mongoose.connect(url)

  const db = mongoose.connection

  // Connect to the database and log the success
  db.once('open', () => console.log('Connected to the database successfully.'))

  // Log any errors if there are any in the database
  db.once('on', () => console.log('There was an error in the database.'))
}

-------------------------------------

// index.js file (entry-point in package.json)

const bot = require('../telegram/bot')
const db = require('../telegram/db')
const users = require('./models/users')
db.connect()

if(msg.text == '+1')
  {
    if(msg.reply_to_message != null || msg.reply_to_message != undefined || msg.reply_to_message != '')
    {
      if(msg.reply_to_message.from.id != msg.from.id)
      {
        const query = { id: msg.reply_to_message.from.id }
        const update = { $inc: { karma: 1 } }
        const options = { upsert: true, new: true, setDefaultsOnInsert: true }


        users.findOneAndUpdate(query, update, options).exec().then( user => {
            const botReply = {reply_to_message_id: msg.reply_to_message.message_id, parse_mode: 'Markdown'}

              bot.sendMessage(chatId, `_You have just been given karma! ðŸŽ‰ You currently have ${user.karma} karma_.`, botReply)
            })
		}
	}
}

if(msg.text == '-1')
  {
    if(msg.reply_to_message != null || msg.reply_to_message != undefined || msg.reply_to_message != '')
    {
      if(msg.reply_to_message.from.id != msg.from.id)
      {
        const query = { id: msg.reply_to_message.from.id }
        const update = { $inc: { karma: -1 } }
        const options = { upsert: true, new: true, setDefaultsOnInsert: true }


        users.findOneAndUpdate(query, update, options).exec().then( user => {
            const botReply = {reply_to_message_id: msg.reply_to_message.message_id, parse_mode: 'Markdown'}

              bot.sendMessage(chatId, `_You just lost karma! ðŸ˜¤ You currently have ${user.karma} karma_.`, botReply)
            })
		}
	}
}