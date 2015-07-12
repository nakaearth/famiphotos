$ ->
  InformationBox = React.createClass
    render: ->
      `<div className='informationBox'/>`

  React.render(`<InformationBox url = "/api/informations" pollInterval={ 2000 } />`, $('#famiphoto_message')[0])
