class ApplicationController < ActionController::Base
  # before_action :authenticate_admin!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :beforeFilter

  def beforeFilter
    $request = request
  end

  def after_sign_in_path_for(resource)
    if current_admin.is_superadmin
      admin_path
    else
      partido_steps_path current_admin.partidos.first
    end
  end
end
