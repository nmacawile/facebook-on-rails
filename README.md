# Facebook on Rails
[Link to Live Site](https://fb-on-rails.herokuapp.com)

A Rails-based Facebook clone. It features some of Facebook's core user functionality like creating posting, commenting, liking, and adding friends.

This is the final project for [The Odin Project's Rails course](https://www.theodinproject.com/courses/ruby-on-rails/lessons/final-project). It aims to test everything the student has learned throughout the course.

## Main features
### Sign-in with Google via OAuth 2.0
Sign-in hassle free with your Google account. Attempting to sign-in without an account will redirect you to the Sign-Up page with some of the fields filled in for you.

### Create posts
You can post on your page or your friend's page. Your posts will be visible to your friend's home feed, and vice versa. Character limit is 1000 and you cannot post a blank.

### Comments
You can comment on all posts on your page or your friend's page. However, you cannot post on a post by someone you are not friends with even if the post was authored by a friend. Character limit is 255 and you cannot comment a blank.

### Likes
You can like any post or comment. You don't need to be friends with the owner of the page it is posted in.

### Avatar upload
There are two ways to upload an avatar. One way is by uploading from your local files. Another way is by providing a link to the image. The uploaded image will be transformed automatically.

### Banner upload
Customize your profile with a banner. Like the avatar, there are two ways to upload a banner. If the uploaded file is too small, it will be scaled up to fill the banner area without changing its proportions.

### Photo attachment
Attach a photo to a post. The post still needs to have some text in it. You can post without a photo but you cannot post without text.

### Notifications
You will receive a notification for the following: 1) When a friend comments on your post; 2) When friend posts on your page; 3) When a user sends you a friend request; 4) When you have become friends with a user; and 5) When user mentions you in a post. Notifications can be viewed by clicking on the bell icon at the right side of the header.

### Mentions
To mention a user, simply prepend their username with the ``@`` symbol  in your post like this: ``@user``. The resulting string will turn into a link to the mentioned user's profile. In addition, the mentioned user will receive a notification for the mention in the post.

Mentions are case-insensitive. Typing either ``@uSer`` or ``@User`` will link to and send a notification to the user with the username``@user``.

All alphanumeric words (including underscore ``_``) in the post prepended by the ``@`` symbol are considered mentions.

### Friends
Friending requires the approval of both parties. To become friends, one user has to send a friend request and the other needs to confirm it. Pending friend requests can be seen by clicking on the Friend Request icon at the right side of the notifications icon.

### User search
The search function can match your query against a user's first name, last name, username, or even email. Email address matching is a bit tricky since email addresses are deliberately not shown. So in order to search for a user with an email, it has to match the whole query. Querying ``user@email.com`` will only return the user with the exact email and not ``adminuser@email.com`` despite it containing the string ``user@email.com``. Also,  querying ``user`` will not match any email addresses containing ``user`` but will match all users with it in their first name, last name, or username.

## Resources:
Polymorphism (https://robots.thoughtbot.com/whats-the-deal-with-rails-polymorphic-associations)
AJAX toggleable buttons (https://www.topdan.com/ruby-on-rails/ajax-toggle-buttons.html)
Notifications (http://aalvarez.me/blog/posts/easy-notification-system-in-rails.html)
Search function (http://millo.me/search-by-multiple-columns-in-active-record)
Cloudinary-Carrierwave integration (https://cloudinary.com/documentation/rails_carrierwave)
Devise (https://github.com/plataformatec/devise)
Devise-OmniAuth (https://github.com/plataformatec/devise/wiki/OmniAuth:-Overview)
Sendgrid (https://sendgrid.com/docs/Integrate/Frameworks/rubyonrails.html)

