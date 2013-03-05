class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :video_id
      t.string :comment_id
      t.string :content
      t.string :reply_to
      t.string :username
      t.datetime :updated
      t.timestamps
    end
  end
end
