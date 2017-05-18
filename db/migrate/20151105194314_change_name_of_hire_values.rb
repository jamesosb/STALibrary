class ChangeNameOfHireValues < ActiveRecord::Migration
  def change
    change_table :hires do |t|
      t.remove :book, :child
      t.string :book_id
      t.string :child_id
    end
  end
end
