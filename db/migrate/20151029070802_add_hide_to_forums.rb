class AddHideToForums < ActiveRecord::Migration
  def change
    add_column :forums, :hidden, :boolean
  end
end
