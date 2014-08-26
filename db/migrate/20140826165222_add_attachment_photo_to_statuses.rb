class AddAttachmentPhotoToStatuses < ActiveRecord::Migration
  def self.up
    change_table :statuses do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :statuses, :photo
  end
end
