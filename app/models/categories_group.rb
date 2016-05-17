class CategoriesGroup < ActiveRecord::Base
  validates :group_id, uniqueness: true
end
