class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :title
      t.string :youtube_id
      t.timestamps
    end
  end
end
