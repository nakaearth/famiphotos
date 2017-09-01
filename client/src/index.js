import React, { Component } from 'react'
import { render } from 'react-dom'
import { PhotoViewer, PhotoViewerList } from './photoViewer.js'

render(
  <PhotoViewer title="共有写真" url='/api/informations' pollInterval={2000} />,
  document.getElementById('container'))
