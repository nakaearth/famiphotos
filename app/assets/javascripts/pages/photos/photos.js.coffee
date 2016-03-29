$(document).on('ready page:load', ->

  console.log 'hoge'
  if $(".photo_list")[0]
    new Vue(
      el: ".photo_list"
      data:
        photos: rails.objPhotos
    )

  return
)
