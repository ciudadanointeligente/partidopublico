# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  show_sibling = (elem, sib_class, show) ->
    if show
      elem.parent().siblings(sib_class).removeClass 'escondido'
      elem.parent().siblings(sib_class).addClass 'mostrable'
    else
      elem.parent().siblings(sib_class).removeClass 'mostrable'
      elem.parent().siblings(sib_class).addClass 'escondido'
    
  ready = ->
    $(".cargo").each ->
      id = $(@).attr("id")
      cargo_value = $(@).val()
      console.dir $(@).parent().siblings(".region")
      switch cargo_value
        when "Alcalde", "Concejal"
          show_sibling $(@), ".region", true
          show_sibling $(@), ".comuna", true
        when "Consejero Regional"
          show_sibling $(@), ".region", true
        when "Senador"
          show_sibling $(@), ".circunscripcion", true
        when "Diputado"
          show_sibling $(@), ".circunscripcion", true
          show_sibling $(@), ".distrito", true
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
        console.log("update_distritos select OK!")
        
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
        show_sibling $(@), ".region", true
        show_sibling $(@), ".comuna", true
        show_sibling $(@), ".circunscripcion", false
        show_sibling $(@), ".distrito", false
      when "Consejero Regional"
        show_sibling $(@), ".region", true
        show_sibling $(@), ".comuna", false
        show_sibling $(@), ".circunscripcion", false
        show_sibling $(@), ".distrito", false
      when "Senador"
        show_sibling $(@), ".region", false
        show_sibling $(@), ".comuna", false
        show_sibling $(@), ".circunscripcion", true
        show_sibling $(@), ".distrito", false
      when "Diputado"
        show_sibling $(@), ".region", false
        show_sibling $(@), ".comuna", false
        show_sibling $(@), ".circunscripcion", true
        show_sibling $(@), ".distrito", true
      when "Presidente"
        show_sibling $(@), ".region", false
        show_sibling $(@), ".comuna", false
        show_sibling $(@), ".circunscripcion", false
        show_sibling $(@), ".distrito", false
      else console.log cargo_value
    return
  return
     