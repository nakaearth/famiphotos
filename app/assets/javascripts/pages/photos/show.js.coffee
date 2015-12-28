'use strict'

$ ->
  return if $('#page-photos').length is 0

  class PhotoViewer
    selectors:
      detail: '.photo-detail',
      open_link: '.open_photo_view'

    constructor: ->
      @init()

    init: ->
      @setEvents()

    setEvents: ->
      $('#page-photos').on 'click', @selectors['open_link'], @onClick

    onClick: (e) =>
      $(@selectors['detail']).css 'display', 'block'
      console.log($(@selectors['detail']).css)
      $(@selectors['detail']).fadeIn(3000)


  new PhotoViewer
