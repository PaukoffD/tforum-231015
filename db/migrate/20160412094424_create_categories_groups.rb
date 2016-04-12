class CreateCategoriesGroups < ActiveRecord::Migration
  def change
    create_table :categories_groups do |t|
      t.integer :category_id
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
