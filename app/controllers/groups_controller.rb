class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
    @membership = Membership.new
    @user = current_user
  end

   

  def join
    @group = Group.find(params[:id])
    @m = @group.memberships.build(:user_id => current_user.id)
      if @m.save
        flash[:notice] = 'You have joined this group.'
        redirect_to @group
      else
        if !@group.user_quota
          flash[:alert] = "There was a problem joining this group. Check back later"
          redirect_to @group
        else
          flash[:alert] = 'You have joined too many groups - try again later'
          redirect_to @group
        end
      end
  
  end
  
  def user
    @group = Group.find(params[:id])
    @user = @user.group
  end 

  # GET /groups/1
  # GET /groups/1.json

  def status
    @user = User.find(params[:id])
    @status = @user.status
  end 
def group
     @group = Group.find(params[:id])
  end 
 


  def show
    @membership = Membership.new
    @user = current_user
    @group = Group.find(params[:id])
    if group.users.include? current_user
      @status = Status.new
      @group = Group.find(params[:id])
      

    else
      if @user.memberships.count >= 3
        flash[:alert] = "You have joined too many groups! Leave a group to proceed"
        redirect_to root_path
      else
        flash[:alert] = "You aren't a member"
      end
      
    end
    

    
  end

  # GET /groups/new
  def new
    @group = Group.new
   @group.statuses.build
    
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = current_user.groups.build(group_params.merge(:user_id => current_user.id))
    @m = @group.memberships.build(:user_id => current_user.id)
      if @group.save && @m.save
        flash[:notice] = "Group created!"
        redirect_to root_url
      else
        flash[:alert] = "You are already a member of too many groups. Leave one to proceed."
        redirect_to root_path
      end
    end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :group_id, :user_id, new_status_attributes: [:group_id, :content, :user_id])
    end
end
