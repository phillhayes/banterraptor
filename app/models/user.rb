class User < ActiveRecord::Base
	has_many :authentications
  has_many :memberships
  has_many :groups
  has_one :profile, :dependent => :destroy
  has_many :statuses
  accepts_nested_attributes_for :profile, :allow_destroy => true
  
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

end
