'use strict'

$ ->

  class PhotoViewer
    selector: '.photo-detail'

    constructor: ->
      @init();

    init: ->
      @setEvents()

    setEvents:  ->
      $.on 'click', (e) =>
        target = $(e.currentTarget)
        console.log(target.id)

  new PhotoView

