class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit additional parameters for Devise
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :dob, :address, :photo, :role, :varified])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :dob, :address, :photo, :varified])
  end

  # Redirect non-admin users trying to access admin routes
  def authenticate_admin!
    if current_user.nil? || current_user.role != 'admin'
      redirect_to '/404', alert: "You are not authorized to access this page."
    end
  end
end
