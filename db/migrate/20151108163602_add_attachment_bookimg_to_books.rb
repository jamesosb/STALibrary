class AddAttachmentBookimgToBooks < ActiveRecord::Migration
  def self.up
    change_table :books do |t|
      t.attachment :bookimg
    end
  end

  def self.down
    remove_attachment :books, :bookimg
  end
end
