class FamiphotoRemoteModal
  selector: '.js-show-remote-modal'

  modal_count: 0

  constructor: ->
    @init()

  init: ->
    @setEvents()

  setEvents: ->
    $('.user_div').on 'click', ->
      console.log 'ugogugo'
      @onClick();

  onClick: (e) =>
    console.log 'hoge'
    $modal.modal('show');

    # モーダルが表示されたことをグローバルに通知する
    # $.subscribe 'remote_modal:show', ($modal) -> として、
    # 表示されたモーダルを取得することができる
    $modal.one 'shown.bs.modal', =>
      $.publish 'remote_modal:show', $modal

      # イベント発火元の DOM に設定した limiter を解除する
      @activateLimiter link_to_remote_modal

    return true

new FamiphotoRemoteModal
