class StatusesController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_action :set_status, only: [:show, :edit, :update, :destroy]


  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all
  end

   def status
    @user = User.find_by_user_name(params[:id])
  
  end 

   def user
    @user = current_user
  end 
  def group
     @group = Group.find(params[:group_id])
  end 


  # GET /statuses/1
  # GET /statuses/1.json
  def show
  end

  # GET /statuses/new
  def new
    @status = Status.new
  end

  # GET /statuses/1/edit
  def edit
  end

  def like
    value = params[:type] == "up" ? 1 : -1
    @status = Status.find(params[:id])
    @user = @status.user
    @status.add_or_update_evaluation(:likes, value, current_user, :group)
    redirect_to :back, notice: "Thanks for rating Banter!"
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @group = Group.find(params[:group_id])
  if group.users.include? current_user
    @status = @group.statuses.build(status_params.merge(:user_id => current_user.id))
      if @status.save
        flash[:notice] = "Banter Posted!"
        redirect_to @group
      elsif @status.content
        flash[:alert] = "Your banter was empty. That's not cool!"
        redirect_to @group
      else
        flash[:alert] = "You aren't a member of this group"
        redirect_to @group
      end
    else
      flash[:alert] = 'You arent a member of this group - click "Join" to get started'
      redirect_to @group 
    end
  end

  # PATCH/PUT /statuses/1
  # PATCH/PUT /statuses/1.json
  def update
     respond_to do |format|
      if @status.update_attributes(status_params)
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Banter was deleted' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
     @status = current_user.statuses.find(params[:id])
     

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def status_params
      params.require(:status).permit(:content, :group_id, :user_id, :photo)
    end

end
