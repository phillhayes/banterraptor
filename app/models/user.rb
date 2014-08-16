class User < ActiveRecord::Base
	has_many :authentications
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships
  has_one :profile, :dependent => :destroy
  has_many :statuses, :dependent => :destroy
  

  
  before_create :create_profile

  

	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

 	def full_name
    first_name + " " + last_name
  end

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  def feed
    Status.from_groups_member_of(self)
  end

 


  def group_feed
    # This is preliminary. See "Following users" for the full implementation.
    Status.all


  end

  def my_groups
    Group.is_member_of(self)
  end


end
