class ArlManager
  attr_accessor :client

  def initialize
    @client = YouTubeIt::Client.new(username:  ENV['ARL_USERNAME'],
      password: ENV['ARL_PASSWORD'], dev_key: ENV['DEV_KEY'])
  end
  
  def add_video_to_week_playlist(video)
    title = "concurso semana #{Date.today.cweek} del #{Date.today.year}"
    playlist = find_or_create_playlist(title)
    client.add_video_to_playlist(playlist.playlist_id, video.video_id)
  end

  def check_new_videos_for(user)
    videos = @client.videos_by(user: user.username).videos
    user.add_videos(videos)
  end

  private   
  def find_or_create_playlist(title)
    playlist = @client.playlists.select{ |p| p.title == title }
    playlist = playlist.first if playlist
    playlist ||= client.add_playlist(title: title )
  end
end
