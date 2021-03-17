module UserHelper
  def user_index(user)
    if current_user != user
      render partial: "user", locals: { user: user }
    end
  end
end
