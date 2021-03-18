module UserHelper
  def user_index(user)
    render partial: 'user', locals: { user: user } if current_user != user
  end
end
