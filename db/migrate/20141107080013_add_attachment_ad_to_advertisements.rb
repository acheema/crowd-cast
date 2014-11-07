class AddAttachmentAdToAdvertisements < ActiveRecord::Migration
  def self.up
    change_table :advertisements do |t|
      t.attachment :ad
    end
  end

  def self.down
    remove_attachment :advertisements, :ad
  end
end
