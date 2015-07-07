$ ->
  convert = new Showdown.converter()
 
  InformationBox = React.createClass
    render: ->
      `<div className="informationBox">
        Hello, world! 
        <InformationList data={ this.props.data } />
        </div>`

  InformationList = React.createClass
    render: ->
      informationNodes = @props.data.map (information) ->
        '<Information title={ information.title }>{ information.message } </Information>'
        '<div className="informationList">{ informationNodes }</div>'

  Information = React.createClass
    render: ->
      rawMarkup = convert
      `<div className="information">
         <h2 className="informationAuthor">{ this.props.author }</h2>
         <span dangerouslySetInnerHTML={ { __html: rawMarkup } }></span>
       </div>`

  data = $.get("http://localhost:3000/api/informations")

  React.render `<InformationBox data ={ data } />`, $('#famiphoto_message')[0]
