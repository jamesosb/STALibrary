class CreateHires < ActiveRecord::Migration
  def change
    create_table :hires do |t|
      t.string :book
      t.string :child

      t.timestamps null: false
    end
  end
end
