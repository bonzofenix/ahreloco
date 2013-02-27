class Program < ActiveRecord::Base
  has_and_belongs_to_many :users
  attr_accessible :name, :avatar_url, :user_ids
  has_many :videos, through: :users
  has_many :videos, through: :users

  def lattest_video
    videos.order('published_at DESC').first
  end
end
