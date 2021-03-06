class Forum < ActiveRecord::Base
  belongs_to :category

  has_many :topics, dependent: :destroy
  has_many :posts, through: :topics, dependent: :destroy
  
  validates :name, presence: true, length: { minimum: 5, too_short: "мало символов в заголовке" }
  extend FriendlyId
  friendly_id :name, use: :slugged
  self.per_page = 15

  def most_recent_post
    topics = Topic.order('created_at DESC')
    topic
 end

  def last_topic
    topics.order(:created_at).last
  end

  def last_topic_user
    topic = topics.order(:created_at).last
    user = User.find(topic.user_id)
    user1 = user.name
    user1
  end

  def count_post
    topic = Topic.where(forum_id: id)
    post = posts.count
    post
  end

  def count_reply
    count = Topic.where(forum_id: id).sum(:views_count)
    count
  end
end
