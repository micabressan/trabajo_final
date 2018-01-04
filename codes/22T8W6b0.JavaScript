import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';

class Profile extends Component {


  constructor(props){
    super(props)
    this.state = {

    }
  }
  
  componentDidMount(){
  }

  render() {
    return (
      <div>
      <img src={this.props.src}/>
      <p>{this.props.name}</p>
      </div>
    )
  }
}

export default Profile;