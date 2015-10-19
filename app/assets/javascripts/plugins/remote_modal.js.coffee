'use strict'

$ ->
  class App.plugins.RemoteModal
    selector: '.js-show-remote-modal'

    modal_count: 0

    constructor: ->
      @init()

    init: ->
      @setEvents()

    setEvents: ->
      alert('yoge')
      App.$body.on 'click', @selector, @onClick

      App.$body.on 'ajax:success', @selector, @onSuccess

      App.$body.on 'ajax:error', @selector, @onError

    onClick: (e) =>
      # イベント発火元の DOM の limiter プロパティが true なら、
      # 既に同一の DOM から同じイベントが飛んでいるので、処理が終了していない証拠なので
      # ここでスキップする
      return false if e.target.remote_modal_limiter

      # ページ全体で1度に表示可能なモーダルを1つに絞る
      return false if @modal_count isnt 0

      # イベント発火元の DOM に limiter を設定する
      @deActivateLimiter e.currentTarget

      # モーダルの表示数をカウントする
      @modal_count++

    onSuccess: (e, response) =>
      $modal = $(response)
      link_to_remote_modal = e.target

      # モーダルの削除イベントを設定する
      # MEMO: shown だと、開き終わる最中のクリックで、うまくモーダルの削除処理が走らない
      $modal.one 'show.bs.modal', =>
        $modal.on 'click', (e) =>
          # ややこしいけど、 e.currentTarget = $modal[0] で、 e.target はクリックイベントの発火元 DOM
          # e.currentTarget と e.target が一致していれば、backdrop をクリックしたのと同じ意味なので、
          # bootstrap の backdrop クリックイベントと同じ挙動を再現できる
          if e.currentTarget is e.target
            @destroyModal $(e.currentTarget)

            # イベント発火元の DOM に設定した limiter を解除する
            @activateLimiter link_to_remote_modal

        $modal.on 'click', '[data-dismiss="modal"]', =>
          @destroyModal $modal

          # イベント発火元の DOM に設定した limiter を解除する
          @activateLimiter link_to_remote_modal

      $modal.modal('show')

      # モーダルが表示されたことをグローバルに通知する
      # $.subscribe 'remote_modal:show', ($modal) -> として、
      # 表示されたモーダルを取得することができる
      $modal.one 'shown.bs.modal', =>
        $.publish 'remote_modal:show', $modal

        # イベント発火元の DOM に設定した limiter を解除する
        @activateLimiter link_to_remote_modal

      return true

    onError: (e, _response) =>
      # イベント発火元の DOM に設定した limiter を解除する
      @activateLimiter e.target

      return true

    activateLimiter: (target) ->
      target.remote_modal_limiter = false

    deActivateLimiter: (target) ->
      target.remote_modal_limiter = true

    destroyModal: ($modal) ->
      # body から クラスを削除する
      App.$body.removeClass 'modal-open'

      # モーダル自体を削除する
      $modal.remove()

      # モーダルの backdrop を削除する
      # backdrop の削除処理は bootstrap の modal.js を真似する
      # ref: https://github.com/twbs/bootstrap/blob/master/js/modal.js#L186-L236
      $backdrop = App.$body.find('.modal-backdrop')

      # $backdrop のクラスを削除すると、アニメーションがスタートするので
      $backdrop.removeClass 'in'

      # アニメーションが終了次第、$backdrop を削除する
      $backdrop.one 'bsTransitionEnd', ->
        $(@).remove()

      # モーダルの表示数を初期化する
      @modal_count--


  new App.plugins.RemoteModal
