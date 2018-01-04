const app = require('express')();
const sqlite3 = require('sqlite3');
const db = new sqlite3.Database('jokes.db');
const bp = require('body-parser')

/* Using the file jokes.js, ExpressJS, and jokes.db, build an application with the following routes:

/
/add
/joke

/ will return an HTML response with a form with attributes method="POST" and action="/add". 
The form will have two text inputs, setup and punchline, and a submit button.

/add will accept a POST request from the form and enter a new joke into the database, then redirect back to /.

how do make a route response a get request ?
app.get makes a route response to a get request

/joke will return an HTML response with a random joke.

forms take a destination , action ="/add" (this will be in my form)

1. create a file in jokes.js
2. create routes
3. figure out the routes
4. route / create form , two text inputs setup and punchline, then a submit button
5. the inform from route / i need to use for /add route = go to database then redirect back to the homepage
6. route / joke will return a random joke from my database, get everything from my db, get a random from my array 
7.

Math.random(tableength(#ofrows))
*/

app.get('/', (req, res) => {
    res.send(`
    
    <form method="POST" action="/add" >
    Setup:<br>
    <input type="text" name="setup" value="setup">
    <br>
    Punchline:<br>
    <input type="text" name="punchline" value="punchline">
    <br><br>
    <input type="submit" value="Submit">
  </form> 
    
    `)
});

app.post('/add', (req, res) => {
let userSetup = req.body.setup
let userPunchLine = req.body.punchline
  db.post(`
    INSERT INTO jokes (setup, punchline) 
    VALUES ('${userSetup}', '${userPunchLine}');
      `, (err, value) => {
        if (err) {
          res.send(err);
        } else {
          res.json(value);
        }
      });
});

// app.get('/jokes', (req, res) => {
    
// });


app.listen(3000);
Add Comment