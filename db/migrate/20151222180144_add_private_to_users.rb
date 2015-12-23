class AddPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private, :integer, :null => false, :default => 0
	add_column :users, :count_message, :integer, :null => false, :default => 0
  end
end
