class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, except: %i[edit update show]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :verify_student]

  def index
    @students = User.where(role: "student")
  end

  def show
  end

  def new
    @user = User.new
  end

  def student_registration
    @user = User.new(user_params)
    @user.password = 'password'
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      # Redirect based on the user's role after successful update
      if current_user.role == 'admin'
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        redirect_to user_path(@user), notice: 'User was successfully updated.'
      end
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def import
    if params[:file].present?
      begin
        User.import(params[:file])
        redirect_to users_path, notice: 'Students imported successfully.'
      rescue StandardError => e
        logger.error "Error importing users: #{e.message}"
        redirect_to users_path, alert: 'There was an error importing the students. Please check the file format and try again.'
      end
    else
      redirect_to users_path, alert: 'Please upload a CSV file.'
    end
  end  

  def export
    @students = User.where(role: "student")
    respond_to do |format|
      format.csv { send_data @students.to_csv, filename: "students-#{Date.today}.csv" }
    end
  end

  def verify_student
    @user.varified = true
    if @user.save
      UserMailer.verification_notification(@user).deliver_now
      redirect_to users_path, notice: 'Student is varified successfully.'
    else
      redirect_to users_path, notice: 'Some issues in varification.'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :dob, :address, :photo, :role, :varified)
  end
end
