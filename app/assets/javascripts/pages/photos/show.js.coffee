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
      console.log('hoge')
      $('#page-photos').on 'click', @selectors['open_link'], @onClick

    onClick: (e) =>
      $target_photo = $(event.target)
      $root         = $target_photo.parent()

      $root.find(@selectors['detail']).empty()
      console.log($(@selectors['detail']))
      $(@selectors['detail']).fadeIn(3000)


  new PhotoViewer
