class Post < ActiveRecord::Base
 belongs_to :topic
 belongs_to :user
 delegate :forum, :to => :topic
end
