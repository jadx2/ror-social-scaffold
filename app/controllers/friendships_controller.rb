class FriendshipsController < ApplicationController
  include ApplicationHelper

  def create
    @user = User.find(params[:user_id])
    @request_friend = current_user.friend_sent.build(sent_to_id: params[:user_id])
    if @request_friend.save
      flash[:notice] = "Send the Friend Request"
      @notification = new_notification(@user, @current_user.id, "friendRequest")
      @notification.save
    else
      flash[:alert] = "Unable to Send the Friend Request"
    end
    redirect_back(fallback_location: @user)
  end

  def accept_friend
    @friendship = Friendship.find_by(sent_by_id: params[:user_id], sent_to_id: current_user.id, status: false)
    return unless @friendship # return if no record is found

    @friendship.status = true
    if @friendship.save
      flash[:notice] = "Friend Request Accepted!"
      @friendship2 = current_user.friend_sent.build(sent_to_id: params[:user_id], status: true)
      @friendship2.save
    else
      flash[:alert] = "Friend Request could not be accepted!"
    end
    redirect_back(fallback_location: users_path)
  end
end
