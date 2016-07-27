class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :beforeFilter

  def beforeFilter
    $request = request
    puts "request : " + request.to_s
    #  puts "current_admin : " + current_admin.to_s
    #  $current_admin = current_admin
  end

  def after_sign_in_path_for(resource)
    #current_user_path
    #partido_steps_path
    #partidos_url, action: "admin"

  end
end
