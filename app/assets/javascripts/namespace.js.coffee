'use strict'

$ ->
  window.App ?= {}

  # 頻繁に使用するセレクタをキャッシュしておく
  App.$window   ?= $(window)
  App.$document ?= $(document)
  App.$body     ?= $('body')

  # js-routes のクラスを App のネームスペースに移動する
  App.routes ?= Routes

  # plugins ディレクトリのクラス用ネームスペース
  App.plugins ?= {}

  # アプリケーション内で固有の定数用ネームスペース
  App.constants ?= {}

  # バリデーションルール用ネームスペース
  App.validations ?= {}
