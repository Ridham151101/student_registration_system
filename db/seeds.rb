# db/seeds.rb

# Clear existing users
User.destroy_all

# Create an admin user
admin = User.create!(
  email: 'admin@example.com',
  password: 'securepassword123',   # Change this to a secure password
  password_confirmation: 'securepassword123',
  role: 'admin'
)

puts "Admin user created: #{admin.email}"
