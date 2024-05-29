class RenameMessageThreadsUsersToMessageThreadsUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :message_thread_users, :message_threads_users
  end
end
