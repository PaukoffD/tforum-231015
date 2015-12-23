class RemovePrivateFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :private, :integer
  end
end
