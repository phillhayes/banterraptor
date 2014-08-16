class StaticPagesController < ApplicationController
  def home
  	@group = Group.new
   

  end

  def about
  end

  def group_page
  	@status = Status.new
  	@feed_items = current_user.group_feed
  	
  end

 


end
