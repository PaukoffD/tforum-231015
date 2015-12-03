class AddCountMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :count_message, :integer
  end
end
