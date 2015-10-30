class AddPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private, :integer
  end
end
