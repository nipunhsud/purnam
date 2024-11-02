# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

exit if Rails.env.production?

# Cleanup
User.destroy_all
Project.destroy_all

# Seed Users and Accounts
user_hashes = 10.times.map do |i|
  {
    email_address: "user@#{i}.com",
    password: "password",
    account_attributes: {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    }
  }
end

User.create(user_hashes)

# Seed Projects
project_hashes = 10.times.map { { name: Faker::Lorem.word.titleize } }

Project.create(project_hashes)
