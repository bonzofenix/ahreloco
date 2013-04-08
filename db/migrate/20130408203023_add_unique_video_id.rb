class AddUniqueVideoId < ActiveRecord::Migration
  def up
    add_index(:videos, :video_id, unique: true)
  end

  def down
    remove_index(:videos, column: :video_id)
  end
end
