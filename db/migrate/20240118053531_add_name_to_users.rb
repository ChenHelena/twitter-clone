class AddNameToUsers < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :name, :string
    User.where(name: [nil, '']).update_all('name = username')
  end

  def down
    remove_column :users, :name
  end
end
