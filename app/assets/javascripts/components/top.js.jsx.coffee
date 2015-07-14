$ ->
  InformationBox = React.createClass
    render: ->
      `<div className='informationBox'/>`

  console.log($('#famiphoto_message')[0])
  React.render(`<InformationBox url = "/api/informations" pollInterval={ 2000 } />`, $('#information_page')[0])
