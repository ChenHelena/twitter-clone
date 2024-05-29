class BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def index 
    @tweet_presenters = current_user.bookmarked_tweets.map do |tweet|
      TweetPresenter.new(tweet: tweet, current_user: current_user)
    end
  end

  def create
    @bookmark = current_user.bookmarks.create(tweet: tweet_id)
    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @boookmark = tweet_id.bookmarks.find(params[:id])
    @boookmark.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end
  
  private
  def tweet_id
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end