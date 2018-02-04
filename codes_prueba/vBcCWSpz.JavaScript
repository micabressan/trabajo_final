import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import Profile from './Profile'

class App extends Component {


  constructor(props){
    super(props)
    this.state = {

    }
  }
  
  componentDidMount(){
  	let profile = []
  	for(let i = 0; i<=3;i++) {
    fetch("https://randomuser.me/api/")
    .then(response=>response.json())
    .then(data=> profile.push(data))
    .catch(error=>console.log(error+' 1'))
}
	this.setState({profile})
  }



  render() {
  	if(!this.state.profile){
  		return <p>"loading"</p>
  	}
  	else{
    return (
      <div>
      {this.state.profile.map(event=> <Profile src={event.results[0].picture.large} name={event.results[0].name.first}/>)}
      </div>
    )
  }
}
}

export default App;