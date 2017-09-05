import React, { Component } from 'react'
import { render } from 'react-dom'
import { PhotoViewer, PhotoViewerList } from './photoViewer.js'

var dir = location.href.split("/");
var id = dir[dir.length -1];
var search_url = '/api/shared_albumss/' + id;
render(
  <PhotoViewer title="共有写真" url={search_url} pollInterval={2000} />,
  document.getElementById('container'))
