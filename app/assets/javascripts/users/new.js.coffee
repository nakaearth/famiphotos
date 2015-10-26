'use strict'

$ ->
  return if $('#users_search_page').length is 0

  class FamiphotoRemoteModal
    selector: '.js-show-remote-modal'
    
    constructor: ->
      @init()

    init: ->
      console.log 'hogehoge'
      @openModal()

    openModal: ->
      console.log 'hogehoge2'
      $('#user-modal').append("<div>ほげ</div>")
      console.log App.$body.find(@selector)
      return if App.$body.find(@selector).length is 0

      App.$body.find(@selector).modal('show')

    new FamiphotoRemoteModal
