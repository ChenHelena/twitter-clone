class CreateFollowings < ActiveRecord::Migration[6.1]
  def change
    create_table :followings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :following_user, null: false, foreign_key: { to_table: :users }

      t.index [:user_id, :following_user_id], unique: true
      t.timestamps
    end
  end
end
