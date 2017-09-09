import React, { Component } from 'react'
import { render } from 'react-dom'

export class PhotoList extends Component {
  render() {
    return (
      <ul>
        { this.props.photos.map((photo) => (
          <div key={"photo_view_" + photo.id} id={photo.id}>
            <img src={photo.thumb_url} alt={photo.title} id={"photo_" + photo.id}/>
            <a data-toggle="modal" data-target={"#photo_view_" + photo.id} data-backdrop="false" href={"#photo_view_" + photo.id}>拡大</a>
            <div aria-hidden='true' className='modal fade photo_default_modal' id={'photo_view_' + photo.id} role='dialog' tabIndex='-1'>
              <div className='modal-dialog modal-content photo_detail'>
                <img src={photo.original_url} alt='写真拡大' data-dismiss='modal'/>
              </div>
            </div>
          </div>
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
  }

  render() {
    const { title } = this.props
    const { photos } = this.state.photos

    return (
      <div>
        <h3>{title}</h3>
        <PhotoList photos={this.state.photos} />
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
