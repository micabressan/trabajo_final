const chalk = require('chalk');
const moment = require('moment');
const levels = {
  error: 0,
  warn: 1,
  info: 2,
  http: 3,
  verbose: 4,
  debug: 5,
  silly: 6
};

const colors = {
  error: 'red',
  warn: 'yellow',
  info: 'green',
  http: 'green',
  verbose: 'cyan',
  debug: 'blue',
  silly: 'magenta'
}

const setLogFunction = (levels, colors, LOG_LEVEL) => level => (...args) => {
  if (levels[level] <= (levels[process.env.LOG_LEVEL] || 2)) {
    args.map(arg => {
      if (typeof arg === 'object') {
        arg = JSON.stringify(arg, null, '  ');
      }
      const time = `[${moment().format('DD/MM/YY HH:mm:ss')}]`;
      const info = `[${level}]: ${arg}`;
      console.log(`${time} ${chalk[colors[level]](info)}`);
    });
  }
};

const getLogFunction = setLogFunction(levels, colors, process.env.LOG_LEVEL);
const logger = {};
Object.keys(levels).map(level => {
  logger[level] = getLogFunction(level);
});

module.exports = logger;