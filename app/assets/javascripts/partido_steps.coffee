# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
    
  ready = ->
    console.log $(".cargo")
    $(".cargo").each ->
      id = $(@).attr("id")
      # console.log id 
      cargo_value = $(@).val()
      # console.log cargo_value
      main_parent = $(@).parent().parent()
      console.dir $(@).parent().siblings(".region")
      switch cargo_value
        when "Alcalde", "Concejal"
          $(@).parent().siblings(".region").removeClass 'escondido'
          $(@).parent().siblings(".comuna").removeClass 'escondido'  
          $(@).parent().siblings(".region").addClass 'mostrable'
          $(@).parent().siblings(".comuna").addClass 'mostrable'  
        when "Senador"
          $(@).parent().siblings(".circunscripcion").removeClass 'escondido'
          $(@).parent().siblings(".circunscripcion").addClass 'mostrable'
        when "Diputado"
          $(@).parent().siblings(".circunscripcion").removeClass 'escondido'
          $(@).parent().siblings(".circunscripcion").addClass 'mostrable'
          $(@).parent().siblings(".distrito").removeClass 'escondido'
          $(@).parent().siblings(".distrito").addClass 'mostrable'
        else console.log cargo_value
      
  $(document).on 'page:change', ready

  $(document).on 'change', '.circunscripcion', (evt) ->
    fired_element_id = evt.target.id
    target_element_id = fired_element_id.replace 'circunscripcion', 'distrito'
    $.ajax 'formulario/update_distritos',
      type: 'GET'
      dataType: 'script'
      data: {
        circunscripcion_id: $("#"+fired_element_id+" option:selected").val(),
        element_id: target_element_id
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("comunas select OK!")
        
    return
  
  $(document).on 'change', '.region', (evt) ->
    fired_element_id = evt.target.id
    target_element_id = fired_element_id.replace 'region', 'comuna'
    $.ajax 'formulario/update_comunas',
      type: 'GET'
      dataType: 'script'
      data: {
        region_id: $("#"+fired_element_id+" option:selected").val(),
        element_id: target_element_id
      }
      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("comunas select OK!")
        
    return
  
  $(document).on 'change', '.cargo', (evt) ->
    cargo_value = $(this).val()
    switch cargo_value
      when "Alcalde", "Concejal"
        $(@).parent().siblings(".region").removeClass 'escondido'
        $(@).parent().siblings(".comuna").removeClass 'escondido'  
        $(@).parent().siblings(".region").addClass 'mostrable'
        $(@).parent().siblings(".comuna").addClass 'mostrable'  
        $(@).parent().siblings(".circunscripcion").removeClass 'mostrable'
        $(@).parent().siblings(".circunscripcion").addClass 'escondido'
        $(@).parent().siblings(".distrito").removeClass 'mostrable'
        $(@).parent().siblings(".distrito").addClass 'escondido'
      when "Senador"
        $(@).parent().siblings(".circunscripcion").removeClass 'escondido'
        $(@).parent().siblings(".circunscripcion").addClass 'mostrable'
        $(@).parent().siblings(".distrito").removeClass 'mostrable'
        $(@).parent().siblings(".distrito").addClass 'escondido'
        $(@).parent().siblings(".region").removeClass 'mostrable'
        $(@).parent().siblings(".comuna").removeClass 'mostrable'  
        $(@).parent().siblings(".region").addClass 'escondido'
        $(@).parent().siblings(".comuna").addClass 'escondido'  
      when "Diputado"
        $(@).parent().siblings(".circunscripcion").removeClass 'escondido'
        $(@).parent().siblings(".circunscripcion").addClass 'mostrable'
        $(@).parent().siblings(".distrito").removeClass 'escondido'
        $(@).parent().siblings(".distrito").addClass 'mostrable'
        $(@).parent().siblings(".region").removeClass 'mostrable'
        $(@).parent().siblings(".comuna").removeClass 'mostrable'  
        $(@).parent().siblings(".region").addClass 'escondido'
        $(@).parent().siblings(".comuna").addClass 'escondido'
      else console.log cargo_value
    return
  return
     