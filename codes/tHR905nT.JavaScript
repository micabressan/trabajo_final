
  render() {
  	let style = {background: 'blue'}
  	if(!this.state.profile){
  		return <p>"loading"</p>
  	}
  	else{
    return (
      <div>
      {this.state.profile.map((event,i)=> <Profile src={event.results[0].picture.large} name={event.results[0].name.first} className={Profile} key={i}/>)}
      </div>
    )
  }
}
}