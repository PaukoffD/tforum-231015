class AddCountMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_message, :integer,  default: 0,     null: false
	
  end
end
