class PhotoViewer
  selector: '.photo-detail'

  constructor: ->
    @init()

  init: ->
    @setEvents()

  setEvents:  ->
    $("#photo_viewer").click ->
      console.log 123


do ->
  $photo_viewer = document.querySelectorAll('.photo_list')

  new PhotoViewer($photo_viewer)

