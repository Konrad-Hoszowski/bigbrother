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

   var imageFile=(userData!=null)?"/screens/"+userData.name+"/"+userData.imageFiles[this.state.index] : "null";

    return (
      <div className="row justify-content-md-end rounded border border-dark mt-1 bg-white">
        <div className="p-1">
          <span className="btn btn-secondary disabled m-1 btn-sm">{imageFile}</span>
          <button className="btn btn-secondary m-1 btn-sm" onClick={this.handleNext.bind(this)} >Prev</button>
          <button className="btn btn-secondary m-1 btn-sm" onClick={this.handlePrev.bind(this)} >Next</button>
        </div>
        <div className="pb-2 pl-2 pr-2">
          <Screen imageFile={imageFile} />
        </div>
      </div>
    );
  }

  handleNext(){
    var cIdx = this.state.index+1;
    if (cIdx >= this.state.userData.imageFiles.length){
      cIdx = 0;
    }
    this.setState({index: cIdx});
  }
  
  handlePrev(){
    var cIdx = this.state.index-1;
    if (cIdx <= 0) {
      cIdx = this.state.userData.imageFiles.length-1;
    }
    this.setState({index: cIdx});
  }
}