'use strict'

$ ->
  return if $('#page-photos').length is 0

  class PhotoViewer
    selectors
      detail: '.photo-detail',
      open_link: '.open_photo_view'

    constructor: ->
      @init()

    init: ->
      @setEvents()

    setEvents: ->
      App.$body.on 'click', @selectors['open_link'], @onClick

    onClick: (e) =>
      @selectors['detail'].fadeIn('slow')


  new PhotoView
