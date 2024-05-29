class RenameColumnInHashtagsTweets < ActiveRecord::Migration[6.1]
  def change
    rename_column :hashtags_tweets, :Hashtag_id, :hashtag_id
  end
end
