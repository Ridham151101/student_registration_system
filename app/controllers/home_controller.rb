class HomeController < ApplicationController
  def index
    if user_signed_in?
      if current_user.role == 'admin'
        redirect_to users_path # Admins go to the list of students
      else
        redirect_to user_path(current_user) # Students go to their show page
      end
    else
      # If the user is not signed in, you might want to redirect to a login page or some other public page
      redirect_to new_user_session_path
    end
  end
end