import React from "react";

import Screen from "./Screen.js";

export default class UserDetails extends React.Component {
  constructor() {
    super();
    this.state = {
      userData: null,
      error: null,
      user: null,
      index: 0
    };
  }

   fetchUserDetails() {
      var user = this.props.user;
      if (user != null){
        fetch("/user/"+user)
          .then(response => {
            if (response.ok) {
              return response.json();
            } else {
              throw new Error('Something went wrong ...');
            }
          })
          .then(data => this.setState({ userData: data.user}))
          .catch(error => this.setState({ error }));
      }
    } 

    componentDidMount() {
      this.fetchUserDetails();
    }


    componentDidUpdate(prevProps, prevState) {
      if (this.state.userData === null) {
        this.fetchUserDetails();
      }
    }

  static getDerivedStateFromProps(nextProps, prevState) {
    // Store prevUserId in state so we can compare when props change.
    // Clear out any previously-loaded user data (so we don't render stale stuff).
    if (nextProps.user !== prevState.user) {
      return {
        user: nextProps.user,
        userData: null
      };
    }
    // No state update necessary
    return null;
  }

  render() {
    const { userData,  error } = this.state;

    if (error) {
      return <p>{error.message}</p>;
    }

    var imageFile = null;
    var indexToAll = null;
    if (userData!=null && userData.imageFiles.length > 0){
      imageFile="/screens/"+userData.name+"/"+userData.imageFiles[this.state.index];
      indexToAll = this.state.index + " / " + userData.imageFiles.length;
    }

    return (
      <div className="row justify-content-md-end rounded border border-dark mt-1 bg-white">
        <div className="p-1">
          <span className="btn btn-secondary disabled m-1 btn-sm">{indexToAll}</span>
          <span className="btn btn-secondary disabled m-1 btn-sm">{imageFile}</span>
          <button className="btn btn-secondary m-1 btn-sm" onClick={this.handlePrev.bind(this)} >Prev</button>
          <button className="btn btn-secondary m-1 btn-sm" onClick={this.handleNext.bind(this)} >Next</button>
          <button className="btn btn-warning m-1 btn-sm" onClick={this.handleLast.bind(this)} >Last</button>
        </div>
        <div className="pb-2 pl-2 pr-2">
          <Screen imageFile={imageFile} />
        </div>
      </div>
    );
  }

  handlePrev(){
    var cIdx = this.state.index+1;
    if (cIdx >= this.state.userData.imageFiles.length){
      cIdx = 0;
    }
    this.setState({index: cIdx});
  }
  
  handleNext(){
    var cIdx = this.state.index-1;
    if (cIdx < 0) {
      cIdx = this.state.userData.imageFiles.length-1;
    }
    this.setState({index: cIdx});
  }

  handleLast(){
    this.setState({index: 0});
  }
}