class AddCheckInDateToHires < ActiveRecord::Migration
  def change
    add_column :hires, :checkedin, :datetime
  end
end
