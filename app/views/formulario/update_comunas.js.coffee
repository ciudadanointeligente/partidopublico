$('#<%= @element_id %>').empty()
  .append("<%= escape_javascript(render(:partial => 'comuna', locals: { items: @comunas })) %>")