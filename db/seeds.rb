
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
    u.posts.create!(poster: u, body: Faker::Lorem.paragraph)
  end
end

User.limit(2).offset(1).each do |u|
  User.first.posts.create!(poster: u, body: Faker::Lorem.paragraph)
end