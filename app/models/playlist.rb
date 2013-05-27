class Playlist < ActiveRecord::Base
  has_many :videos
  attr_accessible :title, :youtube_id

  def winner_video 
    videos.order('view_count DESC').first
  end

  def self.last_week
    Playlist.all[-2]
  end
end
