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
end
