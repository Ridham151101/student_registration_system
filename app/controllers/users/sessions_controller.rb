# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # Find user by login (e.g., email)
    self.resource = User.find_for_database_authentication(email: params[:user][:email])
  
    # Check if the user exists and the password is valid
    if resource && resource.valid_password?(params[:user][:password])
      # Authentication successful, check role and verified status
      if resource.role == "admin" || (resource.role == "student" && resource.varified)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)
        yield resource if block_given?
        redirect_to after_sign_in_path_for(resource)
      else
        flash[:alert] = "Admin will verify your details soon."
        redirect_to new_user_session_path and return
      end
    else
      # Authentication failed
      flash[:alert] = "Invalid email or password."
      redirect_to new_user_session_path and return
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
