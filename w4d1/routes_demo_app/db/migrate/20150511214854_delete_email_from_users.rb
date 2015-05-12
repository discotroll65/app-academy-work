class DeleteEmailFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :email
  end

  def down
    add_column :users, :email, :text
  end
end
