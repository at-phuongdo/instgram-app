class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    set_meta_tags title: @user.name
    @posts = @user.posts.includes(:photos, :likes, :comments)
    @saved = Post.joins(:bookmarks).where("bookmarks.user_id=?", current_user.id).
      includes(:photos, :likes, :comments) if @user == current_user
    @user_is_friend = current_user.friends.map(&:friend_id).include?(params[:id].to_i)
  end

  def update
    @user = User.find(params[:id])
    image = Cloudinary::Uploader.upload(params[:images]["0"])['url']
    @user.update(image: image)
  end
end
