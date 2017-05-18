class ChangeClassNameInChildren < ActiveRecord::Migration
  def change
    rename_column :children, :Class, :class
  end
end
