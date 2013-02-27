class Video < ActiveRecord::Base
  belongs_to :user
  attr_accessible :video_id, :title, :thumbnails, :is_complete, :likes, :dislikes, :rater_count, :published_at

  def thumbnails=(args)
    self.serialized_thumbnails = YAML::dump(args)
    @thumbnails = args
  end

  def thumbnails
    @thumbnails ||= YAML::load(self.serialized_thumbnails)
  end
end
