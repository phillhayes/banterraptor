class AddFieldsToMemberships < ActiveRecord::Migration
  def self.up
    add_column :memberships, :sash_id, :integer
    add_column :memberships, :level, :integer, :default => 0
  end

  def self.down
    remove_column :memberships, :sash_id
    remove_column :memberships, :level
  end
end
