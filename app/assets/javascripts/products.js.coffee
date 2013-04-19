# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ()->
  $("#toggle-check-box").on 'click', (evt)->
    if $(this).prop('checked')
      $('.product-check-box').prop('checked', true)
    else
      $('.product-check-box').prop('checked', false)

  $('#destroy-products-button').on 'click', (evt)->
    evt.preventDefault()

    form = $('form#destroy-products')

    count = 0
    $('.product-check-box:checked').each (i, e)->
      form.append $('<input type="hidden" name="product_ids[]">').val($(e).val())
      count += 1

    if count > 0
      form.submit()
    else
      return false


  $("#product-sort").on 'click', (evt)->
    evt.preventDefault()

    order = $('#sort-order').val()
    $('form#hoge').append $('<input type="hidden" name="order_by">').val(order)
    $('form#hoge').submit()