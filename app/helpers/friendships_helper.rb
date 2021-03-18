module FriendshipsHelper
  def friend_request_sent?(user)
    current_user.friend_sent.exists?(sent_to_id: user.id, status: false)
  end

  def friend_request_recieved?(user)
    user.friend_sent.exists?(sent_to_id: current_user.id, status: false)
  end

  def friendship_request(user)
    unless user.id == current_user.id
      if friend_request_sent?(user)
        "<h4>Pending Acceptance</h4>".html_safe
      elsif friend_request_recieved?(user)
        render partial: "accept_reject_friendship_button", locals: { user: user }
      elsif check_friendship(user)
        "<h4>You are already friends</h4>".html_safe
      else
        render partial: "friendship_button", locals: { user: user }
      end
    end
  end

  def check_friendship(user)
    return true if current_user.friend_sent.exists?(sent_to_id: user.id, status: true)
    return true if user.friend_sent.exists?(sent_by_id: current_user.id, status: true)
  end
end
