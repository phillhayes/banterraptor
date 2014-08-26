class Status < ActiveRecord::Base
	belongs_to :user
	belongs_to :group
  	default_scope -> { order('created_at DESC') }
  	validates_presence_of :content
  	has_reputation :likes, source: :user, aggregated_by: :sum, :scopes => [:group]
    has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  	
  def self.from_groups_member_of(user)
    member_group_ids = "SELECT group_id FROM memberships WHERE user_id = :user_id"
    where("group_id IN (#{member_group_ids})", user_id: user.id )
  end
end
