class DropMemberships < ActiveRecord::Migration
  def up
  	drop_table :memberships
  end

  def down
  	raise ActiveRecord::IrreversibleMigration
  end
end
