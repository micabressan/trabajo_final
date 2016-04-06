$ npm run serve-site-test

> tvevt-spa@1.0.0 serve-site-test /home/tvevt.com/static
> export NODE_ENV=production && export TVEVT_BASEHOST=https://test.tvevt.com && export TVEVT_APIHOST=https://test.tvevt.com/api && node ./site/server/production.js


module.js:340
    throw err;
          ^
Error: Cannot find module 'request-ip'
    at Function.Module._resolveFilename (module.js:338:15)
    at Function.Module._load (module.js:280:25)
    at Module.require (module.js:364:17)
    at require (module.js:380:17)
    at Object.<anonymous> (/home/tvevt.com/static/site/server/isomorphic-app.js:5:37)
    at Module._compile (module.js:456:26)
    at normalLoader (/home/tvevt.com/static/node_modules/babel/node_modules/babel-core/lib/api/register/node.js:199:5)
    at Object.require.extensions.(anonymous function) [as .js] (/home/tvevt.com/static/node_modules/babel/node_modules/babel-core/lib/api/register/node.js:216:7)
    at Module.load (module.js:356:32)
    at Function.Module._load (module.js:312:12)
npm ERR! weird error 8
npm WARN This failure might be due to the use of legacy binary "node"
npm WARN For further explanations, please read
/usr/share/doc/nodejs/README.Debian
 
npm ERR! not ok code 0