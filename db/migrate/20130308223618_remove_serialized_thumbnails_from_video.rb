class RemoveSerializedThumbnailsFromVideo < ActiveRecord::Migration
  def change
    remove_column :videos, :serialized_thumbnails
  end
end
