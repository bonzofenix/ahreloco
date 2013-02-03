class Video < ActiveRecord::Base
  attr_accessible :player_url, :yt_id, :title, :thumbnails, :is_complete

  def thumbnails=(args)
    self.serialized_thumbnails = YAML::dump(args)
    @thumbnails = args
  end

  def thumbnails
    @thumbnails ||= YAML::load(self.serialized_thumbnails)
  end

end
