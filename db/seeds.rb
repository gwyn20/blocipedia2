require 'Random_data'
require 'faker'

# Create Test User
1.times do
    User.create!(
        email:    "gwyn20@gmail.com",
        password: "password"
    )
end

# Create Users
5.times do
    User.create!(
        email:    Faker::Internet.email,
        password: Faker::Internet.password
    )
end

users = User.all

# Create Wikis
25.times do
    Wiki.create!(
        user:   users.sample,
        title:  Faker::RickAndMorty.location,
        body:   Faker::RickAndMorty.quote
    )
end

wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} Users created"
puts "#{Wiki.count} Wikis created"
