import React, { Component } from 'react'
import { render } from 'react-dom'

class PhotoViewerList extends Component {
  render() {
    return (
      <ul>
        { this.props.items.map((item, index) => (
          <li key= {index}>{item}</li>
        ))}
      </ul>
    );
  }
}

class PhotoViewer extends Component {
  constructor(props) {
    super(props);
    this.state = {photos: [], text: ''};
  }

  render() {
    const { title } = this.props
    const { photos } = this.state.photos

    return (
      <div>
        <h3>{title}</h3>
        <form onSubmit={this.handleSubmit.bind(this)}>
          <input onChange={this.handleChange.bind(this)} value={this.state.text} />
          <button>Add</button>
        </form>
        <PhotoViewerList photos={this.state.photos} />
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
