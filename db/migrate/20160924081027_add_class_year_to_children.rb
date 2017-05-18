class AddClassYearToChildren < ActiveRecord::Migration
  def change
    add_column :children, :class_year, :string
  end
end
