# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  skip_before_action :verify_authenticity_token, only: [:create]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    build_resource    

    # Determine role and set parameters based on the registration context (admin or student)
    resource.name = params[:user][:name]

    dob_params = params[:user].slice('dob(1i)', 'dob(2i)', 'dob(3i)')
    resource.dob = Date.new(dob_params['dob(1i)'].to_i, dob_params['dob(2i)'].to_i, dob_params['dob(3i)'].to_i)

    resource.address = params[:user][:address]
    resource.photo = params[:user][:photo]
    resource.email = params[:user][:email]
    resource.password = params[:user][:password]
    resource.password_confirmation = params[:user][:password_confirmation]    

    if resource.save
      # Send confirmation email using Active Job
      UserMailer.register_new_student(resource).deliver_now

      # # Sign in the user after registration
      # sign_in(resource_name, resource)

      redirect_to root_path, notice: "Successfully registered."
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :name, :dob, :address, :photo)
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    root_path # Redirect to your desired path after sign-up
  end
end
