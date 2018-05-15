import React from "react";


export default class Screen extends React.Component {
  render() {
  	if (this.props.imageFile == null){
  		return (<div/>);
  	}
    return (
      	<img src={this.props.imageFile} className="rounded" 
      	style={{display: "block", maxWidth: "100%", height: "auto"}}/>
    );
  }
}