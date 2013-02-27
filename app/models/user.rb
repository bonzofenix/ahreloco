class User < ActiveRecord::Base
 extend FriendlyId
  friendly_id :username, use: :slugged
  has_and_belongs_to_many :programs
  has_many :videos
  attr_accessible :mail, :name, :provider, :uid, :subscribers_count  
  def add_videos(new_videos)
    new_videos.each do |a_video|
      unless videos.exists? video_id: a_video.unique_id
        videos.create! do |v|
          v.published_at = a_video.published_at
          v.view_count = a_video.view_count
          v.video_id = a_video.unique_id 
          v.thumbnails = get_thumbnails_from(a_video)
          v.title = a_video.title
          if a_video.rating
            v.likes = a_video.rating.likes
            v.dislikes = a_video.rating.dislikes
            v.rater_count = a_video.rating.rater_count
          end
        end
      end
    end
  end

  def get_thumbnails_from(video)
    video.thumbnails.collect do |thumbnail|
      {}.tap do |h|
        h[:url] = thumbnail.url
        h[:height] = thumbnail.height
        h[:width] = thumbnail.width
      end
    end
  end
    

  def likes
    videos.sum('likes')
  end

  def dislikes
    videos.sum('dislikes')
  end

  def update_youtube_attributes(auth)
    update_attributes!( subscribers_count: auth['info']['subscribers_count'])
  end
  class << self
    def find_for_youtube(auth)
       user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
       user ||= User.create_with_omniauth(auth)
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth['provider']
        user.uid = auth['uid']
        user.avatar_url = auth['info']['image']
        user.subscribers_count = auth['info']['subscribers_count']
        user.username = auth.extra.user_hash.send('yt$username').send('$t')
      end
    end
  end
end
