# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      resource.name = params[:user][:name]
      resource.postal_code = params[:user][:postal_code]
      resource.address = params[:user][:address]
      resource.profile = params[:user][:profile]
      resource.save
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :postal_code, :address, :profile)
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
