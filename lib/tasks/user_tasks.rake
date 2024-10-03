namespace :users do
  desc "Send daily greetings"
  task send_daily_greetings: :environment do
    User.where(role: 'student').each do |user|
      UserMailer.daily_greeting(user).deliver_now
    end
  end

  desc "Send birthday greetings"
  task send_birthday_greetings: :environment do
    User.where("extract(month from dob) = ? AND extract(day from dob) = ?", Date.today.month, Date.today.day).each do |user|
      UserMailer.birthday_greeting(user).deliver_now
    end
  end
end
