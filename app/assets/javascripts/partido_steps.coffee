# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ready = ->
    $('input:file').on 'change', () ->
      $('#personas_file_submit').prop 'disabled', !$(this).val()
    $('#partido_steps_form').on("ajax:success", (e, data, status, xhr) ->
      console.log "ajax:sucess"
      #$("#partido_steps_form").append xhr.responseText
    ).on "ajax:error", (e, xhr, status, error) ->
      console.log xhr
      console.log status
      #$("#partido_steps_form").append "<p>ERROR</p>"

  load = ->
    #alert "load"
    $('.chosen-select').chosen();

  $(document).on 'load', load

  $(document).on 'page:change', ready

  return
