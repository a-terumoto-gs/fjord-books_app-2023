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
end