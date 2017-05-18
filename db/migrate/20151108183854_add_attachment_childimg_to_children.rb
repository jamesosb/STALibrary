class AddAttachmentChildimgToChildren < ActiveRecord::Migration
  def self.up
    change_table :children do |t|
      t.attachment :childimg
    end
  end

  def self.down
    remove_attachment :children, :childimg
  end
end
