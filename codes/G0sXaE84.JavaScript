// 1. Setup passporta
import User from '../user/userSchema'
import { Strategy, ExtractJwt } from 'passport-jwt';
import passport from 'passport'

passport.use(new Strategy(params, (payload, done) => {
    User.findOne({ email: payload.email }).then(user => {
      if (user) {
        return done(null, { user });
      }

      return done(new Error('User not found'), null);
    }).catch(() => done(new Error('Error'), null));
  }));

// 2. Podpinasz do apki

app.use(passport.initialize());

// 3. Kontrolery
// authCtrl
export const signIn = (req, res) => {
    if (req.body.email && req.body.password) {
      let email = req.body.email;
      let password = req.body.password;
      let _user;
  
      if (!emailValidator.validate(email)) {
        res.sendStatus(400);
  
        return Promise.reject()
      }
  
      User.findOne({ email }).then(user => {
        if (user) {
          _user = user;
  
          return passwordCrypt.compare(password, _user.password);
        }
  
        return Promise.reject()
      }).then(isCorrectPassword => {
        if (isCorrectPassword) {
          let payload = { email: _user.email };
          let token = jwt.sign(payload, config.jwt.secret, { expiresIn: config.jwt.expiresIn });
          res.json({ token });
        } else {
          return Promise.reject()
        }
      }).catch(() => {
        res.sendStatus(401);
      });
    } else {
      res.sendStatus(400);
    }
  };
  
  export const signUp = (req, res) => {
    if (req.body.email && req.body.password) {
      let email = req.body.email;
      let password = req.body.password;
  
      if (!emailValidator.validate(email)) {
        res.sendStatus(400);
  
        return Promise.reject()
      }
  
      passwordCrypt.hash(password, config.password.saltRounds).then(hashedPassword => User.create({
          email,
          password: hashedPassword
        })).then(user => {
        let _user = user.toObject();
        delete _user.password;
        res.json(_user)
      }).catch(() => {
        res.sendStatus(401);
      })
    } else {
      res.sendStatus(400);
    }
  };


// 4. Routing

const router = express.Router();

router.get('/', passport.authenticate('jwt', config.jwt.session), (req, res) => {
  res.json(req.user);
});

router.post('/signIn', (req, res) => {
  authCtrl.signIn(req, res)
});

router.post('/signUp', (req, res) => {
  authCtrl.signUp(req, res)
});


app.use('/auth', router);