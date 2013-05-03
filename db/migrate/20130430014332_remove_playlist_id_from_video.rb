class RemovePlaylistIdFromVideo < ActiveRecord::Migration
  def up
    remove_column :videos, :playlist_id

  end

  def down
    add_column :videos, :playlist_id, :string
  end
end
