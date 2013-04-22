class RemoveArtistFromProduct < ActiveRecord::Migration
  def up
    remove_column :products, :artist
  end

  def down
    add_column :products, :artist, :string
  end
end
