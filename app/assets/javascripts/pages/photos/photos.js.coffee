$(document).on('ready page:load', ->

  if $(".photo_list")[0]
    new Vue(
      el: ".photo_list"
      data:
        photos: rails.objPeople
    )

  return
)
