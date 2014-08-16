class MembershipsController < ApplicationController
	before_filter :authenticate_user!, only: [:new]

	def new
		 	@group = Group.find params[:group_id]
      		@membership = Membership.new({group: group})
		end


		def create
      		@group = Group.find params[:group_id]
      		@membership = Membership.create(:user_id => current_user.id, :group_id => @group.id )
      		if @membership.save
      			flash[:notice] = "You are now a member of this group"
      			redirect_to @group
      		else
      			flash[:alert] = "You are already a member of this group!"
      			redirect_to @group
    		end
    	end

    	def destroy
    		@group = Group.find params[:group_id]
    		@user = current_user
    		
    		@group.users.destroy(params[:id])
    		if true
    			flash[:notice] = "You have left the building!"
      			redirect_to root_path
      		else
      			flash[:alert] = "Hmmmm, try that again!"
      			redirect_to @group
    		end
    	
    	end


	private
    # Use callbacks to share common setup or constraints between actions.
    def set_membership
      @membership = Membership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def membership_params
       params.require(:membership).permit( :group_id, :user_id)
    end

end
