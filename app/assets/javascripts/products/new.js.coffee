$ ()->
  $.ajax(
    url: '/artists',
    dataType: "json"

  ).done((artists)->
    artist_names = []
    $.map artists , (artist)-> 
      artist_names.push artist.name

    $('#artist_name').typeahead(source: artist_names)

  ).fail(()->

  )

  $('#artist_name').focus()