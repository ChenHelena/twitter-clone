class ProfileController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @tweet_presenters = TweetPresenter.build_collection(@user.tweets.includes(:liked_users, :bookmarked_users, :retweeted_users), current_user)
    render 'users/show'
  end

  def update
    @user = current_user
    @user.update(user_params[:password].blank? ? user_params.except(:password) : user_params)
    @tweet_presenters = TweetPresenter.build_collection(@user.tweets.includes(:liked_users, :bookmarked_users, :retweeted_users), current_user)
    respond_to do |format|
      format.html { redirect_to profile_path }
      format.turbo_stream
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :name, :email, :password, :bio, :location, :website, :avatar)
  end
end