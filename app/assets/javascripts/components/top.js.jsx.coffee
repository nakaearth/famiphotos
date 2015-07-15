$ ->
  InformationBox = React.createClass
    render: ->
      `<div className='informationBox'/>`

  console.log($('famiphoto_message'))
  $root = $.find('#top_page')
  console.log $root
  
  $element = $.find('#famiphoto_message')
  console.log $element
  React.render(`<InformationBox url = "/api/informations" pollInterval={ 2000 } />`, $('#top_page')[0])
