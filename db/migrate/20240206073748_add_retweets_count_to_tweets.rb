class AddRetweetsCountToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :retweets_count, :integer, null: false, default: 0
  end
end
