class TweetPresenter
  include ActionView::Helpers::DateHelper
  include Rails.application.routes.url_helpers
  
  attr_reader :tweet, :current_user, :tweet_activity
  def initialize(tweet:, current_user:, tweet_activity: nil)
    @tweet = tweet
    @current_user = current_user
    @tweet_activity = tweet_activity
  end



  delegate :id, :user, :body, :likes, :likes_count, :retweets_count, :views_count, :reply_tweets_count, to: :@tweet
  delegate :username, :name, to: :user


  def tweet_activity_html
    case tweet_activity&.verb
    when "liked"
      "<p class=\"fw-bold mb-0 text-black-50\" style=\"font-size:0.8rem;margin-left:4.5rem\">#{tweet_activity.actor.username} liked</p>"
    when "replied"
      "<p class=\"fw-bold mb-0 text-black-50\" style=\"font-size:0.8rem;margin-left:4.5rem\">#{tweet_activity.actor.username} replied</p>"
    when "retweeted"
      "<p class=\"fw-bold mb-0 text-black-50\" style=\"font-size:0.8rem;margin-left:4.5rem\">#{tweet_activity.actor.username} retweeted</p>"
    else 
      ""
    end
  end
  

  def formatted_timestamp
    if (Time.zone.now - @tweet.created_at) < 1.day
      time_ago_in_words(@tweet.created_at) + ' ' + 'ago'
    else
      @tweet.created_at.in_time_zone('Taipei').strftime("%^b %e")
    end
  end

  def body_html
    texts = tweet.body.split(" ").map do |word|
      if word.include?("#") ||  word.include?("@")
        "<a class='text-decoration-none'>#{word}</a>"
      else
        word
      end
    end
    "#{texts.join(" ")}"
  end
  
  def self.build_collection(tweets, current_user)
    tweets.order(created_at: :desc).map do |tweet|
      new(tweet: tweet, current_user: current_user)
    end
  end

  # like
  def tweet_like_url(source: "tweet_card")
    if tweet_liked_by_current_user?
      tweet_like_path(@tweet, @current_user.likes.find_by(tweet: @tweet), source: source)
    else
      tweet_likes_path(@tweet, source: source)
    end
  end

  def turbo_data_like_method
    if tweet_liked_by_current_user?
      'delete'
    else
      'post'
    end
  end

  def like_heart_icon
    if tweet_liked_by_current_user?
      'fa-solid fa-heart'
    else
      'fa-regular fa-heart'
    end
  end

  
  # bookmark
  def tweet_bookmark_url(source: "tweet_card")
    if tweet_bookmarked_by_current_user?
      tweet_bookmark_path(@tweet, @current_user.bookmarks.find_by(tweet: @tweet), source: source)
    else
      tweet_bookmarks_path(@tweet, source: source)
    end
  end

  def turbo_data_bookmark_method
    if tweet_bookmarked_by_current_user?
      'delete'
    else
      'post'
    end
  end

  def bookmark_icon
    if tweet_bookmarked_by_current_user?
      'fa-solid fa-bookmark'
    else
      'fa-regular fa-bookmark'
    end
  end

  def bookmark_text
    if tweet_bookmarked_by_current_user?
      'Bookmarked'
    else
      'Bookmark'
    end
  end

  # retweet
  def tweet_retweet_url(source: "tweet_card")
    if tweet_retweeted_by_current_user?
      tweet_retweet_path(@tweet, @current_user.retweets.find_by(tweet: @tweet), source: source)
    else
      tweet_retweets_path(@tweet, source: source)
    end
  end

  def turbo_data_retweet_method
    if tweet_retweeted_by_current_user?
      'delete'
    else
      'post'
    end
  end



  def tweet_liked_by_current_user
    tweet_liked_by_current_user ||= tweet.liked_users.include?(@current_user)
  end
  alias_method :tweet_liked_by_current_user?, :tweet_liked_by_current_user

  def tweet_bookmarked_by_current_user
    tweet_bookmarked_by_current_user ||= tweet.bookmarked_users.include?(@current_user)
  end
  alias_method :tweet_bookmarked_by_current_user?, :tweet_bookmarked_by_current_user

  def tweet_retweeted_by_current_user
    tweet_retweeted_by_current_user ||= tweet.retweeted_users.include?(@current_user)
  end
  alias_method :tweet_retweeted_by_current_user?, :tweet_retweeted_by_current_user
end