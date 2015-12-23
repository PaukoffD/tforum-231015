class RemoveCountMessageFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :count_message, :integer
  end
end
