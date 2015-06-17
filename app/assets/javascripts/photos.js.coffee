'use strict'

$ ->

  class PhotoViewer
    selector: '.photo-detail'

    constructor: ->
      console.log 'hoge'
      @init()

    init: ->
      @setEvents()

    setEvents:  ->
      $.on 'click', (e) =>
        target = $(e.currentTarget)
        console.log(target.id)

  new PhotoViewer

