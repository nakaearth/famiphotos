class PhotoViewer
  _index = 0

  constructor: ->
    @init()

  init: ->
    @$contents = @$el.querySelectorAll('.photo_detail')
    @setEvents()

  setEvents: ->
    $("#photo_viewer").click ->
      @showContent()
      console.log 123

  showContent: ->
    for $content, i in @$contentsa
      if _index is i
        $content.classList.add('is-active')
      else
        $content.classList.remove('is-active')

do ->
  $photo_viewer = document.querySelectorAll('.photo_list')

  new PhotoViewer($photo_viewer)

