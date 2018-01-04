import axios from 'axios'

function get(callback) {
  return axios.get('http://localhost:8000/')
      .then(function (response) {
          let data =  response.data;
          data = data.map(function (item) {
                 item.deadline = new Date(item.deadline)
                 return item;
          });

          callback(data)
      })
}

function create(name, description, deadline, callback) {
    return axios.put('http://localhost:8000', {
        name: name,
        description: description,
        deadline: deadline
    }).then(function (response) {
            callback(response);
        })

}

function remove(id, callback){
    return axios.delete('http://localhost:8000/' + id).then(function (response) {
        callback(response);
    })
}

function update(id, name, description, deadline, callback) {
    return axios.post('http://localhost:8000/' + id, {
        name: name,
        description: description,
        deadline: deadline
    }).then(function (response) {
        callback(response);
    })
}

const TodoService = {
    get, create, remove, update
};

export default TodoService;