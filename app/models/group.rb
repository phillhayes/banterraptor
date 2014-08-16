class Group < ActiveRecord::Base
	belongs_to :user
	has_many :memberships, :dependent => :destroy
	has_many :statuses
	has_many :users, :through => :memberships
	validates :user_id, presence: true
	
	default_scope -> { order('created_at DESC') }
	validate :user_quota, :on => :create  

  def user_quota
   if user.groups.count >= 3
     errors.add(:base, "You are already a member of 3 groups")
     
   end
  end
def is_member?(user)
   if user.memberships.include? self.id
     return true
   else
     return false
  end
end
  
  	
	def new_status_attributes=(status_attributes)
		status_attributes.each do |attributes|
		statuses.build(attributes)
		end
	end
def self.is_member_of(user)
    member_group_ids = "SELECT group_id FROM memberships WHERE user_id = :user_id"
    where("group_id IN (#{member_group_ids}) OR user_id = :user_id", user_id: user.id )
  end
	
  
end

public

def all_groups
    Group.is_member_of(self)
  end
