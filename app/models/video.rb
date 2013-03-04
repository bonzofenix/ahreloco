class Video < ActiveRecord::Base
  belongs_to :user
  scope :top_today, order('arl_views_today DESC')
  scope :top_week, order('arl_views_week DESC')
  scope :top_month, order('arl_views_month DESC')
  scope :latest_published, order('published_at DESC')

  attr_accessible :video_id, :title, :thumbnails, :is_complete, :likes, :dislikes,
    :rater_count, :published_at, :arl_views_today, :arl_views_week, :arl_views_month

  def thumbnails=(args)
    self.serialized_thumbnails = YAML::dump(args)
    @thumbnails = args
  end

  def thumbnails
    @thumbnails ||= YAML::load(self.serialized_thumbnails)
  end

  def hit_it!
    update_attributes( arl_views_today: arl_views_today + 1,
      arl_views_week: arl_views_week + 1, arl_views_month: arl_views_month + 1,
    )
  end
end
