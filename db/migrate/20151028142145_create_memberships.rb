class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :forum_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
