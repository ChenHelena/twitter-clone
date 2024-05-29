class AddMessageThreadsReferenceToMessages < ActiveRecord::Migration[6.1]
  def change
    add_reference :messages, :message_thread, null: false, foreign_key: true
  end
end
