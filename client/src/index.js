import React, { Component } from 'react'
import { render } from 'react-dom'

class App extends Component {
  render() {
    const { title } = this.props
    const { comment } = this.props

    let  items = ['test', 'hoge']
    for (let i = 0; i < items.length; i++) {
      console.log(i);
      console.log(items[i]);
    }

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
