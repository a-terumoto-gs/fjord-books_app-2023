# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :address, :profile])
  end

  def after_sign_out_path_for(resource_or_scope)
    flash[:notice] = "ログアウトしました"
    new_user_session_path 
  end
end
