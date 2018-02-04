import React, { Component } from 'react';
import LastSearch from './LastSearch';
import './App.css';
import {withScriptjs, withGoogleMap, GoogleMap, Marker } from "react-google-maps";

const MapWithAMarker = withScriptjs(withGoogleMap(props =>
  <GoogleMap
    defaultZoom={6}
    defaultCenter={{ lat: props.lat, lng: props.lng }}
  >
    <Marker
      position={{ lat: props.lat, lng: props.lng }}
    />
  </GoogleMap>
));

class App extends Component {
  constructor(){
    super();
    this.state = {
      lastSearch: [],
      lat: 0,
      lng: 0
    }
  }

  fetchData(query = '') {
    const url = `//freegeoip.net/json/${query}`;

    fetch(url, {
      method: 'GET',
      headers: {}
    })
    .then(response => {
      response = response.json();
      console.log(response, 'response');
      return response;
    })
      .then(data => {
        console.log(data, 'data');
        let lat = data.latitude;
        let lng = data.longitude;
        this.setState({
          lat,
          lng
        })
      })
  }
  
  componentDidMount() {
    this.fetchData();
  }


  onSubmitIp(e) {
    e.preventDefault();
    const ipMatch = this.refs.query.value.match(/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/);
    if(ipMatch === null) {
      alert(`wrong ip`);
    }else {
    this.fetchData(this.refs.query.value);
    this.state.lastSearch.push(this.refs.query.value); 
    console.log(this.state.lastSearch, 'push');
  }
  }

  render() {
    return (
      <div>
        <LastSearch lastSearch = {this.state.lastSearch}/>
        <MapWithAMarker
          lat = {this.state.lat}
          lng = {this.state.lng}
          googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4R6AN7SmujjPUIGKdyao2Kqitzr1kiRg&v=3.exp&libraries=geometry,drawing,places"
          loadingElement={<div style={{ height: `100%` }} />}
          containerElement={<div style={{ height: `400px`, width:`50%`, margin:`auto` }} />}
          mapElement={<div style={{ height: `100%` }} />}
        />
      <form>
        <input type='text' ref='query' placeholder='Enter ip here'></input>
        <input type='submit' onClick={e => {this.onSubmitIp(e)}}></input>
      </form>
        <MapWithAMarker
          lat = {this.state.lat}
          lng = {this.state.lng}
          googleMapURL="https://maps.googleapis.com/maps/api/js?key=AIzaSyC4R6AN7SmujjPUIGKdyao2Kqitzr1kiRg&v=3.exp&libraries=geometry,drawing,places"
          loadingElement={<div style={{ height: `100%` }} />}
          containerElement={<div style={{ height: `400px`, width:`50%`, margin:`auto` }} />}
          mapElement={<div style={{ height: `100%` }} />}
        />   
    </div>
    );
  }
}

export default App;