class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :yt_id
      t.string :player_url
      t.string :title
      t.text :serialized_thumbnails
      t.boolean :is_complete , default: false
      t.references :user
      t.timestamps
    end
  end
end
