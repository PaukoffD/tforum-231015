class Category < ActiveRecord::Base
  has_many :forums, dependent: :destroy
  has_and_belongs_to_many :groups

  scope :hidden, -> { where hidden: true }
  scope :visible, -> { where hidden: false }
end
