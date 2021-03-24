module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def show_post(post)
    unless current_user.id == post.user_id || current_user.friend_sent.exists?(sent_to_id: post.user_id, status: true)
      return end

    render partial: 'post', locals: { post: post }
  end
end
