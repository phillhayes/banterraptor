class AddGroupIdToStatuses < ActiveRecord::Migration
  def change
  	add_column :statuses, :group_id, :integer
  	add_index :statuses, :group_id
  	

  end
end
