class ArlManager
  attr_accessor :client

  def initialize
    @client = YouTubeIt::Client.new(username:  ENV['ARL_USERNAME'],
      password: ENV['ARL_PASSWORD'], dev_key: ENV['DEV_KEY'])
  end
  
  def playlist_name
    "concurso semana #{Date.today.cweek} del #{Date.today.year}"
  end
  
  def add_video_to_week_playlist(video)
    client.add_video_to_playlist(playlist.playlist_id, video.video_id)
  end

  def check_new_videos_for(user)
    videos = @client.videos_by(user: user.username).videos
    user.add_videos(videos)
  end

  def week_videos
    Video.where("playlist_id = '#{playlist.playlist_id}'").all.shuffle
  end

  
  def scroll_playlist_videos
    arl_user.add_videos(playlist.videos)
  end
  
  def arl_user
    User.find_by_username( ENV['ARL_USERNAME'] )
  end

  private   
  def playlist
    find_or_create_playlist
  end

  def find_or_create_playlist
    playlist = @client.playlists.select{ |p| p.title == playlist_name }
    playlist = playlist.first if playlist
    playlist ||= client.add_playlist(title: playlist_name)
  end
end
