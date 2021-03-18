module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? "menu-item active" : "menu-item"

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to("Dislike!", post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to("Like!", post_likes_path(post_id: post.id), method: :post)
    end
  end

  def friend_request_sent?(user)
    current_user.friend_sent.exists?(sent_to_id: user.id, status: false)
  end

  def friend_request_recieved?(user)
    user.friend_sent.exists?(sent_to_id: current_user.id, status: false)
  end

  def friendship_request(user)
    unless user.id == current_user.id
      if friend_request_sent?(user)
        '<h4>Pending Acceptance</h4>'.html_safe
      elsif friend_request_recieved?(user)
        render partial: 'accept_reject_friendship_button', locals: { user: user }
      else
        render partial: 'friendship_button', locals: { user: user }
      end
    end
  end

  # def accept_friendship(user, friends)
  #   friendship = friends.find_by(sent_by_id: params[user.id], sent_to_id: current_user.id, status: false)
  #   friendship.status = true
  #   flash[:notice] = 'Friend Request Accepted!' if friendship.save
  #   redirect_to users
  # end

  # def reject_friendship(user, friends)
  #   request = Friendship.find_by(sent_to_id: params[current_user.id], sent_to_id: params[user.id])

  #   # request.status = true
  #   flash[:notice] = 'Accept Friends Request'
  # end

  def new_notification(user, notice_id, notice_type)
    notice = user.notifications.build(notice_id: notice_id, notice_type: notice_type)
    user.notice_seen = false
    user.save
    notice
  end

  def notification_find(notice, type)
    user = User.find(notice)
    return "#{user.name} sent you a friend request" if type == "friendRequest"
  end
end
