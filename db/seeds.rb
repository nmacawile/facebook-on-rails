User.create!(email: "admin@email.com",
             first_name: "Admin",
             last_name: "Account",
             birthday: Date.parse("10/10/2000"),
             gender: :male,
             username: ENV["ADMIN_USERNAME"],
             password: ENV["ADMIN_PASSWORD"],
             password_confirmation: ENV["ADMIN_PASSWORD"],
             remote_avatar_url: "https://media.giphy.com/media/JIX9t2j0ZTN9S/giphy.gif",
             admin: true)

images = %w(https://images.pexels.com/photos/1624229/pexels-photo-1624229.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/2219273/pexels-photo-2219273.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/1820919/pexels-photo-1820919.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/2169098/pexels-photo-2169098.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/2860233/pexels-photo-2860233.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1

            https://images.pexels.com/photos/2059101/pexels-photo-2059101.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/3756506/pexels-photo-3756506.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/1940547/pexels-photo-1940547.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/2112715/pexels-photo-2112715.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/3846150/pexels-photo-3846150.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1

            https://images.pexels.com/photos/7289412/pexels-photo-7289412.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/5543385/pexels-photo-5543385.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/5220075/pexels-photo-5220075.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/7925814/pexels-photo-7925814.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/10080749/pexels-photo-10080749.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1

            https://images.pexels.com/photos/3988043/pexels-photo-3988043.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/9789893/pexels-photo-9789893.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/10039008/pexels-photo-10039008.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/9930284/pexels-photo-9930284.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
            https://images.pexels.com/photos/10057618/pexels-photo-10057618.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1)

banners = %w(https://images.pexels.com/photos/1172064/pexels-photo-1172064.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/1266810/pexels-photo-1266810.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/108941/pexels-photo-108941.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/1834399/pexels-photo-1834399.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/3551227/pexels-photo-3551227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1

             https://images.pexels.com/photos/733171/pexels-photo-733171.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/1784577/pexels-photo-1784577.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/3408353/pexels-photo-3408353.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/3363331/pexels-photo-3363331.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/5875873/pexels-photo-5875873.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1

             https://images.pexels.com/photos/4666754/pexels-photo-4666754.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/13829125/pexels-photo-13829125.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/1658967/pexels-photo-1658967.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/1682407/pexels-photo-1682407.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/9458045/pexels-photo-9458045.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1

             https://images.pexels.com/photos/9574076/pexels-photo-9574076.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/11869182/pexels-photo-11869182.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/192320/pexels-photo-192320.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/11389480/pexels-photo-11389480.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1
             https://images.pexels.com/photos/2365362/pexels-photo-2365362.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1)

# Create Users
def create_user(first_name, index, image, banner)
  last_name = Faker::Name.last_name
  username = (first_name.first + last_name).gsub("\s+", "") + index.to_s
  
  User.create!(email: "user#{index}@email.com",
               first_name: first_name,
               last_name: last_name,
               birthday: Date.parse("10/10/2000"),
               gender: :not_telling,
               username: username,
               password: "password" + username.downcase,
               password_confirmation: "password" + username.downcase,
               remote_avatar_url: image,
               remote_banner_url: banner)
end


user_index = 0

10.times do
  create_user(Faker::Name.female_first_name, user_index, images.shift, banners.shift)
  user_index += 1
end

10.times do
  create_user(Faker::Name.male_first_name, user_index, images.shift, banners.shift)
  user_index += 1
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