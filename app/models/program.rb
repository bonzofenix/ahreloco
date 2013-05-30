class Program < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :avatar_url, :user_ids
  has_many :videos, through: :users
  
  def latest_video 
    videos.latest_published.first
  end

  def self.latest_videos
    all.collect {|p| p.latest_video }.compact.sort{ |a,b| a.published_at <=> b.published_at }
  end
end
