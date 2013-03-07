class AddPlaylistIdToVideo < ActiveRecord::Migration
  def change
    add_column :videos,  :playlist_id, :string
  end
end
