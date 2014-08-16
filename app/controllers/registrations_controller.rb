class RegistrationsController < Devise::RegistrationsController
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
	      u.permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation, profile_attributes: [:bio], status_attributes: [:content, :id])
	    end
	    devise_parameter_sanitizer.sanitize(:account_update) do |u|
	      u.permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, profile_attributes: [:bio], status_attributes: [:content, :id] )
	    end
	end
	def profile_params
      params.require(:profile).permit(:user_id, :bio)
    end
    def profile_params
      params.require(:status).permit(:status, :id)
    end

	
end
