import React, { Component } from 'react'
import { render } from 'react-dom'

export class PhotoViewerList extends Component {
  render() {
    return (
      <ul>
        { this.props.photos.map((photo) => (
          <img src={photo.thumb_url} alt={photo.title} id='{photo.id}_id'/>
        ))}
      </ul>
    );
  }
}

export class PhotoViewer extends Component {
  constructor(props) {
    super(props);
    this.state = {photos: []};
  }

  loadCommentsFromServer() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({photos: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  componentDidMount() {
    this.loadCommentsFromServer();
    //setInterval(this.loadCommentsFromServer, this.props.pollInterval);
  }

  render() {
    const { title } = this.props
    const { photos } = this.state.photos

    return (
      <div>
        <h3>{title}</h3>
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
