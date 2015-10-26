class FamiphotoRemoteModal
  selector: '.js-show-remote-modal'
  
  constructor: ->
    @init()

  init: ->
    @openModal()

  openModal: ->
    console.log 'hogehoge2'
    return if window.document.body.getElementsByClassName(@selector).length is 0
    return if window.document.body.find(@selector).length is 0

    App.window.document.body.find(@selector).modal('show')


new FamiphotoRemoteModal
