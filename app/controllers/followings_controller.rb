class FollowingsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find(params[:user_id])
    following = @user.followings.create(following_params)
    @follower = following.following_user

    @follower.notifications.create(verb: "followed-me", actor: @user)

    respond_to do |format|
      format.html { redirect_to user_path(following.following_user) }
      format.turbo_stream
    end
  end

  def destroy 
    following = Following.find(params[:id])
    @user = following.user
    @follower = following.following_user
    following.destroy
    respond_to do |format|
      format.html { redirect_to user_path(following.following_user) }
      format.turbo_stream
    end
  end
  
  private

  def following_params
    params.permit(:following_user_id, :user_id)
  end 

end