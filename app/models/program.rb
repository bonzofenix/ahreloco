class Program < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :avatar_url, :user_ids
  has_many :videos, through: :users
  
  def latest_video 
    videos.latest_published.first
  end

  def self.latest_videos
    all.collect {|p| p.latest_video }.compact.sort{ |a,b| b.published_at <=> a.published_at  }
  end
end
