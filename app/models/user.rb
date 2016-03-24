class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
		 has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#",original: ['500x500>', :jpg] }, :default_url => "/images/:style/anonyme.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :name, presence: true, length: { minimum: 3  }
  validates_confirmation_of :password
end
