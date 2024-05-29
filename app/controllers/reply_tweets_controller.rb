class ReplyTweetsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = tweet.reply_tweets.create(tweet_params.merge(user: current_user))
    TweetActivity.create(user: current_user, actor: current_user, tweet: tweet, verb: "replied")
    if @tweet.save
      puts "Created reply tweet with ID: #{@tweet.id}"
      respond_to do |format|
        format.html { redirect_to dashboard_path }
        format.turbo_stream
      end
    else
      puts "Error creating reply tweet: #{@tweet.errors.full_messages}"
    end
  end

  private 

  def tweet_params
    params.require(:tweet).permit(:body)
  end

  def tweet
    @tweet ||= Tweet.find(params[:tweet_id])
  end
end