module ApplicationHelper
  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def new_notification(user, notice_id, notice_type)
    notice = user.notifications.build(notice_id: notice_id, notice_type: notice_type)
    user.notice_seen = false
    user.save
    notice
  end

  def notification_find(notice, type)
    user = User.find(notice)
    return "#{user.name} sent you a friend request" if type == 'friendRequest'
  end

  def user_control
    if current_user
      render 'users/user_control'
    else
      render 'users/signin_signup_button'
    end
  end
end
