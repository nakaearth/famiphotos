$ ->

  converter = new Showdown.converter()

  InformationBox = React.createClass
    render: ->
      `<div className='InformationBox'>
        <h1>Information</h1>
        <InformationList data={ data } />
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

  data = [
    { title: 'Pete Hunt', message: 'This is one comment.' }
    { title: 'Jorden Walke', message: 'This is *another* comment.' }
  ]
  console.log($('famiphoto_message'))
  console.log($('#top_page')[0])
  
  React.render(`<InformationBox date = { data } />`, document.getElementById('famiphoto_message')) 
