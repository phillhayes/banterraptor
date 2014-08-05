class Group < ActiveRecord::Base
	belongs_to :user
	has_many :memberships
	has_many :statuses
	has_many :users, :through => :memberships
	validates :user_id, presence: true
  	accepts_nested_attributes_for :user, :allow_destroy => true
end
