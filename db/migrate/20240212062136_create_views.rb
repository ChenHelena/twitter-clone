class CreateViews < ActiveRecord::Migration[6.1]
  def change
    create_table :views do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.index [:user_id, :tweet_id], unique: true
      
      t.timestamps
    end
  end
end
