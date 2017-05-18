class ChangeClassNameAgainInChildren < ActiveRecord::Migration
  def change
    rename_column :children, :class, :classroom
  end
end
