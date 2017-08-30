import React, { Component } from 'react'
import { render } from 'react-dom'
import PhotoViewer from './photoViewer.js'

class AppList extends Component {
  render() {
    return (
      <ul>
        {this.props.items.map((item, index) => (
          <li key={index}>{item}</li>
        ))}
      </ul>
    );
  }
}

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {items: [], text: ''};
  }

  render() {
    const { title } = this.props
    const { items } = this.state.items

    return (
      <div>
        <h3>{title}</h3>
        <form onSubmit={this.handleSubmit.bind(this)}>
          <input onChange={this.handleChange.bind(this)} value={this.state.text} />
          <button>Add</button>
        </form>
        <AppList items={this.state.items} />
      </div>
    );
  }

  handleChange(e) {
    this.setState({text: e.target.value});
  }

  handleSubmit(e) {
    e.preventDefault();
    const newItem = this.state.text;
    this.setState((prevState) => ({
      items: prevState.items.concat(newItem),
      text: ''
    }));
  }
}

render(
  <PhotoViewer title="共有写真" url='/api/shared_albums' />,
  document.getElementById('container'))
