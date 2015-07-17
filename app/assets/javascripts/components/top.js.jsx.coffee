$ ->

  converter = new Showdown.converter()

  information_data = [
    { title: 'Pete Hunt', message: 'This is one comment.' }
    { title: 'Jorden Walke', message: 'This is *another* comment.' }
  ]

  InformationBox = React.createClass
    # 1
    loadInformationFromServer: ->
      $.ajax
        url: @props.url
        dataType: 'json'
      .done (data) =>
        @setState(data: data)
      .fail (xhr, status, err) =>
        console.error @props.url, status, err.toString()
 
    getInitialState: -> data: []
 
    componentDidMount: ->
      @loadInformationFromServer()
      setInterval @loadInformationFromServer, @props.pollInterval

    render: ->
      `<div className='informationBox'>
        <h1>Information</h1>
        <InformationList data={ this.state.data } />
        </div>`

  InformationList = React.createClass
    render: ->
      informationNodes = @props.data.map (information) ->
        `<Information author={ information.title }>{ information.title }</Information>`
      `<div className="commentList">{ informationNodes }</div>`

  Information = React.createClass
    render: ->
      rawMarkup = converter.makeHtml @props.children.toString()
      `<div className="information">
         <h2 className="informatinTitle">{ this.props.title }</h2>
         <span dangerouslySetInnerHTML={ { __html: rawMarkup } }></span>
       </div>`

  React.render(`<InformationBox url='/api/informations' pollInterval= { 2000 } />`, document.getElementById('famiphoto_message'))
