import React, { Component } from 'react'
import { render } from 'react-dom'

class App extends Component {
  render() {
    const { title } = this.props
    const { comment } = this.props
    const { items } = ['test', 'hoge']
    return (
      <div>
        <h1>{title}</h1>
        <h1>{comment}</h1>
      </div>
    )
  }
}

render(
  <App title="Hello React" comment="ほげホゲホゲ" />,
  document.getElementById('container'))
