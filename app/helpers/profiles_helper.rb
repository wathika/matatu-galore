module ProfilesHelper

  def form_image_select(post)
    return image_tag post.image.url(:medium),
                      id: "image-preview",
                      class: "img-responsive" if post.image.exists?
    image_tag '', id: 'image-preview', class: 'img-responsive'
  end

  def current_user_is_following(current_user_id, followed_user_id)
    relationship = Follow.find_by(follower_id: current_user_id, following_id: followed_user_id)
    return true if relationship
  end

end
