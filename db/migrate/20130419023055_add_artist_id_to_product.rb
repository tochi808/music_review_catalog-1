class AddArtistIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :artist_id, :integer
  end
end
