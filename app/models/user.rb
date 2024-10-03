class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Photo upload
  has_one_attached :photo

  # Validations for students only
  with_options if: -> { role == 'student' } do
    validates :name, :dob, :address, presence: true
  end

  validates :email, uniqueness: true

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # Assuming your CSV columns match the User attributes
      user_attributes = row.to_hash

      # Find or initialize a user by email
      user = User.find_or_initialize_by(email: user_attributes['email'])

      if user.new_record?
        # If the user is new, assign attributes and save
        user.assign_attributes(user_attributes)

        if user.save
          # Log success or take any additional action if needed
          puts "Imported user: #{user.email}"
        else
          # Log validation errors for the user
          puts "Failed to import user: #{user.email}, Errors: #{user.errors.full_messages.join(', ')}"
        end
      else
        # If user exists, log that it was skipped or handle updates
        puts "User already exists: #{user.email}. Skipping..."
      end
    end
  end

  def self.to_csv
    attributes = %w{name email dob address role varified}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map { |attr| user.send(attr) }
      end
    end
  end
end
