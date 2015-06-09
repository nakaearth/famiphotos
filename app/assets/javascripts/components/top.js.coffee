$ ->
  ComponentBox = React.createClass
    render: ->
      '<div className="ComponentBox">Hello Hello</div>'
  React.render '<ComponentBox />',  document.getElementById('content')
