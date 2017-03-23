'use strict'

$ ->
  return if $('#page-photos').length is 0

  new Vue(
    el: '#simple',
    data:
      msg: 'Hello Vue.js!',
      font: ""
    ,
    methods:
      magnify:
        this.font = "font-size:20px;color:red"
  )
