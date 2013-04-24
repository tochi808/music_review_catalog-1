$ ()->
  class ArtistPanel
    el: $('div#artists')
    selected: ""

    constructor: ()->
      #アーティスト名のリストを取得する
      $.ajax(
        url     : '/artists'
        type    : 'GET'
        dataType: "json"

      ).done( (data)=>
        @name_list = data

      ).fail( (data)=>
        @name_list = []
      )

    update: (str)->
      @el.html('')
      return this if str == ""

      candidates = $.map @name_list, (e, i)->
        regexp = new RegExp("^" + str, ["i"])
        if e.name.match regexp 
          return e.name

      $(candidates).each (i, candidate)=>
        @el.append $('<div class="row">').html(candidate)

      return this

    clear: ()->
      @el.html('')

    hide: ()->
      @el.hide()

    show: ()->
      @el.show()

    selectNext: ()->
      selected_row = @getSelected()

      if selected_row
        selected_row.next('.row').addClass('selected')
        selected_row.removeClass('selected')
      else
        @el.find('.row:first').addClass('selected')

    selectPrev: ()->
      selected_row = @getSelected()

      if selected_row
        selected_row.prev('.row').addClass('selected')
        selected_row.removeClass('selected')
      else
        @el.find('.row:last').addClass('selected')

    getSelected: ()->
      selected = @el.find('.selected')

      if selected.size() > 0
        return selected 
      else
        return null

  class ProductPanel
    el: $('div #artist-products')
    name_list: $([])

    setNameList: (artist_name)->
      #アーティスト名のリストを取得する
      $.ajax(
        url     : '/products_by_artist_name'
        type    : 'GET'
        dataType: "json"
        data    : {artist_name: artist_name}

      ).done( (data)=>
        @name_list = $(data)
        @render()
        @show()

      ).fail( (data)=>
        @name_list = $([])
      )

    render: ()->
      @el.html('')
      @name_list.each (i, e)=> 
        @el.append $('<div>').html(e.name)

      return this

    show: ()->
      @el.show()

    hide: ()->
      @el.hide()

  panel = new ArtistPanel() 
  product_panel = new ProductPanel()

  $('#artist_name,#product_name').prop("autocomplete", "off").focus()

  ENTER = 13
  DOWN  = 40
  UP    = 38

  $('#artist_name').on('keydown', (evt)->
    key_code = evt.keyCode

    if key_code == ENTER
      evt.preventDefault()

  ).on('blur', ()->
    panel.hide()

  ).on 'keyup', (evt)->
    key_code = evt.keyCode

    if key_code == ENTER
      evt.preventDefault()

      if panel.getSelected()
        $(this).val(panel.getSelected().html())
        panel.hide()

    else if key_code == DOWN
      panel.selectNext()

    else if key_code == UP 
      panel.selectPrev()

    else
      input_value = $(this).val()
      panel.update(input_value)
      panel.show()

  $('#product_name').on('focus', ()->
    product_panel.setNameList $("#artist_name").val()

  ).on('blur', ()->
    product_panel.hide()

  ).on 'keydown', (evt)->
    if evt.keyCode == ENTER
      evt.preventDefault()

