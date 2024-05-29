class AddParentTweetToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :parent_tweet_id, :bigint, index: true
    add_foreign_key :tweets, :tweets, column: :parent_tweet_id
  end
end
