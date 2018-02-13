module PostsHelper

  def form_image_select(post)
    return image_tag post.image.url(:medium),
                      id: "image-preview",
                      class: "img-responsive" if post.image.exists?
    image_tag '', id: 'image-preview', class: 'img-responsive'
  end

  def likers_of(post)
    votes = post.votes_for.up#.by_type(User)
    user_names = []
    unless votes.blank?
      votes.voters.each do |voter|
        user_names.push(link_to voter.username,
                                profile_path(voter.username),
                                class: 'user-name')
      end
      user_names.to_sentence.html_safe + like_plural(votes)
    end
  end

  private

  def like_plural(votes)
    return ' like this' if votes.count > 1
    ' likes this'
  end

end
