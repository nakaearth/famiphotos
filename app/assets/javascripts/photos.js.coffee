'use strict'

$ ->

  class PhotoViewer
    selector: '.photo-detail'

    constructor: ->
      @init()

    init: ->
      @setEvents()

    setEvents:  ->
      $("#photo_viewer").click ->
        console.log 123

  new PhotoViewer

