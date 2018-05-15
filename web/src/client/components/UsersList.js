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
    console.log(user);
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
      <div class="row justify-content-md-center">
        {users.map(user =>
          <div class="col-md-auto">
            <button class="btn btn-info" onClick={this.handleClick.bind(this)}  data-key={user.name}>
              {user.name}
            </button>
          </div>
        )}
      </div>
    );
  }
}