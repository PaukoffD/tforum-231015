class Topic < ActiveRecord::Base
 belongs_to :forum
 belongs_to :author, class_name: User, foreign_key: "user_id"
 belongs_to :last_user, class_name: User, foreign_key: "last_id"
has_many :posts, :dependent => :destroy
accepts_nested_attributes_for :posts

self.per_page = 15

def last_topic_user
 topic=Topic.order(:created_at).last
 user=User.find(topic.last_id)
 user1 = user.name
 return user1
end


end
