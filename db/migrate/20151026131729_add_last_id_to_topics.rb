class AddLastIdToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_id, :integer
  end
end
