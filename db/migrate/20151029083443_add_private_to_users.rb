class AddPrivateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :private, :integer,  default: 0,     null: false
  end
end
