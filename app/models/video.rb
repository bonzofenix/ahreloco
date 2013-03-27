class Video < ActiveRecord::Base
  belongs_to :user
  scope :top_today, order('arl_views_today DESC')
  scope :top_week, order('arl_views_week DESC')
  scope :top_month, order('arl_views_month DESC')
  scope :with_program, joins(user:[ :programs])
  scope :from_community, joins("INNER JOIN \"users\" ON \"users\".\"id\" = \"videos\".\"user_id\" FULL OUTER JOIN \"programs_users\" ON \"programs_users\".\"user_id\" = \"users\".\"id\"")
    .where("\"programs_users\".\"user_id\" IS NULL" )

  scope :latest_published, order('published_at DESC')

  attr_accessible :video_id, :title, :is_complete, :likes, :dislikes, :playlist_id,
    :rater_count, :published_at, :arl_views_today, :arl_views_week, :arl_views_month,:view_count,
    :user_id

  
  def update_with(video)
    params = self.class.parsed_attributes(video)
    update_attributes(params)
  end

  def small_thumb
    "http://i2.ytimg.com/vi/#{video_id}/mqdefault.jpg"
  end

  def big_thumb
    "http://i2.ytimg.com/vi/#{video_id}/hqdefault.jpg"
  end
    
  def hit_it!
    update_attributes( arl_views_today: arl_views_today + 1,
      arl_views_week: arl_views_week + 1, arl_views_month: arl_views_month + 1)
  end

  # to check: playlist id included in the video? 
  def self.parsed_attributes(video)
    pa = {
      published_at: video.published_at,
      view_count: video.view_count,
      video_id: video.unique_id,
      title: video.title
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
end
