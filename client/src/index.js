import React, { Component } from 'react'
import { render } from 'react-dom'
import { PhotoViewer, PhotoViewerList } from './photoViewer.js'

var dir          = location.href.split("/");
var id_and_query = dir[dir.length -1];
var ids = id_and_query.split("?");
var id  = ids[0];
console.log(id);
var search_url = '/api/shared_albums/' + id;
console.log(search_url);
render(
  <PhotoViewer title="共有写真" url={search_url} pollInterval={2000} />,
  document.getElementById('container'))
