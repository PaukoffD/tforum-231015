class Group < ActiveRecord::Base
  validates :name, presence: true

  # has_many :memberships
  has_and_belongs_to_many :users
  has_and_belongs_to_many :categories
end
