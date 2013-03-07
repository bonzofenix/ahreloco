class Video < ActiveRecord::Base
  belongs_to :user
  scope :top_today, order('arl_views_today DESC')
  scope :top_week, order('arl_views_week DESC')
  scope :top_month, order('arl_views_month DESC')
  scope :latest_published, order('published_at DESC')

  attr_accessible :video_id, :title, :thumbnails, :is_complete, :likes, :dislikes,
    :rater_count, :published_at, :arl_views_today, :arl_views_week, :arl_views_month,:view_count

  def thumbnails=(args)
    self.serialized_thumbnails = YAML::dump(args)
    @thumbnails = args
  end

  def thumbnails
    @thumbnails ||= YAML::load(self.serialized_thumbnails)
  end

  def hit_it!
    update_attributes( arl_views_today: arl_views_today + 1,
      arl_views_week: arl_views_week + 1, arl_views_month: arl_views_month + 1)
  end
  # to check: playlist id included in the video? 
  def self.parsed_attributes(video, playlist_id=nil)
    pa = {
      published_at: video.published_at,
      view_count: video.view_count,
      video_id: video.unique_id,
      thumbnails: get_thumbnails_from(video),
      title: video.title,
      playlist_id: playlist_id
    }
    if video.rating
      pa.merge({
        likes: video.rating.likes,
        dislikes: video.rating.dislikes,
        rater_count: video.rating.rater_count
      })
    end
    pa
  end

  def self.get_thumbnails_from(video)
    video.thumbnails.collect do |thumbnail|
      {}.tap do |h|
        h[:url] = thumbnail.url
        h[:height] = thumbnail.height
        h[:width] = thumbnail.width
      end
    end
  end
    

end
