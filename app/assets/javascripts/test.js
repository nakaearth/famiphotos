'use strict'

$ ->
  return if _.max([
    $('#page-any-time-revisions').length,
    $('#page-regular-revisions').length
  ]) is 0


  class RevisionValidator
    selector: '.js-revision-validator'

    constructor: ->
      @init()

    init: ->
      @setEvents()

    setEvents: ->
      $.subscribe 'pa:remote_modal:show', @onPaRemoteModalShow

    onPaRemoteModalShow: (_e, _modal_element) =>
      @setValidator()

    setValidator: ($root = App.$body.find(@selector)) ->
      return if $root.length is 0

      if $root.is 'form'
        $root.validate()

      $root.find('input').each ->
        $form_element = $(@)

        if $form_element.is '[name*="amount_in_kind"]'
          $form_element.rules 'add',  App.validations['revision']['rules']['amount_in_kind']

        if $form_element.is '[name*="amount_in_salary"]'
          $form_element.rules 'add',  App.validations['revision']['rules']['amount_in_salary']

        if $form_element.is '[name*="base_number_of_day"]'
          $form_element.rules 'add',  App.validations['revision']['rules']['base_number_of_day']

        if $form_element.is '[name*="retroactivity_payment_sum"]'
          $form_element.rules 'add',  App.validations['revision']['rules']['retroactivity_payment_sum']

        if $form_element.is '[name*="fix_total_payment_average"]'
          $form_element.rules 'add',  App.validations['revision']['rules']['fix_total_payment_average']

        if $form_element.is '[name*="balance_of_salary"]'
          $form_element.rules 'add',  App.validations['revision']['rules']['balance_of_salary']


  new RevisionValidator
