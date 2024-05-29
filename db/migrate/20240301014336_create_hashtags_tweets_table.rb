class CreateHashtagsTweetsTable < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtags_tweets, id: false do |t|
      t.belongs_to :tweet
      t.belongs_to :Hashtag
      
      t.timestamps
    end
  end
end
