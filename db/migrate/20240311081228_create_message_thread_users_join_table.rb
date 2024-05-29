class CreateMessageThreadUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_table :message_thread_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :message
      
      t.timestamps
    end
  end
end
