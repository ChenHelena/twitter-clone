class ChangeMessageThreadIdInMessageThreadUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :message_thread_users, :message_id, :message_thread_id
  end
end
