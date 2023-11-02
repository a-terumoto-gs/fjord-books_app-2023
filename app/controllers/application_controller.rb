# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_params, only: [:update]

  def after_sign_in_path_for(resource)
    books_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path 
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :postal_code, :address, :profile])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :postal_code, :address, :profile])
  end
end
