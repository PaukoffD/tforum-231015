class Category < ActiveRecord::Base
has_many :forums, :dependent => :destroy
has_and_belongs_to_many :groups
end
