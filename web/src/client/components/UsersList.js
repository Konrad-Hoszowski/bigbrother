import React from "react";

export default class UsersList extends React.Component {
  constructor() {
    super();
    this.state = {
      users: [],
      isLoading: false,
      error: null
    };
  }

  componentDidMount() {
      this.setState({ isLoading: true });

      fetch("/users")
        .then(response => {
          if (response.ok) {
            return response.json();
          } else {
            throw new Error('Something went wrong ...');
          }
        })
        .then(data => this.setState({ users: data.users, isLoading: false }))
        .catch(error => this.setState({ error, isLoading: false }));
    }

  handleClick(e) {
    const user = e.target.getAttribute('data-key');
    this.props.changeUser(user);

  }

  render() {
    const { users, isLoading, error } = this.state;

    if (error) {
      return <p>{error.message}</p>;
    }

    if (isLoading) {
      return <p>Loading ...</p>;
    }

    return (
      <div className="row justify-content-md-start rounded border border-info mb-1 p-1 bg-white">
        <span className="btn m-1 btn-sm">Users: </span>
        {users.map(user =>          
            <button className="btn btn-info m-1 btn-sm" onClick={this.handleClick.bind(this)} 
             key={user.name} data-key={user.name}>
              {user.name}
            </button>         
        )}
      </div>
    );
  }
}