class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets, dependent: :destroy
  has_one_attached :avatar
  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_tweets, through: :bookmarks, source: :tweet
  has_many :retweets, dependent: :destroy
  has_many :retweeted_tweets, through: :retweets, source: :tweet
  has_many :views, dependent: :destroy
  has_many :viewed_tweets, through: :views, source: :tweet
  has_many :followings, dependent: :destroy
  has_many :following_users, through: :followings, source: :following_user
  has_many :reverse_followings,foreign_key: :following_user_id, class_name: "Following", dependent: :destroy
  has_many :followers, through: :reverse_followings, source: :user
  has_many :messages
  has_many :notifications, dependent: :destroy
  has_many :tweet_activities, dependent: :destroy
  
  has_and_belongs_to_many :message_threads

  validates :username, uniqueness: { case_sensitive: false }, allow_blank: true
  
  before_save :set_name_from_username, if: -> { username.present? && name.blank? }
  def set_name_from_username
    self.name = username.humanize
  end
end
