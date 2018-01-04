var mongoose = require('mongoose');

mongoose.Promise = global.Promise;
var promise = mongoose.connect('mongodb://localhost:27017/TodoApp', {

  useMongoClient: true
});

var Todo = mongoose.model('todos', {
  text: {
    type: String
  },
  completed: {
    type: Boolean
  },
  completedAt: {
    type: Number
  }
});

var newTodo = new Todo({
  text: 'Cook dinner'
});

newTodo.save().then((doc) => {
  console.log('Saved todo', doc);
}, (e) => {
  console.log('Unable to save todo');
});