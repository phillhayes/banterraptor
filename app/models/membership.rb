class Membership < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
	validates_uniqueness_of :user_id, :alert => "can be only joined once", :scope => 'group_id'
	validate :membership_quota, :on => :create  
has_reputation :likes, source: {reputation: :likes, of: :statuses, scope: :memberships }, aggregated_by: :sum
  def membership_quota
    if user
     if user.memberships.count >= 3
       errors.add(:base, "You are already a member of 3 groups")
       
     end
   end
  end

	def group_name
    if self.group
      @group_name ||= self.group.name
    end
  end

  def group_name=(group_name)
    @group_name = group_name

    self.group = Group.find_by_name(@group_name)
  end

  def self.is_member_of(user)
     Membership.joins(:user).where([:user_id, :group_id]).all
  end
end
