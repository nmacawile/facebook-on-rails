a = User.create!(email: "a@a",
                 first_name: "me",
                 last_name: "account",
                 birthday: Date.parse("10/10/2000"),
                 gender: :not_telling,
                 username: "m",
                 password: "111111",
                 password_confirmation: "111111")


20.times do |n|
  u = User.create!(email: "user#{n}@email.com",
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   birthday: Date.parse("10/10/2000"),
                   gender: :not_telling,
                   username: "user#{n}",
                   password: "111111",
                   password_confirmation: "111111")
  5.times do 
    p = u.posts.create!(poster: u, body: Faker::Lorem.paragraph)
    3.times do
      p.comments.create!(user: u, body: Faker::Lorem.sentence)
    end
  end
end

User.limit(2).offset(1).each do |u|
  User.first.posts.create!(poster: u, body: Faker::Lorem.paragraph)
end

User.limit(5).offset(1).each do |u|
  u.add_as_friend! a
end