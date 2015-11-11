class PrivatePost < ActiveRecord::Base
 belongs_to :user
 belongs_to :sent_user, class_name: User, foreign_key: "user_id_sent"
 self.per_page = 15
end
