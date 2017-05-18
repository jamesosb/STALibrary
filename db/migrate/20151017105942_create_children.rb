class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :nickname
      t.string :forename
      t.string :surname
      t.string :UPN
      t.string :Class

      t.timestamps null: false
    end
  end
end
