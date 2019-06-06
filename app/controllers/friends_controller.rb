class FriendsController < ApplicationController
  def create
    @friend = Friend.new(user_id: current_user.id, friend_id: params[:id])
    @friend.save
  end

  def destroy
    @friend = Friend.where(user_id:current_user.id, friend_id: params[:id])
    @friend[0].destroy
  end
end
