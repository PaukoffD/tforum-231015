class Post < ActiveRecord::Base
 belongs_to :topic
 belongs_to :user
 delegate :forum, :to => :topic
 self.per_page = 15
 
 def entry_summary(chars=200)
    if summary.blank?
      "#{text[0...chars]}..."
    else
      summary
    end
  end
end
