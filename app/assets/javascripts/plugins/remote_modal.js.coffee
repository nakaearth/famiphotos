class FamiphotoRemoteModal
  selector: '.js-show-remote-modal'
  
  constructor: ->
    @App  = $(window)
    @body = $('body')
    @init()

  init: ->
    @openModal()

  openModal: ->
    console.log 'hogehoge2'
    console.log @body.find(@selector)
    return if @body.find(@selector).length is 0

    @body.find(@selector).modal('show')


new FamiphotoRemoteModal
