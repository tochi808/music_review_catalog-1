# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ()->
  $("#toggle-check-box").on 'click', (evt)->
    if $(this).prop('checked')
      $('.product-check-box').prop('checked', true).trigger('change')
    else
      $('.product-check-box').prop('checked', false).trigger('change')


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
      
  $('.product-check-box').on 'change', ()->
    if $(this).prop('checked') 
      $(this).parents('tr:first').addClass('selected')
    else
      $(this).parents('tr:first').removeClass('selected')

  $("#sort-order").on 'change', ()->
    order = $(this).val()
    $('form#hoge').append $('<input type="hidden" name="order_by">').val(order)
    $('form#hoge').submit()


  #table-row のハイライト
  (()->
    highlight_class_name = 'highlight' 
    row_class_name = '.product-row'

    $("#products-table").on('mouseover', row_class_name, (evt)->
      $(this).addClass(highlight_class_name)

    ).on('mouseleave', row_class_name, (evt)->
      $(this).removeClass(highlight_class_name)
    )
  )()


