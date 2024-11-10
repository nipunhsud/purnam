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
ProjectCollaborator.destroy_all

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

accounts = Account.all

# Seed Projects
project_hashes = 10.times.map do |i|
  owner_account = i.even? ? accounts.first : accounts[1..-1].sample

  random_starting_day = rand(1..100).days.ago
  random_ending_day = rand(60..120).days.from_now

  {
    name: Faker::Lorem.word.titleize,
    owner_account:,
    description: Faker::Lorem.paragraphs.join,
    start_date: random_starting_day,
    end_date: random_ending_day
  }
end

projects = Project.create(project_hashes)

# Seed Project Collaborators
projects.each do |project|
  existing_collaborators = project.collaborators
  possible_candidate_collaborators = Account.excluding(existing_collaborators)

  project_collaborator_hashes = possible_candidate_collaborators.sample(rand(3..6)).map do |collaborator|
    { project:, account: collaborator }
  end

  ProjectCollaborator.create(project_collaborator_hashes)
end

# Seed Project Stakeholders
projects.each do |project|
  existing_stakeholders = project.stakeholders
  possible_candidate_stakeholders = Account.excluding(existing_stakeholders)

  project_stakeholder_hashes = possible_candidate_stakeholders.sample(rand(2..4)).map do |stakeholder|
    { project:, account: stakeholder }
  end

  ProjectStakeholder.create(project_stakeholder_hashes)
end
