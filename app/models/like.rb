class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :status
	validates :liker_id, presence: true
  validates :liked_id, presence: true
end
