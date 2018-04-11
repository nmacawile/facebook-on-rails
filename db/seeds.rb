User.create!(email: "admin@email.com",
             first_name: "Admin",
             last_name: "Account",
             birthday: Date.parse("10/10/2000"),
             gender: :male,
             username: "admin",
             password: ENV["admin_password"],
             password_confirmation: ENV["admin_password"],
             remote_avatar_url: "https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif",
             admin: true)

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

banners = %w(https://images.pexels.com/photos/355423/pexels-photo-355423.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/358482/pexels-photo-358482.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/127753/pexels-photo-127753.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/461797/pexels-photo-461797.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/356977/pexels-photo-356977.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             
             https://images.pexels.com/photos/388415/pexels-photo-388415.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/239520/pexels-photo-239520.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/414586/pexels-photo-414586.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/459063/pexels-photo-459063.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/814499/pexels-photo-814499.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             
             https://images.pexels.com/photos/462024/pexels-photo-462024.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/247599/pexels-photo-247599.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/355312/pexels-photo-355312.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/128458/pexels-photo-128458.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             
             https://images.pexels.com/photos/414276/pexels-photo-414276.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/462149/pexels-photo-462149.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/462086/pexels-photo-462086.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/314860/pexels-photo-314860.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             https://images.pexels.com/photos/145685/pexels-photo-145685.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940
             )

# Create Users
20.times do |n|
  
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = (first_name.first + last_name).gsub("\s+", "") + n.to_s
  
  User.create!(email: "user#{n}@email.com",
               first_name: first_name,
               last_name: last_name,
               birthday: Date.parse("10/10/2000"),
               gender: :not_telling,
               username: username,
               password: "password" + username.downcase,
               password_confirmation: "password" + username.downcase,
               remote_avatar_url: images.shift,
               remote_banner_url: banners.shift)
  
end
#

# Add friends
User.all.each do |user|
  friend_ids = user.friends.pluck :id
  friend_ids << user.id
  
  limiter = 7 - user.friends.count
  if limiter > 0
    User.where.not(id: friend_ids).limit(limiter).order("RANDOM()").each do |new_friend|
      user.add_as_friend! new_friend
    end
  end
end
#

# Create posts
User.all.each do |user|
  friend_ids = user.friends.pluck :id
  friend_ids << user.id
  friend_ids.sample(rand(7..10)).each do |friend_id|
    Post.create!(user_id: friend_id, poster_id: user.id, body: Faker::Lorem.paragraph)
  end
  
  mention_name = User.find(friend_ids.sample).username
  Post.create!(user_id: user.id, poster_id: user.id, body: ("@#{mention_name} " + Faker::Lorem.paragraph))
end
#

Notification.destroy_all

# Create comments
Post.all.each do |post|
  friend_ids = post.user.friends.pluck :id
  friend_ids << post.user.id
  
  rand(0..4).times do
    post.comments.create!(user_id: friend_ids.sample, body: Faker::Lorem.sentence)
  end
end
#

# Create friend requests
x = User.create!(email: "nofriends@email.com",
                 first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 birthday: Date.parse("10/10/2000"),
                 gender: :not_telling,
                 username: "nofriends",
                 password: "111111",
                 password_confirmation: "111111")

User.where.not(id: x.id).each do |to_add|
  FriendRequest.create!(user: x, friend: to_add)
end
#


# Create likes
user_ids = User.pluck :id
Post.all.each do |post|
  user_ids.sample(rand(0..10)).each do |id|
    Like.create!(liker_id: id, likeable: post)
  end
end

Comment.all.each do |comment|
  user_ids.sample(rand(0..5)).each do |id|
    Like.create!(liker_id: id, likeable: comment)
  end
end
#