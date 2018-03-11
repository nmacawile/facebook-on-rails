module LikesHelper
  
  def post_toggleable_like_button(post)
    post_params = { likeable_type: "Post", likeable_id: post.id }
    
    mode = current_user.posts_liked.include?(post) ? :unlike : :like
    matrix = { unlike: { style: 'fas',
                         path: unlike_path(post_params),
                         method: :delete,
                         class: 'btn-primary' },
                 like: { style: 'far',
                         path: like_path(post_params),
                         method: :post,
                         class: 'btn-default' } }
    
    toggleable_button([matrix[mode][:style], 'thumbs-up'],
                      'Like', 
                      matrix[mode][:path], 
                      {
                        method: matrix[mode][:method],
                        remote: true,
                        class: "post-btn-like btn #{matrix[mode][:class]}",
                      })
  end
  
  def comment_toggleable_like_button(comment)
    
    comment_params = { likeable_type: "Comment", likeable_id: comment.id }
    mode = current_user.comments_liked.include?(comment) ? :unlike : :like
    matrix = { unlike: { style: 'fas',
                         path: unlike_path(comment_params),
                         method: :delete },
                 like: { style: 'far',
                         path: like_path(comment_params),
                         method: :post } }
                         
    link_to(icon(matrix[mode][:style], 'thumbs-up'),
            matrix[mode][:path],
            {
              method: matrix[mode][:method],
              remote: true,
              class: 'comment-btn-like',
            })
  end
  
  def likes_count(object)
    likes = object.likes.count
    return "" if likes == 0
    likes_string = ""
    
    if user_signed_in? && object.likers.include?(current_user)
      likes_string = "You"
      likes_string << " and #{likes - 1} #{"other".pluralize(likes - 1)}" if likes > 1
      likes_string << " liked this."
    else
      "#{likes} #{"person".pluralize(likes)} liked this."
    end
  end
end
