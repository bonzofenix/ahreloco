class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :video_id
      t.string :title
      t.datetime :published_at
      t.integer :likes, default: 0
      t.integer :dislikes, default: 0
      t.integer :rater_count, default: 0
      t.integer :view_count, default: 0
      t.integer :arl_views_today, default: 0
      t.integer :arl_views_week, default: 0
      t.integer :arl_views_month, default: 0
      t.integer :arl_views, default: 0
      t.boolean :is_complete , default: false
      t.references :user
      t.timestamps
    end
  end
end
