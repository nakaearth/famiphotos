$ ->
  InformationBox = React.createClass
    render: ->
      `<div className='informationBox'/>`

  console.log($('#famiphoto_message'))
  console.log($('#famiphoto_message'))
  React.render(`<InformationBox url = "/api/informations" pollInterval={ 2000 } />`, $('#top_page')[0])
