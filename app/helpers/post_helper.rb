module PostHelper
  def display_errors(post)
    return unless post.errors.full_messages.any?

    content_tag :p, "Post could not be saved. #{post.errors.full_messages.join('. ')}", class: 'errors'
  end

  def show_post(post)
    render partial: 'post', locals: { post: post } if current_user.friend_sent.exists?(sent_to_id: post.user_id,
                                                                                       status: true)
  end
end
