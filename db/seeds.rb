a = User.create!(email: "a@a",
                 first_name: "me",
                 last_name: "account",
                 birthday: Date.parse("10/10/2000"),
                 gender: :not_telling,
                 username: "m",
                 password: "111111",
                 password_confirmation: "111111")


images = %w(https://images.pexels.com/photos/450271/pexels-photo-450271.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/428339/pexels-photo-428339.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/253758/pexels-photo-253758.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/712521/pexels-photo-712521.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/569163/pexels-photo-569163.jpeg?h=400&auto=compress&cs=tinysrgb
            
            https://images.pexels.com/photos/103123/pexels-photo-103123.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/415326/pexels-photo-415326.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/462680/pexels-photo-462680.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/326559/pexels-photo-326559.jpeg?h=400&auto=compress&cs=tinysrgb
            
            https://images.pexels.com/photos/206445/pexels-photo-206445.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/539727/pexels-photo-539727.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/325682/pexels-photo-325682.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/325531/pexels-photo-325531.jpeg?h=400&auto=compress&cs=tinysrgb
            
            https://images.pexels.com/photos/789822/pexels-photo-789822.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/842567/pexels-photo-842567.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/428333/pexels-photo-428333.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/377058/pexels-photo-377058.jpeg?h=400&auto=compress&cs=tinysrgb
            https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?h=400&auto=compress&cs=tinysrgb)
            


20.times do |n|
  u = User.create!(email: "user#{n}@email.com",
                   first_name: Faker::Name.first_name,
                   last_name: Faker::Name.last_name,
                   birthday: Date.parse("10/10/2000"),
                   gender: :not_telling,
                   username: "user#{n}",
                   password: "111111",
                   password_confirmation: "111111",
                   remote_avatar_url: images.shift)
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

User.limit(5).offset(6).each do |u|
  FriendRequest.create!(user: a, friend: u)
end

User.limit(5).offset(11).each do |u|
  FriendRequest.create!(user: u, friend: a)
end
