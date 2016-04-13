# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ready = ->
    $(".comuna").hide();
  
  $(document).on 'page:change', ready
  
  $(document).on 'change', '.region', (evt) ->
    console.log $('this').attr('id')
    $.ajax 'formulario/update_comunas',
      type: 'GET'
      dataType: 'script'
      data: {
        # region_id: $("#countries_select option:selected").val()
        region_id: 4,
        element_id:$('this').attr('id')
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        alert data
        console.log("Dynamic country select OK!")
        
    return
  
  $(document).on 'change', '.cargo', (evt) ->
    $(".comuna").removeClass 'escondido'
    cargo_value = $(this).val()
    console.log cargo_value
    switch cargo_value
      when "Alcalde", "Concejal"
        $(".region").removeClass 'escondido'
        $(".comuna").removeClass 'escondido'  
      else alert cargo_value
    return
  return
     