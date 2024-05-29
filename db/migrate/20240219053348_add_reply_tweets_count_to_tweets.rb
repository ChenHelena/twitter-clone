class AddReplyTweetsCountToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :reply_tweets_count, :integer, null: false, default: 0
  end
end
