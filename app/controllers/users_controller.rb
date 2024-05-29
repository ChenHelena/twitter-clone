class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tweet_presenters = @user.tweets.order(created_at: :desc).map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: @user)
    end
    redirect_to profile_path if params[:id].to_i == current_user.id
  end

end