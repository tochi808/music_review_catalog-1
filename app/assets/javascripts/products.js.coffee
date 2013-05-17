# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ()->
  $("#toggle-check-box").on 'click', (evt)->
    check_boxies = $('.product-check-box') 
    if $(this).prop('checked')
      check_boxies.prop('checked', true)
    else
      check_boxies.prop('checked', false)

    check_boxies.trigger('change')


  $('#destroy-products-button').on 'click', (evt)->
    evt.preventDefault()

    form = $('form#destroy-products')

    checked_rows = $('.product-check-box:checked')
    return if checked_rows.size() <= 0

    checked_rows.each (i, e)->
      form.append $('<input type="hidden" name="product_ids[]">').val($(e).val())

    form.submit()
      

  $("#sort-order").on 'change', ()->
    order = $(this).val()

    $('form#hoge').append $('<input type="hidden" name="order_by">').val(order)
    $('form#hoge').submit()

  #table-row のハイライト
  (()->
    highlight = 'highlight' 
    row_class_name = '.product-row'

    $("#product-list").on('mouseover', row_class_name, (evt)->
      $(this).addClass(highlight)

    ).on('mouseleave', row_class_name, (evt)->
      $(this).removeClass(highlight)
    )
  )()

  $('.btn_new_review').on 'ajax:success', (evt, html)->
    $('.modal-body').html html
    $('#review_input_modal').modal('show')



