require 'Random_data'

# Create Users
5.times do
    User.create!(
        email:    RandomData.random_email,
        password: RandomData.random_sentence
    )
end

users = User.all

# Create Wikis
25.times do
    Wiki.create!(
        user:   users.sample,
        title:  RandomData.random_sentence,
        body:   RandomData.random_paragraph
    )
end

wikis = Wiki.all

puts "Seed finished"
puts "#{User.count} Users created"
puts "#{Wiki.count} Wikis created"
