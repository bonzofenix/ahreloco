class User < ActiveRecord::Base
  has_many :videos
  attr_accessible :mail, :name, :provider, :uid
  
  def add_videos(new_videos)
    new_videos.each do |a_video|
      unless videos.exists? yt_id: a_video.unique_id
        videos.create!( yt_id: a_video.unique_id ,
          player_url: a_video.player_url,
          thumbnails: get_thumbnails_from(a_video),
          title: a_video.title)
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

  class << self
    def find_for_youtube(auth)
       user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
       user ||= User.create_with_omniauth(auth)
    end

    def create_with_omniauth(auth)
      create! do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["nickname"]
      end
    end
  end
end
