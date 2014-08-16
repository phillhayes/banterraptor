class AddIndexToMemberships < ActiveRecord::Migration
  def change
    add_index :memberships, [:user_id, :group_id]
  end

  
end
