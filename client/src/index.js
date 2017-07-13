import React, { Component } from 'react'
import { render } from 'react-dom'

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
    this.state = {items: ["hoge","hogehoge","fugaga"]};
  }

  render() {
    const { title } = this.props
    const { comment } = this.props
    const { items } = this.state.items

    return (
      <div>
        <h1>{title}</h1>
        <h1>{comment}</h1>
        <AppList items={this.state.items} />
      </div>
    );
  }
}

render(
  <App title="Hello React" comment="ほげホゲホゲ" />,
  document.getElementById('container'))
