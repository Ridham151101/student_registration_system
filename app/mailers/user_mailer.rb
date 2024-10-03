class UserMailer < ApplicationMailer
  default from: 'your_email@gmail.com'

  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Registration Confirmation')
  end

  def verification_notification(user)
    @user = user
    mail(to: @user.email, subject: 'Your details have been verified')
  end

  def register_new_student(student)
    @student = student
    @admins = User.where(role: 'admin')
    mail(to: @admins.pluck(:email), subject: 'A New Student is Registered')
  end

  def daily_greeting(user)
    @user = user
    mail(to: @user.email, subject: 'Good Morning')
  end

  def birthday_greeting(user)
    @user = user
    mail(to: @user.email, subject: 'Happy Birthday')
  end
end
