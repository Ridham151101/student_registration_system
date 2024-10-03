# Student Registration System

This is a Ruby on Rails application for a student registration system. The application allows admins to manage student registrations, including viewing, editing, and verifying student details. Students can register and view their details after verification by an admin. The system also includes functionalities for sending emails and managing student data through CSV import/export.

## Features

### Admin Features
- **View List of Students**: Admins can view all registered students.
- **Edit Student Details**: Admins can update student information.
- **Verify Student Details**: Admins can verify student registrations.
- **Bulk Import**: Admins can import student details from a CSV file.
- **Export Student Details**: Admins can export student information to a CSV file.
- **Email Notifications**: 
  - Notify students when their details are verified.
  - Notify students when they are registered by an admin.

### Student Features
- **Registration**: Students can register with their name, date of birth, photo, and address.
- **Login**: Students can log in if their details are verified by an admin. Otherwise, they will see a message indicating that their details are awaiting verification.
- **View Details**: Students can view their own details.
- **Email Notifications**:
  - Notify the admin when a student registers.
  - Daily "Good Morning" email to all students.
  - Birthday email to students on their birthday.

## Technologies Used
- Ruby on Rails 7
- Action Mailer for email notifications
- Active Job for background jobs and cron tasks
- Rake tasks for scheduled jobs
- Bootstrap for styling

## Installation

1. **Clone the repository**:
  git clone https://github.com/Ridham151101/student_registration_system.git
  cd student_registration_system

2. **Install dependencies**:
  bundle install

3. **Set up the database**:
  rails db:create db:migrate

4. **Seed the database**:
  rails db:seed

5. **Set up Action Mailer**:
  ***Configure your SMTP settings in config/environments/development.rb (and production.rb if necessary) using Gmail or Mailtrap.***
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'your_domain.com',
    user_name:            'your_email@gmail.com',
    password:             'your_password',
    authentication:       'plain',
    enable_starttls_auto: true
  }

6. **Run the application**:
  rails server

**Open your browser and navigate to http://localhost:3000**.

## Usage
**Admin Login**: You can log in as an admin and manage student registrations.
**Student Registration**: Students can register and check their details.
**Cron Jobs**: Use the Whenever gem to manage scheduled tasks like daily emails and birthday notifications.

## Contributing
If you would like to contribute to this project, please fork the repository and submit a pull request with your changes.
