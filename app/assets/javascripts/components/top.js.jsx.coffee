$ ->
  InformationBox = React.createClass
    render: ->
      `<div className='informationBox'/>`

  console.log($('#famiphoto_message'))
  $root = App.$body.find('#top_page')
  console.log $root
  
  $element = $root.find('#famiphoto_message')
  console.log $element
  React.render(`<InformationBox url = "/api/informations" pollInterval={ 2000 } />`, $('#top_page')[0])
