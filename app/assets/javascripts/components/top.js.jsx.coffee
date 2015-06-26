$ ->
  InformationBox = React.createClass
    render: ->
      `<div className="InformationBox">
        Hello, world! 
        <InformationList data= { this.props.data } />
        </div>`

  InformationList = React.createClass
    render: ->
      informationNodes = @props.data.map (information) ->
        '<Information title={ information.title }>{ information.message } </Information>'

  React.render `<InformationBox />`, document.getElementById('famiphoto_message')
