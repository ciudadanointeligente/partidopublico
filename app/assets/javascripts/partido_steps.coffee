# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  ready = ->
    $('.checkForDelete').on 'click', ->
      el = $(this)
      el.removeClass('btn-danger').addClass('btn-success');
      child = el.children()
      child.addClass('fa-check').removeClass 'fa-trash'
      return

    $('input:file').on 'change', () ->
      $('#personas_file_submit').prop 'disabled', !$(this).val()
      $('#afiliacion_file_submit').prop 'disabled', !$(this).val()
      return

    $('#partido_steps_form').on("ajax:success", (e, data, status, xhr) ->
      scroll_to_top();
      return
      #$("#partido_steps_form").append xhr.responseText
    ).on "ajax:error", (e, xhr, status, error) ->
      scroll_to_top();
      return
      #$("#partido_steps_form").append "<p>ERROR</p>"

    $('.upload-file').on 'click', ->
      id = $(this).data('file-id')
      $('#hidden_file_input_' + id).click();
      $('#hidden_file_input_' + id).on 'change', ->
        $('#file_label_' + id)[0].innerHTML = "Archivo listo."
        return
      return

    # $('#new_admin_form').on("ajax:success", (e, data, status, xhr) ->
    #   console.log("new admin form submited succsessfully")
    #   scroll_to_top();
    #   location.reload(true);
    #   return
    # ).on "ajax:error", (e, xhr, status, error) ->
    #   scroll_to_top();
    #   return
      #$("#partido_steps_form").append "<p>ERROR</p>"

  load = ->
    #alert "load"
    $('.chosen-select').chosen();

  $(document).on 'load', load

  $(document).on 'page:change', ready

  return
