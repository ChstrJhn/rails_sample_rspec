class Micropost < ActiveRecord::Base
	belongs_to :user
	validates :user_id, :content, presence: true
	validates :content, presence: true, length: { maximum: 140 }
end
