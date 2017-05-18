class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.references :genre
      t.string :ISBN

      t.timestamps null: false
    end
  end
end
