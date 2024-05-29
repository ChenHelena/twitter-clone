class Tweet < ApplicationRecord
  HASHTAG_REGEX = /(#\w+)/

  # relationships
  belongs_to :user

  # validations
  validates :body, presence: true, length: { maximum: 280 }
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user
  has_many :views, dependent: :destroy
  has_many :viewed_users, through: :views, source: :user
  has_and_belongs_to_many :hashtags
  belongs_to :parent_tweet, 
  class_name: "Tweet", 
  foreign_key: "parent_tweet_id", 
  optional: true, 
  inverse_of: :reply_tweets,
  counter_cache: :reply_tweets_count 
  has_many :reply_tweets, class_name: "Tweet", foreign_key: "parent_tweet_id", dependent: :destroy, inverse_of: :parent_tweet
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions, source: :user
  has_many :tweet_activities, dependent: :destroy

  before_save :parse_and_save_hashtags
  def parse_and_save_hashtags
    matches = body.scan(HASHTAG_REGEX)
    return if matches.empty?

    matches.flatten.each do |tag|
      hashtag = Hashtag.find_or_create_by(tag: tag.delete("#").downcase)
      hashtags << hashtag
    end
  end

  after_save :parse_and_save_mentions
  def parse_and_save_mentions
    matches = body.scan(/(@\w+)/)
    return if matches.empty?
    
    matches.flatten.each do |mention|
      mentioned_user = User.find_by(username: mention.delete("@"))
      next if mentioned_user.blank?

      next if mentions.exists?(mentioned_user: mentioned_user)

      mentions.create(mentioned_user: mentioned_user, tweet: self)

      Notification.create(user: mentioned_user, actor: user, verb: "mentioned-me", tweet: self)
    end
  end

  def self.show_more_available?(latest_tweet_id)
    latest_tweet_id.nil? || where("id < ?", latest_tweet_id).exists?
  end
end
