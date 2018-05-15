import React from "react";

import Footer from "./Footer";
import Header from "./Header";
import UsersList from "./UsersList";
import UserDetails from "./UserDetails";


export default class Layout extends React.Component {
  constructor() {
    super();
    this.state = {
      user: null,
      title: "Welcome"
    };
  }

  changeUser(user) {
    this.setState({user});
    console.log("changeUser: "+user);
  }

  render() {
    return (
      <div class="container">
        <Header />
        <UsersList changeUser={this.changeUser.bind(this)}/>
        <UserDetails user={this.state.user} />
        <Footer />
      </div>
    );
  }

}
