class RegistrationsController < Devise::RegistrationsController
	skip_before_filter :require_no_authentication
  before_filter :authenticate_user!
	before_filter :configure_permitted_parameters, if: :devise_controller?
	def create
		super
		session[:omniauth] = nil unless @user.new_record?

	end

	private

	def build_resource(*args)
		super
		  if session[:omniauth]
		      @user.apply_omniauth(session[:omniauth])
		      @user.valid?
		    end


	end
	protected

	def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) do |u|
	      u.permit(:first_name, :last_name, :user_name, :email, :password)
	    end
	    devise_parameter_sanitizer.for(:account_update) do |u|
	      u.permit(:first_name, :last_name, :username, :email, :password, :profile, :current_password)
	    end

	end
	

	
end
