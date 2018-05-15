import React from "react";


export default class Screen extends React.Component {
  render() {
    return (
      	<img src={this.props.imageFile} width="80%" height="80%" />
    );
  }
}