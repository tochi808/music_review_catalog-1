class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :genre
      t.string :artist

      t.timestamps
    end
  end
end
