# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




25.times do
    User.create!(
        username: Faker::Internet.username,
        password: '12345678',
        email: Faker::Internet.email,
    )
end

25.times do
    Post.create!(
        question: Faker::FamousLastWords.last_words,
        body: Faker::ChuckNorris.fact,
        user_id: 1 + rand(40),
    )
end

100.times do
    Comment.create!(
        body: Faker::MichaelScott.quote,
        user_id: 1 + rand(50),
        post_id: 1 + rand(50),
    )
end