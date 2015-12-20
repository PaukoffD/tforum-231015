class Forum < ActiveRecord::Base
 belongs_to :category

 has_many :topics, :dependent => :destroy
 has_many :posts,      :through => :topics, :dependent => :destroy
 extend FriendlyId
 friendly_id :name, use: :slugged
 self.per_page = 15
 
 def most_recent_post
  topic = Topic.order("created_at DESC")
 return topic
end

def last_topic
 topics.order(:created_at).last
end

def last_topic_user
 topic=topics.order(:created_at).last
 user=User.find(topic.user_id)
 user1 = user.name
 return user1
end
 
def count_post
 topic = Topic.where(forum_id:id)
 post=posts.count
 return post
end

def count_reply
 count = Topic.where(forum_id:id).sum(:views_count)
 return count
end 

 

end
