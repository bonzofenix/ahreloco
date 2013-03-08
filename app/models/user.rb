class User < ActiveRecord::Base
 extend FriendlyId
  friendly_id :username, use: :slugged
  has_and_belongs_to_many :programs
  has_many :videos
  attr_accessible :mail, :name, :provider, :uid, :subscribers_count  


  def add_videos(new_videos, playlist_id = nil)
    new_videos.each do |a_video|
      unless videos.exists? video_id: a_video.unique_id or a_video.published_at.nil?
        params = Video.parsed_attributes(a_video)
        params.merge!({ playlist_id: playlist_id }) if playlist_id
        videos.create!(params)
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
