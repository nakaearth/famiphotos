class FamiphotoRemoteModal
  selector: '.js-show-remote-modal'
  
  constructor: ->
    @init()

  init: ->
    @openModal()

  openModal: ->
    console.log 'hogehoge2'
    return if App.$body.find(@selector).length is 0

    App.$body.find(@selector).modal('show')


new FamiphotoRemoteModal
