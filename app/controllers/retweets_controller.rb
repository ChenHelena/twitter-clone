class RetweetsController < ApplicationController
  before_action :authenticate_user!
  def create
    @retweet = current_user.retweets.create(tweet: tweet)
    TweetActivity.create(user: current_user, actor: current_user, tweet: tweet, verb: "retweeted")
    respond_to do |format|
      format.turbo_stream
    end
  end
  
  def destroy
    @retweet = tweet.retweets.find(params[:id])
    @retweet.destroy
    TweetActivity.where(user: current_user, actor: current_user, tweet: tweet, verb: "retweeted").destroy_all
    respond_to do |format|
      format.turbo_stream
    end
  end

  private
  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end