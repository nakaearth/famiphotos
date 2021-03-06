'use strict'

$ ->
  return if $('#page-photos').length is 0

  class PhotoViewer
    selectors:
      detail: '.photo-detail',
      open_link: '.open_photo_view'
      photo_list: '.photo_list'

    constructor: ->
      @init()

    init: ->
      @setEvents()

    setEvents: ->
      $('#page-photos').on 'ajax:success', @selectors['open_link'], @onSuccess

    onSuccess: (event,  response,  _xhr_status) =>
      $(@selectors['photo_list']).empty().append(response)


  new PhotoViewer
